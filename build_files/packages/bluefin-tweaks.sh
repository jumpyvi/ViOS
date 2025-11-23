#!/bin/bash

set -ouex pipefail

extra=(
  "ghostty"
  "nautilus-python"
  "nm-connection-editor"
  "evolution"
  "evolution-ews"
  "nautilus-open-any-terminal"
)

dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
dnf5 install -y --enablerepo=terra ${extra[@]}

dnf remove -y 'gnome-shell-extension*' ptyxis