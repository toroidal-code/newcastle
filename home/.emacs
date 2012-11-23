(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/plugins/")

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching

;;(require 'yasnippet-bundle)

(add-to-list 'load-path "~/.emacs.d/plugins/autocomplete/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/autocomplete/ac-dict")
(ac-config-default)
(global-auto-complete-mode t)
(auto-complete-mode t)
