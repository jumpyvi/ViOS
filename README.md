# ViOS

# Purpose

This repository contain all my UBlue custom images.
Now that flatpak and brew (and soon sysext) are really good, the changes in these image are getting less important.


## Workstation
> ghcr.io/jumpyvi/vios-workstation

☁️ Based on Bluefin-DX

### Changes:
- Gnome swapped out for Cinnamon
- Ptyxis replaced by Ghostty
- Branding set to UBlue/BootC instead of Bluefin (GDM logo by furtivetardigrade and the Bluefin community)
- Uses the LTS cachyOS kernel

## Gaming
> ghcr.io/jumpyvi/vios-gaming

☁️ Based on Bazzite (KDE Nvidia)

### Changes
- Ptyxis removed
- Docker added
- Virtualization support


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
