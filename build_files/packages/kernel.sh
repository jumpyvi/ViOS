#!/usr/bin/bash
set -eoux pipefail

# Adds the longterm kernel repo
dnf5 copr enable -y kwizart/kernel-longterm-6.12

# Remove useless kernels
readarray -t OLD_KERNELS < <(rpm -qa 'kernel-*')
if (( ${#OLD_KERNELS[@]} )); then
    rpm -e --justdb --nodeps "${OLD_KERNELS[@]}"
    dnf5 versionlock delete "${OLD_KERNELS[@]}" || true
    rm -rf /usr/lib/modules/*
    rm -rf /lib/modules/*
fi

# Install kernel packages (noscripts required for 43+)
dnf5 install -y \
    --enablerepo="copr:copr.fedorainfracloud.org:kwizart:kernel-longterm-6.12" \
    --allowerasing \
    --setopt=tsflags=noscripts \
    kernel-longterm kernel-longterm-devel kernel-longterm-core kernel-longterm-modules kernel-longterm-modules-extra

KERNEL_VERSION="$(rpm -q --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n' kernel-longterm)"

# Depmod (required for fedora 43+)
depmod -a "${KERNEL_VERSION}"

# Copy vmlinuz
VMLINUZ_SOURCE="/usr/lib/kernel/vmlinuz-${KERNEL_VERSION}"
VMLINUZ_TARGET="/usr/lib/modules/${KERNEL_VERSION}/vmlinuz"
if [[ -f "${VMLINUZ_SOURCE}" ]]; then
    cp "${VMLINUZ_SOURCE}" "${VMLINUZ_TARGET}"
fi

# Lock kernel packages
dnf5 versionlock add "kernel-longterm-${KERNEL_VERSION}" || true

# Thank you @renner03 for this part
export DRACUT_NO_XATTR=1
dracut --force \
  --no-hostonly \
  --kver "${KERNEL_VERSION}" \
  --add-drivers "btrfs nvme xfs ext4" \
  --reproducible -v --add ostree \
  -f "/usr/lib/modules/${KERNEL_VERSION}/initramfs.img"

chmod 0600 "/lib/modules/${KERNEL_VERSION}/initramfs.img"