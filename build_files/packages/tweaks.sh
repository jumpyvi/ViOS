#!/bin/bash

set -ouex pipefail

dnf5 install -y \
    ptyxis \
    nm-connection-editor \
    vim

dnf5 remove foot -y
    
