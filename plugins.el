(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

(el-get 'sync)


(el-get-install "paredit")
(el-get-install "auto-complete")
(el-get-install "cedet")
(el-get-install "magit")
(el-get-install "j-mode")
(el-get-install "ruby-mode")
(el-get-install "yaml-mode")
(el-get-install "linum+")
