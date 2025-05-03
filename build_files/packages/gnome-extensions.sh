#!/bin/bash

set -ouex pipefail

dnf5 install -y --skip-broken \
    adw-gtk3-theme \
    gnome-shell-extension-appindicator \
    gnome-shell-extension-caffeine \
    gnome-shell-extension-dash-to-dock \
    gnome-tweaks \
    nautilus-python
