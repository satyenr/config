;; -*- coding: utf-8 -*-
;; https://blog.jft.rocks/emacs/emacs-from-scratch.html

;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)

;; Font and Frame Size
(add-to-list 'default-frame-alist '(font   . "Source Code Pro-12"))
(add-to-list 'default-frame-alist '(height . 24))
(add-to-list 'default-frame-alist '(width  . 80))

;; Package Management
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
                         ("gnu"   . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Evil Mode
(use-package evil
             :ensure t
             :config (evil-mode 1))

;; Theme
(use-package doom-themes
             :ensure t
             :config (load-theme 'doom-one t))

;; Helm
(use-package helm
  :ensure t
  :init (setq helm-M-x-fuzzy-match t
              helm-mode-fuzzy-match t
              helm-buffers-fuzzy-matching t
              helm-recentf-fuzzy-match t
              helm-locate-fuzzy-match t
              helm-semantic-fuzzy-match t
              helm-imenu-fuzzy-match t
              helm-completion-in-region-fuzzy-match t
              helm-candidate-number-list 150
              helm-split-window-in-side-p t
              helm-move-to-line-cycle-in-source t
              helm-echo-input-in-header-line t
              helm-autoresize-max-height 0
              helm-autoresize-min-height 20)
  :config (helm-mode 1))

;; Which Key
(use-package which-key
  :ensure t
  :init (setq which-key-separator " "
              which-key-prefix-prefix "+")
  :config (which-key-mode 1))

;; Custom Keybindings
(use-package general
             :ensure t
             :config (general-define-key :states '(normal visual insert emacs)
                                         :prefix "SPC"
                                         :non-normal-prefix "M-SPC"
                                         "TAB" '(switch-to-prev-buffer :which-key "previous buffer")
                                         "SPC" '(helm-M-x :which-key "M-x")
                                         "pf"  '(helm-find-files :which-key "find files")
                                         "bb"  '(helm-buffers-list :which-key "buffers list")
                                         "wl"  '(windmove-right :which-key "move right")
                                         "wh"  '(windmove-left :which-key "move left")
                                         "wk"  '(windmove-up :which-key "move up")
                                         "wj"  '(windmove-down :which-key "move bottom")
                                         "w/"  '(split-window-right :which-key "split right")
                                         "w-"  '(split-window-below :which-key "split bottom")
                                         "wx"  '(delete-window :which-key "delete window")
                                         "at"  '(ansi-term :which-key "open terminal")))

;; macOS Titlebar
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq ns-use-proxy-icon  nil)
(setq frame-title-format nil)

;; Projectile
(use-package projectile
             :ensure t
             :init (setq projectile-require-project-root nil)
             :config (projectile-mode 1))

;; Icons
(use-package all-the-icons :ensure t)

;; NeoTree
(use-package neotree
             :ensure t
             :init (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

;; Show matching parens
(setq show-paren-delay 0)
(show-paren-mode 1)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (neotree projectile general which-key helm doom-themes evil use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
