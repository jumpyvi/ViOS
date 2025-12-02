#!/bin/bash

set -ouex pipefail

edition="$1"


if [[ "$edition" == "workstation" ]]; then
    /ctx/branding/branding.sh
    /ctx/packages/kernel.sh
    /ctx/packages/bluefin-tweaks.sh

elif [[ "$edition" == "multimedia" ]]; then
    cp /ctx/packages/repos/docker.repo /etc/yum.repos.d/docker.repo
    /ctx/packages/containers.sh
    /ctx/packages/cockpit.sh
    /ctx/packages/virt.sh
    dnf remove -y ptyxis
    dnf install -y borgbackup sway seatd

else
    echo "Invalid edition specified. Please use 'workstation' or 'multimedia'."
    exit 1
fi


