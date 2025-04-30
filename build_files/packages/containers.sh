#!/bin/bash

set -ouex pipefail

dnf5 install -y --skip-unavailable \
    containerd.io \
    docker-buildx-plugin \
    docker-ce \
    docker-ce-cli \
    docker-compose-plugin \
    podman-bootc \
    podman-compose \
    podman-machine

systemctl enable docker