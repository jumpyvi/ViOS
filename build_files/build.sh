#!/bin/bash

set -ouex pipefail

edition="$1"

echo "edition is $edition"

if [[ "$edition" == "workstation" ]]; then
    cp /ctx/packages/repos/ghostty.repo /etc/yum.repos.d/ghostty.repo
    cp /ctx/packages/repos/cachykernel.repo /etc/yum.repos.d/cachykernel.repo
    /ctx/packages/cachy-kernel.sh
    /ctx/branding/branding.sh
    dnf5 remove ptyxis ncurses-term -y
    dnf remove -y 'gnome-shell-extension*'
    dnf5 install -y ghostty nautilus-python

elif [[ "$edition" == "gaming" ]]; then
    cp /ctx/packages/repos/docker.repo /etc/yum.repos.d/docker.repo
    /ctx/packages/containers.sh
    /ctx/packages/cockpit.sh
    dnf remove -y ptyxis

elif [[ "$edition" == "server" ]]; then
    cp /ctx/packages/repos/docker-rhel.repo /etc/yum.repos.d/docker.repo
    /ctx/packages/containers.sh
    /ctx/packages/cockpit.sh
    dnf install -y vim tailscale

else
    echo "Invalid edition specified. Please use 'workstation', 'gaming' or "server"."
    exit 1
fi


