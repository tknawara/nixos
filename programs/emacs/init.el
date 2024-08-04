(require 'package)
(package-initialize)

;; * General
(use-package general
  :defines
  general-prefix
  general-utility-prefix

  :functions
  setg
  setgd

  with-prefix
  with-utility

  :config
  (defalias 'setg 'general-setq)
  (defalias 'setgd 'general-setq-default)
)

;; * Theme
(load-theme 'catppuccin :no-confirm)
(setq catppuccin-flavor 'mocha) ;; or  'frappe 'latte, 'macchiato, or 'mocha
(catppuccin-reload)
(set-frame-parameter nil 'alpha-background 90)
(add-to-list 'default-frame-alist '(alpha-background . 90))

;; * Modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; * UI, editing
(set-frame-font "CaskaydiaMono Nerd Font 12")
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setg frame-background-mode 'dark)
(setg version-control t)
(setg show-trailing-whitespace t)
(setg fringe-mode 0)
(setgd indent-tabs-mode nil)
(setg inhibit-startup-message t)
(setg sentence-end-double-space nil)
(setgd tab-width 2)
(setg tool-bar-mode nil)
(global-display-line-numbers-mode 1)
(setq display-line-numbers 'relative)

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;; * Version control
(global-diff-hl-mode)

;; * Evil
(use-package evil
  :init
  (evil-mode 1)

  :config
  (setg evil-move-beyond-eol t)
  (setg evil-split-window-below t)
  (setg evil-vsplit-window-right t)

  (setgd evil-shift-width 4)
  (add-to-list 'evil-emacs-state-modes 'minibuffer-mode)
)

;; * lsp
(use-package lsp-mode
  :ensure
  :commands (lsp lsp-deferred)
  :hook ((c-mode   ; clangd
          c++-mode ; clangd
          c-or-c++-mode ; clangd
          python-mode   ; pyright
          ) . lsp)
  :init
  :config
  )

(use-package flycheck
  :ensure
  )

;; * treemacs
(use-package treemacs)
(use-package lsp-treemacs)
(use-package treemacs-projectile)
(setq treemacs-position 'left)
