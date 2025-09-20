#!/bin/bash

set -ouex pipefail

edition="$1"


if [[ "$edition" == "workstation" ]]; then
    /ctx/branding/branding.sh
    /ctx/packages/cachy-kernel.sh
    /ctx/packages/bluefin-tweaks.sh
    dnf5 install -y /ctx/packages/XPPenLinux407.rpm # Convert to sysext in the futur

elif [[ "$edition" == "gaming" ]]; then
    cp /ctx/packages/repos/docker.repo /etc/yum.repos.d/docker.repo
    /ctx/packages/containers.sh
    /ctx/packages/cockpit.sh
    /ctx/packages/virt.sh
    dnf remove -y ptyxis

elif [[ "$edition" == "server" ]]; then
    cp /ctx/packages/repos/docker-rhel.repo /etc/yum.repos.d/docker.repo
    /ctx/packages/containers.sh
    /ctx/packages/cockpit.sh
    dnf install -y vim tailscale borgbackup

else
    echo "Invalid edition specified. Please use 'workstation', 'gaming' or "server"."
    exit 1
fi


