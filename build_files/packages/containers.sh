#!/bin/bash

set -ouex pipefail

for pkg in \
    containerd.io \
    docker-buildx-plugin \
    docker-ce \
    docker-ce-cli \
    docker-compose-plugin \
    podman-bootc \
    podman-compose \
    podman-machine \
    lxc lxc-templates lxc-extra debootstrap libvirt perl gpg
do
    if dnf list --available "$pkg" &>/dev/null; then
        echo "Installing $pkg..."
        dnf install -y "$pkg"
    else
        echo "Package $pkg not available. Skipping."
    fi
done


systemctl enable docker
