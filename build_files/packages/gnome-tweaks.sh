#!/bin/bash

set -ouex pipefail

extra=(
  "ghostty"
  "nautilus-python"
  "yaru-theme"
  "nm-connection-editor"
  "evolution-ews-core"
  "dconf-editor"
  "nautilus-open-any-terminal"
)

removals=(
  "ptyxis"
  "fish"
  "bluefin-fastfetch"
  "bluefin-faces"
  "fastfetch"
  "ghostty-nautilus"
)

dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
dnf remove -y 'gnome-shell-extension*'
dnf5 remove -y ${removals[@]}

dnf5 install -y --enablerepo=terra ${extra[@]}
