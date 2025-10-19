#!/bin/bash

set -ouex pipefail

extra=(
  "ghostty"
  "nautilus-python"
  "yaru-theme"
  "nm-connection-editor"
  "evolution-ews-core"
)

removals=(
  "ptyxis"
  "ramalama"
  "fish"
  "bluefin-fastfetch"
  "bluefin-faces"
  "fastfetch"
)

dnf remove -y 'gnome-shell-extension*'
dnf5 remove -y ${removals[@]}

dnf5 install -y --enablerepo=terra ${extra[@]}
