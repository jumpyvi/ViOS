#!/bin/bash

set -ouex pipefail

dnf5 install -y \
    ptyxis \
    nm-connection-editor

dnf5 remove foot -y
    
