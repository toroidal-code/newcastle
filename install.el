;; So the idea is that you copy/paste this code into your *scratch* buffer,
;; hit C-j, and you have a working developper edition of el-get.
(url-retrieve
 "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
 (lambda (s)
   (let (el-get-master-branch)
     (goto-char (point-max))
     (eval-print-last-sexp))))
