#!/bin/bash

set -ouex pipefail

edition="$1"


if [[ "$edition" == "workstation" ]]; then
    /ctx/branding/branding.sh
    /ctx/packages/kernel.sh
    /ctx/packages/virt.sh
    /ctx/packages/bluefin-tweaks.sh

else
    echo "Invalid edition specified. Please use 'workstation' or 'multimedia'."
    exit 1
fi


