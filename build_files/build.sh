#!/bin/bash

set -ouex pipefail

edition="$1"

# Thank you (copied from) m2Giles https://github.com/m2Giles/m2os
function echo_group() {
    local WHAT
    WHAT="$(
        basename "$1" .sh |
            tr "-" " " |
            tr "_" " "
    )"
    echo "::group:: === ${WHAT^^} ==="
    "$1"
    echo "::endgroup::"
}

if [[ "$edition" == "workstation" ]]; then
    cp /ctx/packages/repos/ghostty.repo /etc/yum.repos.d/ghostty.repo
    echo_group /ctx/branding/branding.sh
    /ctx/packages/cachy-kernel.sh
    dnf5 remove ptyxis ncurses-term -y
    dnf remove -y 'gnome-shell-extension*'
    dnf5 install -y ghostty nautilus-python code

elif [[ "$edition" == "gaming" ]]; then
    cp /ctx/packages/repos/docker.repo /etc/yum.repos.d/docker.repo
    echo_group /ctx/packages/containers.sh
    echo_group /ctx/packages/cockpit.sh
    dnf remove -y ptyxis

elif [[ "$edition" == "server" ]]; then
    cp /ctx/packages/repos/docker-rhel.repo /etc/yum.repos.d/docker.repo
    echo_group /ctx/packages/containers.sh
    echo_group /ctx/packages/cockpit.sh
    dnf install -y vim tailscale borg

else
    echo "Invalid edition specified. Please use 'workstation', 'gaming' or "server"."
    exit 1
fi


