#!/bin/bash

set -ouex pipefail

edition="$1"


/ctx/branding/branding.sh
/ctx/packages/kernel.sh
/ctx/packages/dx.sh


