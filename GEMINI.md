# Gemini Context & Project Mandates

This file serves as a persistent context for Gemini CLI when working on this NixOS configuration.

## Project Overview
This is a NixOS configuration managed with **Flakes** and **Home Manager**, following a highly modular structure.

### Key Paths
- `/flake.nix`: Main entry point.
- `/home.nix`: Primary Home Manager configuration for user `tarek`.
- `/modules/default.nix`: Uses `import-tree` to automatically expose modules in `hosts/` and `features/`.
- `/modules/hosts/pc/`: Configuration specific to the `pc` host.
    - `default.nix`: Orchestrates system-level imports including `essentials.nix`, `shell.nix`, and `desktop.nix`.
- `/modules/features/`: Feature-specific modules (e.g., `atuin`, `zsh`, `hyprland`).
    - Most are imported in `home.nix` for user-specific configuration.

## Architectural Patterns
1. **System vs. Home**: 
    - System-wide packages and services are defined in `modules/features/essentials.nix` and `shell.nix`, imported via `modules/hosts/pc/default.nix`.
    - User-specific tools and dotfile management are handled in `home.nix` via individual feature imports from `modules/features/`.
2. **Module Imports**: Imports in `home.nix` should follow the pattern `./modules/features/<feature>/default.nix`.
3. **Redundancy Management**: Avoid listing packages in `home.packages` within `home.nix` if they are already enabled via a specific module (e.g., `programs.zsh.enable = true`) or included in `essentials.nix`.

## Recent Refactoring (March 2026)
- **Fixed `home.nix` Imports**: Repaired malformed import paths that were split across multiple lines and incorrectly commented out.
- **Path Correction**: Corrected `desktop.nix` import path (removed non-existent `programs/` subfolder).
- **Cleanup**: Commented out redundant packages in `home.nix` (`git`, `zsh`, `yazi`, etc.) to favor module-based configuration.

## Guidelines for Future Sessions
- **Verify Paths**: Always check `modules/features/` directory structure before adding imports; some features are files (`desktop.nix`), others are directories with `default.nix`.
- **Prefer Modules**: When adding a new tool, check if a corresponding module exists in `modules/features/` before adding it to `home.packages`.
- **Evaluations**: Since `nix` is not installed on the host running the CLI, rely on static analysis and directory listing to verify changes.
