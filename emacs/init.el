(setq inhibit-startup-message t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(set-fringe-mode 10)
(column-number-mode)
(global-display-line-numbers-mode t)

(set-face-attribute 'default nil :font "NanumGothicCoding" :height 200)

(load-theme 'wombat)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1))

(use-package org
  :hook ((org-mode . visual-line-mode)
         (org-mode . org-indent-mode))
  :config
  (use-package org-bullets :hook (org-mode . org-bullets-mode)))
