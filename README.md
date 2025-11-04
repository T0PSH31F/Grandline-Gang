# Grandline-Gang

A NixOS configuration repository for the **luffy** machine, built using the **clan-core** flake-parts template with **omarchy-nix** integration.

## Overview

This repository contains a complete NixOS configuration that manages one machine (`luffy`) and one user (`t0psh31f`). The configuration is structured using the clan-core flake-parts framework, which provides a modular and maintainable approach to NixOS system management.

## Repository Structure

```
Grandline-Gang/
├── flake.nix                           # Central flake definition with inputs and outputs
├── .gitignore                          # Git ignore patterns
├── machines/
│   └── luffy/
│       ├── default.nix                 # Machine configuration
│       ├── hardware-configuration.nix  # Hardware-specific settings
│       └── facter.json                 # System hardware facts
└── users/
    └── t0psh31f/
        └── default.nix                 # Home Manager configuration
```

## Machine Configuration

### luffy

**Hostname:** luffy  
**Local IP:** 192.168.8.212  
**Public IP:** 97.167.11.111  
**Platform:** x86_64-linux  
**Location:** Los Angeles, CA

The luffy machine is configured with:
- **Timezone:** America/Los_Angeles
- **Locale:** en_US.UTF-8
- **LUKS encryption** for the root filesystem
- **Btrfs** filesystem with subvolume support
- **Intel CPU** with KVM virtualization support
- **Thunderbolt** and **NVMe** support
- **OpenSSH** enabled for remote access
- **Clan-core networking** for remote deployment via SSH

## User Configuration

### t0psh31f

The t0psh31f user is configured with:
- **Home Manager** integration
- **Omarchy-nix** desktop environment (Hyprland-based)
- **Tokyo Night** theme
- Member of `wheel` and `networkmanager` groups

## Flake Inputs

This configuration uses the following flake inputs:

- **nixpkgs:** NixOS unstable channel
- **flake-parts:** Modular flake framework
- **clan-core:** Clan infrastructure for NixOS fleet management
- **omarchy-nix:** Opinionated Hyprland desktop environment
- **home-manager:** User environment management

## Getting Started

### Prerequisites

- A fresh NixOS installation on the target machine
- SSH access to the machine (for remote deployment)
- Nix flakes enabled in your configuration

### Local Build

To build the configuration locally:

```bash
nix build .#nixosConfigurations.luffy.config.system.build.toplevel
```

### Remote Deployment

To deploy to the luffy machine remotely using clan-core:

```bash
clan machines update luffy
```

Or using nixos-rebuild:

```bash
nixos-rebuild switch --flake .#luffy --target-host root@192.168.8.212
```

### Installation from Scratch

1. Boot the NixOS installer
2. Partition and format your disks according to the hardware-configuration.nix
3. Clone this repository:
   ```bash
   git clone https://github.com/T0PSH31F/Grandline-Gang.git
   cd Grandline-Gang
   ```
4. Install NixOS:
   ```bash
   nixos-install --flake .#luffy
   ```

## Customization

### Changing the Theme

Edit `users/t0psh31f/default.nix` and modify the omarchy theme:

```nix
omarchy = {
  full_name = "t0psh31f";
  email_address = "your.email@example.com";
  theme = "kanagawa";  # Options: tokyo-night, kanagawa, everforest, catppuccin, nord, gruvbox
};
```

### Adding Packages

Edit `machines/luffy/default.nix` and add packages to `environment.systemPackages`:

```nix
environment.systemPackages = with pkgs; [
  vim
  wget
  git
  # Add your packages here
];
```

### Modifying Network Settings

Update the networking configuration in `machines/luffy/default.nix`:

```nix
networking.hostName = "luffy";
clan.core.networking.targetHost = "root@192.168.8.212";
```

## Documentation

- [Clan-core Documentation](https://docs.clan.lol)
- [Flake-parts Guide](https://docs.clan.lol/guides/flake-parts/)
- [Omarchy-nix Repository](https://github.com/henrysipp/omarchy-nix)
- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)

## License

This configuration is provided as-is for personal use.

## Acknowledgments

- **clan-core** team for the excellent flake-parts integration
- **henrysipp** for the omarchy-nix project
- The NixOS community for comprehensive documentation and support
