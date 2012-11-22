(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/plugins/")

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

(el-get 'sync)

;;(require 'yasnippet-bundle)

(add-to-list 'load-path "~/.emacs.d/plugins/autocomplete/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/autocomplete/ac-dict")
(ac-config-default)
(global-auto-complete-mode t)
(auto-complete-mode t)


(setq inferior-lisp-program "/usr/bin/clisp")
(add-to-list 'load-path "~/.emacs.d/plugins/slime/")  ; your SLIME directory
;;(setq slime-lisp-implementations
;;      '((sbcl ("sbcl" "--core" "sbcl.core-for-slime"))))
(require 'slime-autoloads)
(slime-setup)

;;(require 'package)
;;(add-to-list 'package-archives 
;;	     '("marmalade" .
;;	       "http://marmalade-repo.org/packages/"))
;;(package-initialize)


(require 'color-theme)
(load-file "~/.emacs.d/plugins/color-theme-molokai.el")
(color-theme-molokai)


(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'scheme-mode-hook           (lambda () (paredit-mode +1)))
(add-hook 'clojure-mode-hook          (lambda () (paredit-mode +1)))

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

;; dirty fix for having AC everywhere
(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda ()
                       (if (not (minibufferp (current-buffer)))
                         (auto-complete-mode 1))))
(real-global-auto-complete-mode t)

;; create and add new words to the dictionary on the fly
(when (require 'auto-complete-config nil 'noerror)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
  (setq ac-comphist-file  "~/.emacs.d/ac-comphist.dat")
  (ac-config-default))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
