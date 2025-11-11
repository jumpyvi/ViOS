#!/bin/bash

set -ouex pipefail

# GDM Logo by @furtivetardigrade, @kikaraage, @jf8130, and @chandeleer
cp /ctx/branding/gdm-logo.png /usr/share/pixmaps/fedora-gdm-logo.png
cp /ctx/branding/bootc.png /usr/share/plymouth/themes/spinner/watermark.png
cp /ctx/branding/better-bluetooth.svg /usr/share/icons/hicolor/scalable/status/blueman-tray.svg

cat <<EOF > "/usr/share/plymouth/plymouthd.defaults"
# ViOS custom spinner
[Daemon]
Theme=spinner
ShowDelay=0
DeviceTimeout=8
UseSimpledrm=1
EOF
