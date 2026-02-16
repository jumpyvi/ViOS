#!/bin/bash

set -ouex pipefail

dnf5 install --enablerepo terra -y \
    ghostty \
    flameshot \
    nm-connection-editor

dnf5 remove foot -y
    