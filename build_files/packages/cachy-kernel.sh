#!/usr/bin/bash
set -eoux pipefail


# Adds the addons repo
dnf5 copr enable -y bieszczaders/kernel-cachyos-addons

# Adds required package for the scheduler
dnf5 install -y \
    --enablerepo="copr:copr.fedorainfracloud.org:bieszczaders:kernel-cachyos-addons" \
    --allowerasing \
    libcap-ng libcap-ng-devel procps-ng procps-ng-devel uksmd libbpf scx-scheds


# systemctl enable scx_loader.service

tee /etc/scx_loader.toml > /dev/null <<EOF
default_sched = "scx_bpfland" # Possible values : "scx_bpfland", "scx_flash", "scx_lavd", "scx_p2dq", "scx_tickless", "scx_rustland", "scx_rusty"
default_mode = "Auto" # Possible values: "Auto", "Gaming", "LowLatency", "PowerSave".
EOF


# Adds the main kernel repo
dnf5 copr enable -y bieszczaders/kernel-cachyos

# Remove useless kernels
readarray -t OLD_KERNELS < <(rpm -qa 'kernel-*')
if (( ${#OLD_KERNELS[@]} )); then
    rpm -e --justdb --nodeps "${OLD_KERNELS[@]}"
    dnf5 versionlock delete "${OLD_KERNELS[@]}" || true
    rm -rf /usr/lib/modules/*
    rm -rf /lib/modules/*
fi

# Install CachyOS kernel packages from bieszczaders
dnf5 install -y \
    --enablerepo="copr:copr.fedorainfracloud.org:bieszczaders:kernel-cachyos" \
    --allowerasing \
    kernel-cachyos-lts \
    kernel-cachyos-lts-devel-matched \
    kernel-cachyos-lts-devel \
    kernel-cachyos-lts-modules \
    kernel-cachyos-lts-core

# Get full kernel version with arch (including the arch)
KERNEL_VERSION="$(rpm -q --qf '%{VERSION}-%{RELEASE}.%{ARCH}\n' kernel-cachyos-lts)"

# Copy vmlinuz
VMLINUZ_SOURCE="/usr/lib/kernel/vmlinuz-${KERNEL_VERSION}"
VMLINUZ_TARGET="/usr/lib/modules/${KERNEL_VERSION}/vmlinuz"
if [[ -f "${VMLINUZ_SOURCE}" ]]; then
    cp "${VMLINUZ_SOURCE}" "${VMLINUZ_TARGET}"
fi

# Lock kernel packages
dnf5 versionlock add "kernel-cachyos-lts-${KERNEL_VERSION}" || true
dnf5 versionlock add "kernel-cachyos-lts-modules-${KERNEL_VERSION}" || true


# Thank you @renner for this part
# Build initramfs (without --add-drivers I get an error telling me subvols= does not exists)
export DRACUT_NO_XATTR=1
dracut --force \
  --no-hostonly \
  --kver "${KERNEL_VERSION}" \
  --add-drivers "btrfs nvme xfs ext4" \
  --reproducible -v --add ostree \
  -f "/usr/lib/modules/${KERNEL_VERSION}/initramfs.img"

chmod 0600 "/lib/modules/${KERNEL_VERSION}/initramfs.img"
