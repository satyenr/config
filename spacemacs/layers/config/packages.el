;; -*- mode: emacs-lisp -*-

(setq config-packages '(org ob))

(defun config/pre-init-ob ()
  (setq org-confirm-babel-evaluate nil)
  (setq org-src-fontify-natively t)
  (setq org-src-tab-acts-natively t)
  (setq org-src-preserve-indentation t)
  (setq org-src-window-setup 'current-window)

  (spacemacs|use-package-add-hook org
    :post-config (add-to-list 'org-babel-load-languages '(dot . t))))

(defun config/pre-init-org ()
  (setq org-priority-faces
        '((65 :inherit org-priority :foreground "red")
          (66 :inherit org-priority :foreground "brown")
          (67 :inherit org-priority :foreground "blue")))
  (setq org-structure-template-alist
        '(("n" "#+NAME: ?")
          ("L" "#+LaTeX: ")
          ("h" "#+HTML: ")
          ("q" "#+BEGIN_QUOTE\n\n#+END_QUOTE")
          ("s" "#+BEGIN_SRC ?\n\n#+END_SRC")
          ("se" "#+BEGIN_SRC emacs-lisp\n\n#+END_SRC")
          ("sp" "#+BEGIN_SRC python\n\n#+END_SRC")))

  (add-hook 'org-mode-hook (lambda () (auto-fill-mode 1)))
  (add-hook 'org-mode-hook 'flyspell-mode)

  (setq org-startup-indented nil)
  (setq org-hide-leading-stars t)
  (setq org-hide-emphasis-markers nil)
  (setq org-indent-indentation-per-level 1))

(defun config/post-init-org ()
  (setq org-directory "~/Documents/Notes")
  (setq org-default-notes-file (concat org-directory "/inbox.org"))
  (setq org-startup-with-inline-images t)
  (setq org-image-actual-width nil)
  (custom-set-faces
   '(org-level-1 ((t (:inherit outline-1 :height 1.0))))
   '(org-level-2 ((t (:inherit outline-2 :height 1.0))))
   '(org-level-3 ((t (:inherit outline-3 :height 1.0))))
   '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
   '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
   ))
