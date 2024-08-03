{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs:
      with epkgs; [
        evil
        nix-mode
        rust-mode
        dockerfile-mode
        catppuccin-theme
      ];
  };

  home.file.".emacs.d/init.el" = { source = ./init.el; };
}
