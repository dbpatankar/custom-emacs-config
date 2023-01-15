(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

(global-visual-line-mode 1)

(global-auto-revert-mode 1)

(setq
   split-width-threshold 0
   split-height-threshold nil)

(defalias 'yes-or-no-p 'y-or-n-p)

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
  )

(use-package doom-themes
  :ensure t
  :config
  )

(load-theme 'leuven-dark t)

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
    "m e" 'org-export-dispatch
    "m @" 'org-ref-insert-cite-link
    "m !" 'org-ref-insert-ref-link)
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

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode)
  )

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode)
  )
(use-package yasnippet-snippets
  :ensure t)

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
  :config
  ;;(variable-pitch-mode nil)
  (setq org-latex-listings 'minted) ;; or t
  (add-to-list 'org-latex-packages-alist '("" "minted")) ;; or listings
  (add-to-list 'org-latex-packages-alist '("" "xcolor"))
  (setq bibtex-dialect 'biblatex)
  (setq  org-latex-pdf-process '("latexmk -shell-escape -%latex -bibtex -interaction=nonstopmode -f -pdf %f"))
  (with-eval-after-load 'ox-latex
    (add-to-list 'org-latex-classes
		 '("book-nodefaults"
		   "\\documentclass{book}"
		   ("\\chapter{%s}" . "\\chapter*{%s}")
		   ("\\section{%s}" . "\\section*{%s}")
		   ("\\subsection{%s}" . "\\subsection*{%s}")
		   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
		   ))
    (add-to-list 'org-latex-classes
		 '("exam"
		   "\\documentclass{exam}"
		   ("\\chapter{%s}" . "\\chapter*{%s}")
		   ("\\section{%s}" . "\\section*{%s}")
		   ("\\subsection{%s}" . "\\subsection*{%s}")
		   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
		   ))
    (add-to-list 'org-latex-classes
		 '("article-nodefaults"
		   "\\documentclass{article}"
		   ("\\section{%s}" . "\\section*{%s}")
		   ("\\subsection{%s}" . "\\subsection*{%s}")
		   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
		   )))

  (add-hook 'org-mode-hook #'org-inline-pdf-mode)
  (add-hook 'org-mode-hook
	    (lambda () (add-hook 'after-save-hook #'org-babel-tangle
				 :append :local)))
  (add-hook 'org-mode-hook 'toc-org-mode)
  )

(use-package toc-org
  :ensure t)

(use-package org-superstar
  :ensure t
  :custom
  (org-superstar-headline-bullets-list '("◉" "○" "✿" "🞛" "✜" "◆" "▶" "✸" "☯" "☯" "☯" "☯" "☯" "☯" ))
  :config
  (set-face-attribute 'org-level-8 nil :weight 'bold :inherit 'default)
  ;; ;; Low levels are unimportant = no scaling
  ;; (set-face-attribute 'org-level-7 nil :inherit 'org-level-8)
  ;; (set-face-attribute 'org-level-6 nil :inherit 'org-level-8)
  ;; (set-face-attribute 'org-level-5 nil :inherit 'org-level-8)
  ;; (set-face-attribute 'org-level-4 nil :inherit 'org-level-8)
  ;; ;; Top ones get scaled the same as in LaTeX (\large, \Large, \LARGE)
  (set-face-attribute 'org-level-3 nil :inherit 'org-level-8 :height 1.2) ;\large
  (set-face-attribute 'org-level-2 nil :inherit 'org-level-8 :height 1.44) ;\Large
  (set-face-attribute 'org-level-1 nil :inherit 'org-level-8 :height 1.728) ;\LARGE
  ;; ;; Only use the first 4 styles and do not cycle.
  ;; (org-cycle-level-faces nil)
  ;; (org-n-level-faces 4)
  ;; ;; Document Title, (\huge)
  ;; (set-face-attribute 'org-document-title nil
  ;;                 :height 2.074
  ;;                 :foreground 'unspecified
  ;;                 :inherit 'org-level-8)
  :hook (org-mode . org-superstar-mode)
  )

(use-package org-ref
  :ensure t
  :after org
  :init
  ;;(require 'org-ref-helm)
  (require 'org-ref-ivy)
  (setq org-ref-default-citation-link "autocite")
  :config
  (setq bibtex-dialect 'biblatex)
  :bind
  (("C-c c" . org-ref-insert-cite-link)
   ("C-c r" . org-ref-insert-ref-link))
  )

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
  ;; Use jupyter for REPL
  ;;  (setq python-shell-interpreter "jupyter"
  ;;	python-shell-interpreter-args "console --simple-prompt"
  ;;	python-shell-prompt-detect-failure-warning nil)
  ;;  (add-to-list 'python-shell-completion-native-disabled-interpreters
  ;;	       "jupyter")
  ;; Use IPython for REPL
  (setq python-shell-interpreter "ipython"
	python-shell-interpreter-args
	"-i --simple-prompt --InteractiveShell.display_page=True"
	python-shell-prompt-detect-failure-warning nil)
  (add-to-list 'python-shell-completion-native-disabled-interpreters
	       "ipython")

  ;; Enable Flycheck
  (when (require 'flycheck nil t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode))
  )

(setq tcl-application "~/bin/OpenSees")

(use-package rust-mode
  :ensure t)
(use-package rustic
  :ensure t)

'(TeX-PDF-mode t)
(use-package tex
  :ensure auctex)
(add-hook 'tex-mode-hook 'lsp-mode)
(add-hook 'tex-mode-hook 'flycheck-mode)
;; Use LatexMK for compiling and inheret pdf setting from auctex
(use-package auctex-latexmk
  :ensure t
  :config
  (auctex-latexmk-setup)
  (setq auctex-latexmk-inherit-TeX-PDF-mode t)
  )
;; Use RefTeX for citations and references
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
;; Use helm-bibtex for references and citations
;; (use-package helm
;; :ensure t)
;; (use-package helm-bibtex
;; :ensure t)
;; (autoload 'helm-bibtex "helm-bibtex" "" t)

;; Use ivy-bibtex for citations and references
;; (use-package ivy-bibtex
;;   :ensure t
;;   :config
;;   (autoload 'ivy-bibtex "ivy-bibtex" "" t)
;;   ;; ivy-bibtex requires ivy's `ivy--regex-ignore-order` regex builder, which
;;   ;; ignores the order of regexp tokens when searching for matching candidates.
;;   ;; Add something like this to your init file:
;;   (setq ivy-re-builders-alist
;; 	  '((ivy-bibtex . ivy--regex-ignore-order)
;; 	    (t . ivy--regex-plus)))
;;   ;; Change default action to insert citation from open URL
;;   (setq ivy-bibtex-default-action 'ivy-bibtex-insert-citation)
;;   (setq ivy-bibtex-default-multi-action 'ivy-bibtex-insert-key)
;;   (setq bibtex-completion-cite-prompt-for-optional-arguments nil)
;;   :bind
;;   (
;;    ("C-c c" . ivy-bibtex-with-local-bibliography)
;;    )
;;   )

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
