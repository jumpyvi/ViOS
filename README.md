# ViOS

# Purpose

This repository contain all my UBlue custom images.
Now that flatpak and brew (and soon sysext) are really good, the changes in these image are getting less important.


## Workstation
> ghcr.io/jumpyvi/vios-workstation

☁️ Based on Bluefin-DX

### Changes:
- Ptyxis replaced by Ghostty
- All system-wide gnome extensions removed
- Branding set to UBlue/BootC instead of Bluefin
- Cachy LTS kernel instead of default

## Gaming
> ghcr.io/jumpyvi/vios-gaming

☁️ Based on Bazzite

### Changes
- Ptyxis removed
- Docker added

All other changes will be reverted soon


## Server
> ghcr.io/jumpyvi/vios-server

☁️ Based on cayo:centos

### Changes
- Docker added
- Tailscale added
- Cockpit added
- Vim added (will be switched to helix when available)



# How to rebase

```bash
sudo bootc switch --enforce-container-sigpolicy "ghcr.io/jumpyvi/{image-name}:{tag}"
```