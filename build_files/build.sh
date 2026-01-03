#!/bin/bash

set -ouex pipefail

dnf -y copr enable ublue-os/packages
dnf -y --enablerepo copr:copr.fedorainfracloud.org:ublue-os:packages install \
  libvirt \
  libvirt-nss \
  virt-install \
  edk2-ovmf \
  ublue-os-libvirt-workarounds
