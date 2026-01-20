#!/usr/bin/bash
set -eoux pipefail

# Adds the kwizart longterm 6.12 kernel repo
dnf5 copr enable -y kwizart/kernel-longterm-6.12

# Remove existing kernels to prevent conflicts in the DB
readarray -t OLD_KERNELS < <(rpm -qa 'kernel-*' | grep -v 'kernel-longterm')
if (( ${#OLD_KERNELS[@]} )); then
    rpm -e --justdb --nodeps "${OLD_KERNELS[@]}"
    dnf5 versionlock delete "${OLD_KERNELS[@]}" || true
    rm -rf /usr/lib/modules/*
    rm -rf /lib/modules/*
fi

# Install kwizart kernel packages using the specific "longterm" naming convention
dnf5 install -y \
    --enablerepo="copr:copr.fedorainfracloud.org:kwizart:kernel-longterm-6.12" \
    --allowerasing \
    --setopt=tsflags=noscripts \
    kernel-longterm \
    kernel-longterm-core \
    kernel-longterm-modules \
    kernel-longterm-modules-extra \
    kernel-longterm-devel

# Extract the version from the specific longterm package
KERNEL_VERSION="$(rpm -q --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n' kernel-longterm-core | head -n 1)"

# Generate module dependencies (required for Fedora 43+ / noscripts installs)
depmod -a "${KERNEL_VERSION}"

# Copy vmlinuz to the modules directory for the bootloader to find
VMLINUZ_SOURCE="/lib/modules/${KERNEL_VERSION}/vmlinuz"
VMLINUZ_TARGET="/usr/lib/modules/${KERNEL_VERSION}/vmlinuz"

if [[ -f "${VMLINUZ_SOURCE}" ]]; then
    mkdir -p "/usr/lib/modules/${KERNEL_VERSION}"
    cp "${VMLINUZ_SOURCE}" "${VMLINUZ_TARGET}"
fi

# Lock kernel packages to prevent accidental updates to a different major version
dnf5 versionlock add "kernel-longterm-${KERNEL_VERSION}" || true
dnf5 versionlock add "kernel-longterm-core-${KERNEL_VERSION}" || true

# Initramfs generation using dracut
export DRACUT_NO_XATTR=1
dracut --force \
  --no-hostonly \
  --kver "${KERNEL_VERSION}" \
  --add-drivers "btrfs nvme xfs ext4" \
  --reproducible -v --add ostree \
  -f "/usr/lib/modules/${KERNEL_VERSION}/initramfs.img"

chmod 0600 "/usr/lib/modules/${KERNEL_VERSION}/initramfs.img"