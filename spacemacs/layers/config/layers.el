;; -*- mode: emacs-lisp -*-

(configuration-layer/declare-layers
 '(auto-completion
   better-defaults
   deft
   emoji
   git
   (ivy :variables ivy-extra-directories nil)
   (org :variables org-enable-github-support t
                   org-enable-org-journal-support t)
   osx
   shell
   spell-checking
   syntax-checking
   version-control

   ;; Markup Languages
   csv
   html
   markdown
   yaml

   ;; Programming Languages
   emacs-lisp
   haskell
   java
   javascript
   python
   shell-scripts))
