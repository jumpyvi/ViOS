# ViOS

# Purpose

This repository contain all my UBlue custom images.
I try to keep the "atomic philosophy" and only add what can absolutly not be installed without root write acces


## Workstation
> ghcr.io/jumpyvi/vios-workstation

☁️ Based on Bluefin (stable)

A slight modification to the base image matching my preference and requirements

### Changes:
- Default kernel replaced by the CachyOS LTS kernel (for the coolness factor)
- Evolution added for Gnome-Shell support
- Full virtualization added
- nm-connection-editor added
- Some branding changes (for fun)



# How to rebase

```bash
sudo bootc switch --enforce-container-sigpolicy "ghcr.io/jumpyvi/vios-workstation:latest"
```
