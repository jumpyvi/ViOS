#!/bin/bash

set -ouex pipefail

extra=(
  "ghostty"
  "nautilus-python"
  "yaru-theme"
  "nm-connection-editor"
  "evolution"
  "evolution-ews"
  "dconf-editor"
  "nautilus-open-any-terminal"
)

dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
dnf5 install -y --enablerepo=terra ${extra[@]}

dnf remove -y 'gnome-shell-extension*'
dnf5 remove -y ptyxis fish bluefin-fastfetch bluefin-faces fastfetch ghostty-nautilus
