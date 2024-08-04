{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    extraPackages = epkgs:
      with epkgs; [
        breadcrumb
        catppuccin-theme
        consult
        dap-mode
        diff-hl
        dockerfile-mode
        doom-modeline
        embark
        evil
        evil-cleverparens
        evil-collection
        evil-indent-plus
        evil-matchit
        evil-org
        evil-surround
        evil-tex
        evil-textobj-tree-sitter
        exec-path-from-shell
        general
        helm
        lsp-mode
        lsp-treemacs
        magit
        magit-todos
        nix-mode
        rust-mode
        tree-sitter
        treemacs
        treemacs-projectile
        treesit-grammars.with-all-grammars
      ];
  };

  home.file.".emacs.d/init.el" = { source = ./init.el; };
}
