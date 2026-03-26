{ pkgs, inputs, ... }:

{
  nixpkgs.overlays = [ (import inputs.emacs-overlay) ];
  programs.emacs = {
    enable = false;
    package = pkgs.emacsWithPackagesFromUsePackage {
      config = ./init.el;
      alwaysEnsure = true;
      package = pkgs.emacs-unstable;
      extraEmacsPackages = (epkgs:
        with epkgs; [
          catppuccin-theme
          treesit-grammars.with-all-grammars
        ]);
    };
  };

  services.emacs.enable = false;
  home.packages = with pkgs; [ emacs-all-the-icons-fonts ];
  home.file = { ".emacs.d/init.el" = { source = ./init.el; }; };
}
