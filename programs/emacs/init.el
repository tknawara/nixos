;; You will most likely need to adjust this font size for your system!
(defvar efs/default-font-size 120)
(defvar efs/default-variable-font-size 120)

(require 'package)
(package-initialize)
(setq use-package-always-ensure t)

;; -----------------------------
;; General
;; -----------------------------
(use-package general
  :config
  (defalias 'setg 'general-setq)
  (defalias 'setgd 'general-setq-default)
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (rune/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme"))

  :functions
  setg
  setgd)

;; * Theme
(load-theme 'catppuccin :no-confirm)
(setq catppuccin-flavor 'mocha) ;; or  'frappe 'latte, 'macchiato, or 'mocha
(catppuccin-reload)

;; * Modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1))

;; ----------------------------------------
;; * UI, editing
;; ---------------------------------------
(variable-pitch-mode 1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(set-fringe-mode 10) 
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setg frame-background-mode 'dark)
(setg version-control t)
(setg show-trailing-whitespace t)
(setgd indent-tabs-mode nil)
(setg inhibit-startup-message t)
(setg sentence-end-double-space nil)
(setgd tab-width 4)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(set-fringe-mode 10)
(setgd c-basic-offset 4)
(setgd c-ts-basic-offset 4)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


(set-face-attribute 'default nil :font "Cascadia Code NF" :height efs/default-font-size)
;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "Cascadia Code NF" :height efs/default-font-size)
;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Cantarell" :height efs/default-variable-font-size :weight 'regular)

;; ----------------------------
;; Magit
;; ----------------------------
(use-package magit)

;; -----------------------------
;; Which-key
;; -----------------------------
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

;; -----------------------------
;; Evil
;; -----------------------------
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-nerd-commenter
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

;; -------------------------------------
;; Hydra
;; ------------------------------------
(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(rune/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

;; -------------------------------------
;; Helpful
;; ------------------------------------
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; --------------------------------------
;; Ivy
;; --------------------------------------
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package lsp-ivy)

;; ---------------------------------------
;; * Lsp
;; ---------------------------------------
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (((c-mode c++-mode c-or-c++-mode c-ts-mode c++-ts-mode c-or-c++-ts-mode) . lsp))
  :custom
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-headerline-breadcrumb-segments
   '(project symbols))
  (lsp-headerline-breadcrumb-enable-symbol-numbers nil)
  (lsp-headerline-breadcrumb-enable-diagnostics nil)
  (lsp-headerline-breadcrumb-icons-enable nil)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (setq lsp-headerline-arrow "")
  (lsp-enable-which-key-integration t))

(use-package lsp-treemacs
  :after lsp)

(add-hook 'c-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'lsp-format-buffer nil t)))
(add-hook 'c++-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'lsp-format-buffer nil t)))
(add-hook 'c-ts-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'lsp-format-buffer nil t)))
(add-hook 'c++-ts-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'lsp-format-buffer nil t)))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

;; -----------------------------------------
;; Treesitter
;; -----------------------------------------
(push '(python-mode . python-ts-mode) major-mode-remap-alist)
(push '(rust-mode . rust-ts-mode) major-mode-remap-alist)
(push '(c-mode . c-ts-mode) major-mode-remap-alist)
(push '(c++-mode . c++-ts-mode) major-mode-remap-alist)
(push '(c-or-c++-mode . c-or-c++-ts-mode) major-mode-remap-alist)
(push '(cc-mode . cc-ts-mode) major-mode-remap-alist)
;;(push '(javascript-mode . js-ts-mode) major-mode-remap-alist)
;;(push '(toml-mode . toml-ts-mode) major-mode-remap-alist)
;;(push '(tsx-mode . tsx-ts-mode) major-mode-remap-alist)
;;(push '(typescript-mode . tsx-ts-mode) major-mode-remap-alist)
;;(push '(javascript-mode . tsx-ts-mode) major-mode-remap-alist)
;;(push '(css-mode . css-ts-mode) major-mode-remap-alist)

;; ------------------------------------------
;; Rust
;; ------------------------------------------
(use-package rust-mode
  :hook ((rust-mode . lsp-deferred)
         (rust-ts-mode . lsp-deferred)
         (before-save . lsp-format-buffer)
         (before-save . lsp-organize-imports))
  :config
  (setq lsp-completion-enable t))
(use-package cargo
  :hook (rust-mode . cargo-minor-mode))

;; -------------------------------------------
;; Python
;; --------------------------------------------
(use-package python-mode
  :hook ((python-mode . lsp-deferred)
         (python-ts-mode . lsp-deferred)
         (before-save . lsp-format-buffer)
         (before-save . lsp-organise-imports)))
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp-deferred)))) 
 

;; ------------------------------------
;; Racket
;; ------------------------------------
(use-package racket-mode
  :hook ((racket-mode . lsp-deferred)
         (before-save . lsp-format-buffer)
         (before-save . lsp-organise-imports)))

;; -----------------------------------
;; Projectile
;; -----------------------------------
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  
  (when (file-directory-p "~/workspace")
    (setq projectile-project-search-path '("~/workspace")))
  (setq projectile-switch-project-action #'projectile-dired)
  )

(use-package counsel-projectile
  :config (counsel-projectile-mode))

;; ----------------------------------
;; Counsel
;; ----------------------------------
(use-package counsel
  :bind (("C-M-j" . 'counsel-switch-buffer)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :config
  (counsel-mode 1)
  (global-set-key (kbd "C-x C-f") 'counsel-projectile-find-file)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (setq counsel-mode-match-fuzzy t)
  (setq counsel-find-file-ignore-case t)
  )

;; -----------------------------
;; Company
;; ------------------------------
(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package evil-textobj-tree-sitter)

;; -------------------------------
;; Electric
;; -------------------------------
(setq electric-pair-preserve-balance t)
(setq electric-pair-delete-adjacent-pairs nil)
(setq electric-pair-open-newline-between-pairs t)
(setq electric-pair-mode 1)

