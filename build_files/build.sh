#!/bin/bash

set -ouex pipefail

edition="$1"


if [[ "$edition" == "workstation" ]]; then
    /ctx/branding/branding.sh
    /ctx/packages/cachy-kernel.sh
    dnf5 install -y ulauncher evolution evolution-ews
    dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
    dnf5 install -y --enablerepo=terra ghostty
    dnf5 remove -y ptyxis

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


