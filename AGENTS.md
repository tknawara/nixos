# NixOS Configuration - Agent Context

## Overview

Flake-based NixOS configuration for a single-user desktop workstation using **flake-parts** + **import-tree** (vimjoyer pattern). Auto-discovers modules via `import-tree ./modules`.

## Hardware Profile

**Host:** `pc` (desktop workstation)

**GPU Setup:**
- **AMD Pro GPU** - Primary display (monitors, Wayland compositor)
- **NVIDIA Ada Professional** - Compute/ML only (CUDA workloads)
- Config: `videoDrivers = ["amdgpu" "nvidia"]` (AMD first = primary display)

**Kernel:** `linuxPackages_xanmod_stable` (6.12 LTS) for stability with proprietary drivers

## Desktop Stack

| Component | Package | Notes |
|-----------|---------|-------|
| Compositor | Niri (Wayland) | via `wrapper-modules`, 1.5x scale for 4K |
| Shell | Noctalia-shell | Replaces waybar+dunst+hyprlock+swww |
| Launcher | Vicinae | App launcher (Mod+Space) |
| Terminal | Wezterm | Built from flake input |
| Editor | Helix (default), Nixvim | LSP configured for nix, rust, python |
| Shell | Fish + Starship | Vi bindings, aliases for eza/bat/rg |
| Login | greetd + tuigreet | Minimal TUI login |

## Architecture

### Module Types

There are 3 kinds of modules in this repo:

1. **`flake.nixosModules.*`** - System-level modules (niri, vicinae)
   - Imported in host via `self.nixosModules.<name>`
   - Example: `modules/features/niri/default.nix`

2. **`flake.hmModules.*`** - Home Manager modules (git, helix, fish, etc.)
   - Custom flake option declared in `modules/flake-parts.nix`
   - Imported in host via `self.hmModules.<name>`
   - Example: `modules/features/fish/default.nix`

3. **`perSystem`** - Per-system packages (wrapped programs)
   - Used for wrapped programs via `self.packages` or `self'.packages`
   - Example: `myNiri`, `myNoctalia`, `vicinae`

### File Structure

```
flake.nix                          # Entry point: flake-parts + import-tree
modules/
├── flake-parts.nix               # Declares systems + custom hmModules option
├── features/
│   ├── niri/default.nix          # nixosModule + perSystem: niri compositor
│   ├── noctalia/default.nix      # perSystem: noctalia-shell wrapper
│   ├── vicinae/default.nix       # nixosModule + perSystem: app launcher
│   ├── fish/default.nix          # hmModule: fish shell config
│   ├── helix/default.nix         # hmModule: helix editor
│   ├── wezterm/default.nix       # hmModule: wezterm terminal
│   ├── ui/default.nix            # hmModule: GTK, portals, cursor themes
│   ├── desktop.nix               # hmModule: XDG mime associations
│   └── <name>/default.nix        # Other hmModules (git, nvim, etc.)
└── hosts/
    └── pc/
        ├── default.nix           # Host entry point: composes everything
        ├── configuration.nix     # NixOS system config (hardware, services)
        ├── hardware.nix          # Auto-generated hardware config
        ├── consts.nix            # Shared options (fonts, wallpaper)
        └── disko.nix             # Disk partitioning
```

### Import Rules

- `hosts/pc/default.nix` has a `default.nix` → stops `import-tree` recursion
- Sub-files (`configuration.nix`, `hardware.nix`, etc.) imported by explicit path
- `consts.nix` imported in **both** NixOS and Home Manager contexts

## Config Split

| Category | Location | Examples |
|----------|----------|----------|
| System/Hardware | `configuration.nix` | Kernel, drivers, systemd, thunar plugins, QT theming |
| User GUI Apps | `pc/default.nix` `home.packages` | Firefox, Discord, Obsidian, gnome-calculator, mission-center |
| User Dotfiles | `features/<name>/` | Fish, helix, wezterm, git configs |
| Theming | `features/ui/default.nix` + `pc/default.nix` | Catppuccin Mocha, GTK, Kvantum |

## Standby Modules (Not Imported)

These exist in `features/` but are NOT active (kept for tinkering):
- `waybar` - replaced by noctalia
- `rofi` - replaced by vicinae  
- `dunst` - replaced by noctalia
- `hyprlock` - replaced by noctalia
- `kitty` - not used (wezterm active)

To enable: add `self.hmModules.<name>` to imports in `hosts/pc/default.nix`

## NVIDIA/AMD Setup

```nix
# AMD = display, NVIDIA = compute
services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];

hardware.nvidia = {
  modesetting.enable = true;
  open = true;                    # Open kernel module (good for Ada)
  nvidiaPersistenced = true;      # Keep GPU init for ML
  package = config.boot.kernelPackages.nvidiaPackages.stable;
};

hardware.graphics.extraPackages = with pkgs; [
  amdvlk                        # AMD Vulkan
  rocmPackages.clr              # AMD OpenCL
  rocmPackages.clr.icd
];
```

## Build Commands

```bash
# Full system rebuild
sudo nixos-rebuild switch --flake .#pc

# Home Manager only (faster)
home-manager switch --flake .#tarek@pc
```

## Key Environment Variables

```nix
NIXOS_OZONE_WL = "1";           # Wayland for Electron apps
MOZ_ENABLE_WAYLAND = "1";       # Firefox native Wayland
__GL_GSYNC_ALLOWED = "1";       # G-Sync support
XDG_SESSION_TYPE = "wayland";
EDITOR = "hx";                   # Helix as default
```

## User Info

- **Username:** `tarek`
- **Home:** `/home/tarek`
- **Shell:** `fish`
- **State Version:** 23.11 (HM), 24.05 (NixOS)

## Important Notes

1. **No Nix on host** - This config is edited on a non-NixOS machine, rely on static analysis
2. **Dual GPU** - AMD drives display, NVIDIA for CUDA/ML only
3. **Xanmod LTS** - Using stable variant for proprietary driver compatibility
4. **Wrapper modules** - Niri and Noctalia use `wrapper-modules` for declarative config
5. **No GNOME** - Pure niri+noctalia stack (GNOME keyring kept for secrets)
