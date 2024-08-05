{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs:
      with epkgs; [
        all-the-icons
        breadcrumb
        cargo
        catppuccin-theme
        company
        company-box
        consult
        counsel
        counsel-projectile
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
        evil-nerd-commenter
        evil-org
        evil-surround
        evil-tex
        evil-textobj-tree-sitter
        exec-path-from-shell
        geiser
        geiser-guile
        general
        hydra
        ivy
        ivy-rich
        lsp-ivy
        lsp-mode
        lsp-pyright
        lsp-treemacs
        lsp-ui
        magit
        magit-todos
        nix-mode
        projectile
        python-mode
        rainbow-delimiters
        rust-mode
        swiper
        tree-sitter
        treemacs
        treemacs-projectile
        treesit-grammars.with-all-grammars
        which-key
      ];
  };

  home.file.".emacs.d/init.el" = { source = ./init.el; };
}
