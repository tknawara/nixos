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
- **Niri output matching**: Always match monitors by identity string (`"Manufacturer Model Serial"`), never by connector name (`DP-1`, `DP-5`, etc.). Connector names change across reboots/port swaps. Run `niri msg outputs` to find the identity string. Niri does **not** support wildcards (`*`, `DP-*`) in output names.
- **Scaling**: `outputs."<monitor-identity>".scale = 1.5` in niri config (4K monitor, 4x DP ports on GPU).
- **wrapper-modules**: Used for niri and noctalia to wrap programs with declarative config (vimjoyer pattern).
- **Vicinae must be spawned by niri, not systemd**: The systemd user service lacks session env vars (WAYLAND_DISPLAY, PATH, QT_QPA_PLATFORM). Running as a systemd service causes Qt platform plugin crashes and inability to launch apps. The HM module sets `systemd.enable = false` and niri spawns `vicinae server` via `spawn-at-startup` instead.
- **Niri `spawn-at-startup` imports env**: Runs `systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP` so other user services get Wayland vars.

## Secure Boot Setup (Lanzaboote)

Secure boot is enabled via [lanzaboote](https://github.com/nix-community/lanzaboote) which signs boot files so the firmware trusts them. The NixOS config (`system.nix`) already has lanzaboote enabled with `pkiBundle = "/var/lib/sbctl"`.

### Initial setup (one-time)

**1. BIOS/UEFI firmware settings:**
   - Navigate to **Secure Boot** settings
   - Set **OS Type** to **Windows UEFI** (required for custom key enrollment)
   - Set **Secure Boot Mode** to **Custom** (instead of Standard)
   - **Clear all existing Secure Boot keys** (this puts the firmware in Setup Mode, allowing new key enrollment)
   - Save and reboot into NixOS

**2. Generate and enroll keys in NixOS:**
   ```sh
   # Verify firmware is in Setup Mode
   sudo sbctl status
   # Should show: Setup Mode: Enabled, Secure Boot: Disabled

   # Generate new signing keys
   sudo sbctl create-keys

   # Build NixOS so lanzaboote signs the boot files with the new keys
   sudo nixos-rebuild switch --flake .#pc

   # Verify everything that needs signing is signed
   sudo sbctl verify
   # All entries should show ✓ (signed)

   # Enroll keys into firmware (with Microsoft keys for compatibility)
   sudo sbctl enroll-keys --microsoft
   ```

**3. Reboot and enable enforcement:**
   - Reboot into BIOS/UEFI
   - Verify **Secure Boot** now shows as **Enabled**
   - Boot into NixOS and confirm: `bootctl status` should show `Secure Boot: enabled`

### Troubleshooting

- If `sbctl enroll-keys` fails with an immutable error, the keys need to be made mutable first:
  ```sh
  sudo chattr -i /sys/firmware/efi/efivars/{PK,KEK,db,dbx}-*
  ```
- If boot fails after enrollment, enter BIOS and reset Secure Boot keys to factory defaults, then retry from step 1.
- `sbctl verify` should be clean before enrolling keys — any unsigned files will cause boot failure once Secure Boot is enforced.

## Package Renames

When adding nixpkgs packages, be aware of these renames (using old names causes build errors):

- `vaapiVdpau` → `libva-vdpau-driver`

## Build

```sh
sudo nixos-rebuild switch --flake .#pc
```
