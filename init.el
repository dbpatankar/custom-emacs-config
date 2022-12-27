(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

(global-auto-revert-mode 1)

(setq
   split-width-threshold 0
   split-height-threshold nil)

(use-package dashboard
  :ensure t
  :custom
  (dashboard-center-content 1)
  :config
  (dashboard-mode)
  (dashboard-refresh-buffer))

;;(use-package spacemacs-theme
;;  :ensure t)

(use-package leuven-theme
  :ensure t
  :config
  (load-theme 'leuven-dark t)
)

(use-package doom-themes
  :ensure t
  :config
  ;;(load-theme 'doom-dracula t)
)

(use-package doom-modeline
  :ensure t
  :init
  (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 15))

(set-face-attribute 'default nil :family "Fira Code" :height 140)

(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  ;; KEYBINDINGS
  (evil-leader/set-key
  "f f" 'counsel-find-file
  "f r" 'counsel-recentf
  "b b" 'counsel-switch-buffer
  "b d" 'kill-this-buffer
  "h v" 'counsel-describe-variable
  "h f" 'counsel-describe-function
  "h o" 'counsel-describe-symbol
  "g g" 'magit
  "w v" 'evil-window-vsplit
  "w w" 'evil-window-next
  "w c" 'evil-window-delete
  )
  (evil-leader/set-key-for-mode 'org-mode
    "m e" 'org-export-dispatch)
  (evil-leader/set-key-for-mode 'julia-mode
    "c c" 'julia-repl-send-region-or-line
    "c b" 'julia-repl-send-buffer)
)


(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (setq evil-overriding-maps nil)
  (setq evil-intercept-maps nil))

(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x))
  :config
  (setq ivy-initial-inputs-alist nil)) ;; Dont start searches with ^

(use-package smex   ;; recent commands in counsel-M-x
  :ensure t
  :defer 1
  :after counsel)

(use-package ivy
  :ensure t
  :config
    (ivy-mode)
    (setq ivy-use-virtual-buffers t)
    (setq enable-recursive-minibuffers t)
    ;; enable this if you want `swiper' to use it
    (setq search-default-mode #'char-fold-to-regexp)
    (global-set-key "\C-s" 'swiper-isearch)
    ;;(global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    (global-set-key (kbd "<f1> f") 'counsel-describe-function)
    (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
    (global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
    (global-set-key (kbd "<f1> l") 'counsel-find-library)
    (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
    (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "C-x l") 'counsel-locate)
    (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
    ;;(global-set-key (kbd "SPC-b b") 'ivy-switch-buffer)
    (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history))

(use-package ivy-rich
  :ensure t
  :init
  (ivy-rich-mode 1))

(use-package vertico
  :ensure t
  :config
  (vertico-mode 1))

(use-package helpful  ;; probably not needed. Can be commented
  :ensure t
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-symbol] . counsel-describe-symbol)
  ([remap describe-command] . helpful-command)
  ([remap describe-key] . helpful-key))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package orderless

  :ensure t)

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package elfeed-goodies
  :ensure t)

(use-package elfeed
  :ensure t
  :config
  (require 'elfeed-goodies)
  (elfeed-goodies/setup)
  (setq elfeed-feeds '(("https://www.reddit.com/r/linux.rss" linux reddit)
		       ("https://www.reddit.com/r/emacs.rss" emacs reddit)
		       ("https://www.reddit.com/r/julia.rss" julia programming reddit)
		       ("http://timesofindia.indiatimes.com/rssfeedstopstories.cms" TOI news)
		       ("https://distrowatch.com/news/dw.xml" distrowatch linux)
                       ("https://rss.slashdot.org/Slashdot/slashdotMain" shashdot linux)
 )))

(use-package org
  ;;:ensure t
  )

(use-package toc-org
  :ensure t)

(add-to-list 'load-path "/usr/share/asymptote/")
(add-to-list 'load-path "/home/digvijay/emacs_custom_libs/")
(require 'ob-asymptote)
(autoload 'asy-mode "asy-mode.el" "Asymptote major mode." t)
(autoload 'lasy-mode "asy-mode.el" "hybrid Asymptote/Latex major mode." t)
(autoload 'asy-insinuate-latex "asy-mode.el" "Asymptote insinuate LaTeX." t)
(add-to-list 'auto-mode-alist '("\\.asy$" . asy-mode))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((asymptote . t)))

(use-package lsp-mode
:ensure t
)

(use-package julia-mode
  :ensure t
  :config
  (add-hook 'julia-mode-hook 'julia-repl))

;; UNICODE support
(add-hook 'term-exec-hook
	  (function
	   (lambda ()
	     (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))))
(defadvice ansi-term (after advise-ansi-term-coding-system)
    (set-process-coding-system 'utf-8-unix 'utf-8-unix))
(ad-activate 'ansi-term)
(set-terminal-coding-system 'utf-8)

(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  ;; Use IPython for REPL
  ;;  (setq python-shell-interpreter "jupyter"
  ;;	python-shell-interpreter-args "console --simple-prompt"
  ;;	python-shell-prompt-detect-failure-warning nil)
  ;;  (add-to-list 'python-shell-completion-native-disabled-interpreters
  ;;	       "jupyter")
  ;; Use IPython for REPL
  (setq python-shell-interpreter "ipython"
	python-shell-interpreter-args
	"-i --simple-prompt --InteractiveShell.display_page=True")
  ;;   (setq python-shell-interpreter "ipython"
  ;; 	python-shell-prompt-detect-failure-warning nil)
  ;;   (add-to-list 'python-shell-completion-native-disabled-interpreters
  ;; 	       "ipython")

  ;; Enable Flycheck
  (when (require 'flycheck nil t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode))
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(helpful smex rainbow-delimiters ivy-rich doom-modeline dashboard julia-mode julia-repl orderless magit evil-leader counsel ivy org which-key vertico use-package evil doom-themes)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
