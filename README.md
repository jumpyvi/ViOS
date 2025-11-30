# ViOS

# Purpose

This repository contain all my UBlue custom images.
I try to keep the "atomic philosophy" and only add what can absolutly not be installed without root write acces


## Workstation
> ghcr.io/jumpyvi/vios-workstation

☁️ Based on Bluefin-DX (stable)

### Changes:
- Ptyxis replaced by Ghostty (+ nautilus plugin)
- Default kernel replaced by Kwizart's longterm kernel (6.12 rn)
- Evolution added for Gnome-Shell support
- Some branding changes (for fun)

## Multimedia
> ghcr.io/jumpyvi/vios-gaming

☁️ Based on Bazzite (KDE Nvidia)

### Changes
- Ptyxis removed
- Docker and LXC added
- Virtualization support
- Borg support



# How to rebase

```bash
sudo bootc switch --enforce-container-sigpolicy "ghcr.io/jumpyvi/{image-name}:{tag}"
```
