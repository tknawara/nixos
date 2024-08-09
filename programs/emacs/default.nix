{ pkgs, inputs, ... }:

{
  nixpkgs.overlays = [ (import inputs.emacs-overlay) ];
  programs.emacs = {
    enable = true;
    package = pkgs.emacsWithPackagesFromUsePackage {
      config = ./init.el;
      alwaysEnsure = true;
      package = pkgs.emacs-pgtk;
      extraEmacsPackages = (epkgs:
        with epkgs; [
          catppuccin-theme
          treesit-grammars.with-all-grammars
        ]);
    };
  };

  services.emacs.enable = true;
  home.packages = with pkgs; [ emacs-all-the-icons-fonts ];
  home.file = { ".emacs.d/init.el" = { source = ./init.el; }; };
}
