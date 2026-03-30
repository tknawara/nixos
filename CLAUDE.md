# NixOS Configuration

## Architecture

This is a flake-based NixOS config using **flake-parts** + **import-tree** (vimjoyer pattern).
`import-tree ./modules` auto-discovers all `.nix` files recursively. Directories with a `default.nix`
stop recursion — only that file is imported.

Every `.nix` file under `modules/` must be a valid **flake-parts module** (takes `{ self, inputs, ... }`).

## Module Types

There are three kinds of modules in this repo:

- **`flake.nixosModules.*`** — NixOS-level system modules (niri, vicinae). Imported in the host via `self.nixosModules.<name>`.
- **`flake.hmModules.*`** — Home Manager modules (git, helix, nvim, etc.). Custom flake option declared in `modules/flake-parts.nix`. Imported in the host via `self.hmModules.<name>`.
- **`perSystem`** — Per-system packages (niri wrapper, noctalia wrapper, vicinae). Used for wrapped programs via `self.packages` or `self'.packages`.

## File Structure

```
flake.nix                              # Entry point. Uses flake-parts + import-tree ./modules
modules/
├── flake-parts.nix                    # Declares systems + custom flake.hmModules option
├── features/
│   ├── desktop.nix                    # hmModule: XDG mime associations (default apps)
│   ├── niri/default.nix               # nixosModule + perSystem: niri compositor (wrapper-modules)
│   ├── noctalia/default.nix           # perSystem: noctalia-shell wrapper
│   ├── vicinae/default.nix            # hmModule + perSystem: vicinae app launcher (spawned by niri)
│   └── <name>/default.nix             # hmModule: individual program configs
└── hosts/
    └── pc/
        ├── default.nix                # Composes everything: nixosConfigurations.pc + home-manager setup
        ├── configuration.nix          # Plain NixOS module: system config, services, packages
        ├── hardware.nix               # Plain NixOS module: auto-generated hardware config
        ├── consts.nix                 # Plain NixOS module: shared options (fonts, wallpaper)
        └── disko.nix                  # Plain NixOS module: disk partitioning
```

`hosts/pc/default.nix` stops import-tree recursion, so `configuration.nix`, `hardware.nix`,
`consts.nix`, and `disko.nix` are imported by path inside that file — they stay as plain NixOS modules.

## Active Desktop Stack

- **Compositor**: Niri (Wayland) via wrapper-modules
- **Shell**: Noctalia-shell — replaces waybar, dunst, hyprlock, swww (status bar, notifications, lock screen, wallpaper)
- **App launcher**: Vicinae — spawned by niri (not systemd), `Mod+Space` runs `vicinae toggle`
- **Terminal**: Wezterm
- **Editor**: Helix (default EDITOR), Neovim (nixvim), VS Code, Zed
- **Shell**: Fish (system-level), with starship prompt
- **Theming**: Catppuccin Mocha throughout (NixOS + HM modules)
- **Login**: greetd + tuigreet

## Disabled / Inactive Modules

These modules exist in `features/` but are NOT imported in `hosts/pc/default.nix`:

- `waybar` — replaced by noctalia
- `rofi` — replaced by vicinae
- `dunst` — replaced by noctalia
- `hyprlock` — replaced by noctalia (lock screen via noctalia IPC)
- `kitty` — not used, wezterm is the active terminal

## Key Design Decisions

- **No GNOME**: Removed in favor of lighter Wayland-native stack. gnome-keyring is kept for secret storage, unlocked via PAM on greetd login. polkit-kde-agent runs via niri spawn-at-startup.
- **consts.nix** is imported in both NixOS and Home Manager contexts (defines `font.*` and `wallpaper` options used by multiple modules).
- **Scaling**: `outputs."*".scale = 1.5` in niri config applies to all monitors (4x DP ports on GPU).
- **wrapper-modules**: Used for niri and noctalia to wrap programs with declarative config (vimjoyer pattern).
- **Vicinae must be spawned by niri, not systemd**: The systemd user service lacks session env vars (WAYLAND_DISPLAY, PATH, QT_QPA_PLATFORM). Running as a systemd service causes Qt platform plugin crashes and inability to launch apps. The HM module sets `systemd.enable = false` and niri spawns `vicinae server` via `spawn-at-startup` instead.
- **Niri `spawn-at-startup` imports env**: Runs `systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP` so other user services get Wayland vars.

## Build

```sh
sudo nixos-rebuild switch --flake .#pc
```
