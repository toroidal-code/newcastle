(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/plugins/")

(load-file "~/.emacs.d/plugins/load-path.el")
(set-exec-path-from-shell-PATH)

;; EL-GET should always be at the top, so files are required
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

(el-get 'sync)

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching

;;The Molokai color theme
(if window-system
	(progn
	  ;;(load-file "~/.emacs.d/themes/solarized/solarized.el")
	  ;;(load-file "~/.emacs.d/themes/solarized/solarized-dark-theme.el")
	  ;;(load-file "~/.emacs.d/themes/solarized/solarized-light-theme.el")
      (load-file "~/.emacs.d/themes/monokai/monokai-theme.el")
	  ;;(load-file "~/.emacs.d/themes/zenburn/zenburn-theme.el")
	  ;;(load-theme 'solarized-dark t)
	  (load-theme 'monokai t)
	  )
  (progn
	(require 'color-theme)
	(color-theme-initialize)
	(load-file "~/.emacs.d/plugins/color-theme-molokai.el")
	(color-theme-molokai)))

;; No toolbar
(when window-system
  (tool-bar-mode -1))

;; Powerline
(require 'powerline)
(powerline-default)

;; Linum Line Numberings
;;(require 'linum+)
(setq linum-format "%d ")
(when window-system (global-linum-mode 1))

;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
;; IMPORTANT: For Emacs >= 23.2, you must place this *before* any
;; CEDET component (including EIEIO) gets activated by another
;; package (Gnus, auth-source, ...).
(require 'cedet)
;;(load-file "~/.emacs.d/el-get/cedet/cedet-devel-load.el")

(semantic-load-enable-excessive-code-helpers)

;; Load CEDET CONTRIB.
(load-file "~/.emacs.d/el-get/cedet/contrib/cedet-contrib-load.elc")

;; imenu breaks if I don't enable this
(global-semantic-highlight-func-mode 1)

;; Add further minor-modes to be enabled by semantic-mode.
;; See doc-string of `semantic-default-submodes' for other things
;; you can use here.
(add-to-list 'semantic-default-submodes 'global-semantic-tag-folding-mode t)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode t)

;; Enable Semantic
(semantic-mode 1)

;; Enable EDE (Project Management) features
(global-ede-mode nil)

;; Enable global folding
;;(require 'semantic-tag-folding)
;;(global-semantic-tag-folding-mode 1)
(global-set-key (kbd  "\C-c f") 'senator-fold-tag-toggle)
;;(local-set-key (kbd  "C-c C-x [") 'semantic-tag-folding-show-block)

;; Load ECB
(require 'ecb)

;; ===== Languages =============================

;; RSENSE
(setq rsense-home "/home/kate/.emacs.d/el-get/rsense/")
(require 'rsense)

(add-to-list 'load-path "~/.emacs.d/plugins/")                                                                                 
;;(require 'wisent-ruby)
(add-hook 'ruby-mode-hook #'wisent-ruby-default-setup)

;; SLIME
(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "sbcl")

;; Stop SLIME's REPL from grabbing DEL,
;; which is annoying when backspacing over a '('
(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))

;;Setup Paredit
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'scheme-mode-hook           (lambda () (paredit-mode +1)))
(add-hook 'clojure-mode-hook          (lambda () (paredit-mode +1)))
(add-hook 'slime-repl-mode-hook       (lambda () (paredit-mode +1)))

;; Auto-Complete
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)
(auto-complete-mode t)

;; create and add new words to the dictionary on the fly
(when (require 'auto-complete-config nil 'noerror)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
  (setq ac-comphist-file "~/.emacs.d/ac-comphist.dat")
  (ac-config-default))

;; Rsense's AC Mode
(add-hook 'ruby-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-rsense-method)
            (add-to-list 'ac-sources 'ac-source-rsense-constant)))

(require 'auto-complete-clang-async)

(defun ac-cc-mode-setup ()
  (setq ac-clang-complete-executable "~/.emacs.d/clang-complete")
  (setq ac-sources '(ac-source-clang-async))
  (ac-clang-launch-completion-process))

(defun my-ac-config ()
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))

(my-ac-config)

;; Auto-magic indenting
(dolist (command '(yank yank-pop)) 
  (eval `(defadvice ,command (after  indent-region activate)
		   (and (not current-prefix-arg)
				(member major-mode '(emacs-lisp-mode lisp-mode
													 clojure-mode    scheme-mode
													 haskell-mode    ruby-mode
													 rspec-mode      python-mode
													 c-mode          c++-mode
													 objc-mode       latex-mode
													 plain-tex-mode))
				(let ((mark-even-if-inactive transient-mark-mode))
				  (indent-region (region-beginning) (region-end) nil))))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("293e0b3c09c816a541fcd5716131804f3eae38c7f625f48d5d5845e19f9323bf" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d24e10524bb50385f7631400950ba488fa45560afcadd21e6e03c2f5d0fad194" "36a309985a0f9ed1a0c3a69625802f87dee940767c9e200b89cdebdb737e5b29" default)))
 '(ecb-auto-activate t)
 '(ecb-options-version "2.40")
 '(ecb-tip-of-the-day nil)
 '(python-shell-interpreter "python3")
 '(ruby-indent-level 4)
 '(ruby-indent-tabs-mode nil)
 '(tab-stop-list (quote (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120)))
 '(tab-width 4))

;; Enable mouse support
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] '(lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda ()
                              (interactive)
                              (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t))



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
