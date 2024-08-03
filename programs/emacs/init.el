(require 'package)
(package-initialize)

(load-theme 'catppuccin :no-confirm)

;; * UI
(set-frame-font "CaskaydiaMono Nerd Font 13")
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; * Evil
(use-package evil
  :init
  (evil-mode 1)
)
