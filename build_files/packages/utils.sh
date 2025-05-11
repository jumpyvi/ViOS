#!/bin/bash

set -ouex pipefail

dnf5 install -y --skip-unavailable \
    git-credential-libsecret \
    ifuse \
    input-remapper \
    wl-clipboard \
    android-tools \
    dbus-x11 \
    ydotool \
    openssh-askpass \
    bootc \
    rclone \
    p7zip-plugins \
    p7zip \
    gtk2-devel \
    ublue-brew

dnf5 remove -y \
    firefox-langpacks \
    firefox \
    gnome-extensions-app \
    gnome-software-rpm-ostree \
    gnome-terminal-nautilus \
    podman-docker

