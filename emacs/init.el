(setq inhibit-startup-message t)
(setq backup-directory-alist `(("." . "~/notes/.backup")))

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(set-fringe-mode 10)
(column-number-mode)
(global-display-line-numbers-mode t)

(setq custom-safe-themes t)
(load-theme 'wombat)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit) ; make escape quit prompts

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

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
  (setq evil-want-Y-yank-to-eol t)
  (setq evil-toggle-key "C-s")
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-mode 1))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(unless (display-graphic-p)
  (require 'evil-terminal-cursor-changer)
  (evil-terminal-cursor-changer-activate)
  )

(use-package org
  :hook ((org-mode . visual-line-mode)
         (org-mode . org-indent-mode))
  :config
  (setq org-agenda-files '("~/notes/"))
  (setq org-capture-templates
    '(
      ("t" "Todo" entry (file "~/notes/task.org")
       "* TODO %?\n  %i %t %a")
     )
  )
  (use-package org-bullets :hook (org-mode . org-bullets-mode)))

(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-ca" 'org-agenda-list)
(define-key evil-normal-state-map (kbd "zc") 'org-hide-entry)
(define-key evil-normal-state-map (kbd "zo") 'org-show-entry)

(use-package org-roam
  :ensure t
  :init
  :custom
  (org-roam-directory "~/notes/roam")
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i" . completion-at-point))
  :config
  (org-roam-setup))

;; Autocompletion
(use-package vertico
  :ensure t
  :bind (:map vertico-map
        ("C-j" . vertico-next)
        ("C-k" . vertico-previous))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package savehist
  :init
  (savehist-mode))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package marginalia
  :after vertico
  :ensure t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))
