;;; -*- lexical-binding: t; -*-

;; deft
(setq deft-directory "~/Documents/Notes")
(setq deft-extensions '("txt" "md" "org"))
(setq deft-use-filter-string-for-filename t)
(setq deft-recursive t)

;; leetcode
(setq leetcode-prefer-language "python3")
(setq leetcode-prefer-sql "mysql")

;; org-mode
(setq org-directory "~/Documents/Notes")

;; org-journal
(setq org-journal-dir "~/Documents/Journal")
(setq org-journal-file-type 'yearly)
(setq org-journal-file-format "%Y")

;; markdown
(remove-hook '+markdown-compile-functions #'+markdown-compile-marked)
