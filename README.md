# BootVi

# Purpose

Zirconium with virt/docker support and an LTS kernel


## Workstation

☁️ Based on zirconium

A slight modification to the base image matching my preference and requirements

### Changes:
- Default kernel replaced by Kwizart's LTS kernel
- Full virtualization added
- Full docker-ce added
- Ptyxis instead of foot
- NmConnectionEditor for advanced network management


# How to rebase

```bash
sudo bootc switch --enforce-container-sigpolicy "ghcr.io/jumpyvi/bootvi:latest"
```
