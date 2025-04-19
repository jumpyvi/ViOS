#!/bin/bash

set -ouex pipefail


tee /etc/yum.repos.d/ghostty.repo <<'EOF'
[copr:copr.fedorainfracloud.org:pgdev:ghostty]
name=Copr repo for Ghostty owned by pgdev
baseurl=https://download.copr.fedorainfracloud.org/results/pgdev/ghostty/fedora-$releasever-$basearch/
type=rpm-md
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://download.copr.fedorainfracloud.org/results/pgdev/ghostty/pubkey.gpg
repo_gpgcheck=0
enabled=1
enabled_metadata=1
EOF

tee /etc/yum.repos.d/nordvpn.repo <<'EOF'
[nordvpn]
name=nordvpn
enabled=1
gpgcheck=0
baseurl=https://repo.nordvpn.com/yum/nordvpn/centos/x86_64
EOF

dnf remove -y ptyxis tailscale solaar gnome-shell-extension-search-light gnome-shell-extension-tailscale-gnome-qs ncurses-term

dnf5 install -y tmux ghostty bridge-utils xhost nordvpn gtk2-devel

systemctl enable podman.socket
