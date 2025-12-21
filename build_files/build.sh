#!/bin/bash

set -ouex pipefail

edition="$1"


if [[ "$edition" == "workstation" ]]; then
    /ctx/branding/branding.sh
    /ctx/packages/kernel.sh
    /ctx/packages/bluefin-tweaks.sh

elif [[ "$edition" == "multimedia" ]]; then
    /ctx/packages/cockpit.sh
    dnf remove -y ptyxis

else
    echo "Invalid edition specified. Please use 'workstation' or 'multimedia'."
    exit 1
fi


