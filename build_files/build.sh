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
    cp /ctx/packages/repos/nordvpn.repo /etc/yum.repos.d/nordvpn.repo
    echo_group /ctx/branding/branding-ublue.sh
    dnf5 remove ncurses-term -y
    dnf5 install -y ghostty nordvpn code
    dnf remove -y ptyxis

elif [[ "$edition" == "gaming" ]]; then
    cp /ctx/packages/repos/nordvpn.repo /etc/yum.repos.d/nordvpn.repo
    cp /ctx/packages/repos/docker.repo /etc/yum.repos.d/docker.repo
    echo_group /ctx/packages/containers.sh
    echo_group /ctx/packages/cockpit.sh
    dnf5 install -y nordvpn
    dnf remove -y ptyxis

else
    echo "Invalid edition specified. Please use 'workstation' or 'gaming'."
    exit 1
fi


