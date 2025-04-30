#!/bin/bash

set -ouex pipefail

dnf5 install -y --skip-unavailable \
    edk2-ovmf \
    genisoimage \
    libvirt \
    libvirt-nss \
    virt-manager \
    virt-v2v \
    qemu-char-spice \
    qemu-device-display-virtio-gpu \
    qemu-device-display-virtio-vga \
    qemu-device-usb-redirect \
    qemu-img \
    qemu-system-x86-core \
    qemu-user-binfmt \
    qemu-user-static \
    qemu