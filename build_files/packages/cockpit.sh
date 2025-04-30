#!/bin/bash

set -ouex pipefail

dnf5 install -y --skip-unavailable \
    cockpit-bridge \
    cockpit-machines \
    cockpit-networkmanager \
    cockpit-ostree \
    cockpit-podman \
    cockpit-selinux \
    cockpit-storaged \
    cockpit-system \
    cockpit
