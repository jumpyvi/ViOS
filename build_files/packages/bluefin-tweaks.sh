#!/bin/bash

set -ouex pipefail

extra=(
  "nm-connection-editor"
  "evolution"
  "evolution-ews"
)

dnf5 install -y ${extra[@]}
dnf5 remove -y input-remapper
