# JumpyFin

# Purpose

Bluefin with virt/docker support and an LTS kernel


## Workstation

☁️ Based on Bluefin (stable)

A slight modification to the base image matching my preference and requirements

### Changes:
- Default kernel replaced by Kwizart's LTS kernel
- Full virtualization added
- Full docker-ce added
- Some branding changes (for fun)



# How to rebase

```bash
sudo bootc switch --enforce-container-sigpolicy "ghcr.io/jumpyvi/jumpyfin:latest"
```
