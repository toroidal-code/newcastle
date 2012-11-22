((ac-python status "installed" recipe
	    (:name ac-python :description "Simple Python Completion Source for Auto-Complete" :type http :url "http://chrispoole.com/downloads/ac-python.el" :features ac-python))
 (ac-slime status "installed" recipe
	   (:name ac-slime :website "https://github.com/purcell/ac-slime" :description "Emacs auto-complete plugin for Slime symbols" :type github :pkgname "purcell/ac-slime"))
 (bf status "installed" recipe
     (:name bf :auto-generated t :type emacswiki :description "BrainFuck compiler written in Emacs-Lisp" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/bf.el"))
 (cc-mode+ status "installed" recipe
	   (:name cc-mode+ :auto-generated t :type emacswiki :description "Extensions to `c-mode.el' & `cc-mode.el'." :website "https://raw.github.com/emacsmirror/emacswiki.org/master/cc-mode+.el"))
 (clojure-mode status "installed" recipe
	       (:name clojure-mode :website "https://github.com/technomancy/clojure-mode" :description "Emacs support for the Clojure language." :type github :pkgname "technomancy/clojure-mode"))
 (color-theme status "installed" recipe
	      (:name color-theme :description "An Emacs-Lisp package with more than 50 color themes for your use. For questions about color-theme" :website "http://www.nongnu.org/color-theme/" :type http-tar :options
		     ("xzf")
		     :url "http://download.savannah.gnu.org/releases/color-theme/color-theme-6.6.0.tar.gz" :load "color-theme.el" :features "color-theme" :post-init
		     (progn
		       (color-theme-initialize)
		       (setq color-theme-is-global t))))
 (color-theme-almost-monokai status "installed" recipe
			     (:name color-theme-almost-monokai :description "A beautiful, fruity, calm, yet dark color theme for Emacs." :type github :pkgname "lut4rp/almost-monokai" :depends color-theme :prepare
				    (autoload 'color-theme-almost-monokai "color-theme-almost-monokai" "color-theme: almost-monokai" t)))
 (color-theme-zenburn status "removed" recipe nil)
 (diff-mode- status "installed" recipe
	     (:name diff-mode- :auto-generated t :type emacswiki :description "Extensions to `diff-mode.el'." :website "https://raw.github.com/emacsmirror/emacswiki.org/master/diff-mode-.el"))
 (el-get status "installed" recipe
	 (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "4.stable" :pkgname "dimitri/el-get" :info "." :load "el-get.el"))
 (git-commit-mode status "installed" recipe
		  (:name git-commit-mode :description "Major mode for editing git commit messages" :type github :pkgname "rafl/git-commit-mode" :features git-commit))
 (git-emacs status "installed" recipe
	    (:name git-emacs :description "Yet another git emacs mode for newbies" :type github :pkgname "tsgates/git-emacs" :features git-emacs))
 (haml-mode status "installed" recipe
	    (:name haml-mode :description "Major mode for editing Haml files" :type github :pkgname "nex3/haml-mode"))
 (linum+ status "installed" recipe
	 (:name linum+ :auto-generated t :type emacswiki :description "Extension of linum" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/linum+.el"))
 (markdown-mode status "installed" recipe
		(:name markdown-mode :description "Major mode to edit Markdown files in Emacs" :type git :url "git://jblevins.org/git/markdown-mode.git" :before
		       (add-to-list 'auto-mode-alist
				    '("\\.\\(md\\|mdown\\|markdown\\)\\'" . markdown-mode))))
 (marmalade status "removed" recipe nil)
 (package status "installed" recipe
	  (:name package :description "ELPA implementation (\"package.el\") from Emacs 24" :builtin 24 :type http :url "http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el" :shallow nil :features package :post-init
		 (progn
		   (setq package-user-dir
			 (expand-file-name
			  (convert-standard-filename
			   (concat
			    (file-name-as-directory default-directory)
			    "elpa")))
			 package-directory-list
			 (list
			  (file-name-as-directory package-user-dir)
			  "/usr/share/emacs/site-lisp/elpa/"))
		   (make-directory package-user-dir t)
		   (unless
		       (boundp 'package-subdirectory-regexp)
		     (defconst package-subdirectory-regexp "^\\([^.].*\\)-\\([0-9]+\\(?:[.][0-9]+\\)*\\)$" "Regular expression matching the name of\n a package subdirectory. The first subexpression is the package\n name. The second subexpression is the version string."))
		   (setq package-archives
			 '(("ELPA" . "http://tromey.com/elpa/")
			   ("gnu" . "http://elpa.gnu.org/packages/")
			   ("marmalade" . "http://marmalade-repo.org/packages/")
			   ("SC" . "http://joseito.republika.pl/sunrise-commander/"))))))
 (paredit status "installed" recipe
	  (:name paredit :description "Minor mode for editing parentheses" :type http :url "http://mumble.net/~campbell/emacs/paredit.el" :features "paredit"))
 (pymacs status "removed" recipe nil)
 (python status "installed" recipe
	 (:name python :description "Python's flying circus support for Emacs" :type github :pkgname "fgallina/python.el"))
 (python-mode status "installed" recipe
	      (:type github :pkgname "emacsmirror/python-mode" :name python-mode :type emacsmirror :description "Major mode for editing Python programs" :features
		     (python-mode doctest-mode)
		     :compile nil :load "test/doctest-mode.el" :prepare
		     (progn
		       (autoload 'python-mode "python-mode" "Python editing mode." t)
		       (add-to-list 'auto-mode-alist
				    '("\\.py$" . python-mode))
		       (add-to-list 'interpreter-mode-alist
				    '("python" . python-mode)))))
 (rails-el status "installed" recipe
	   (:name rails-el :website "https://github.com/ChandleWEi/rails-el#readme" :description "It is minor mode for editing Ruby On Rails code with Emacs" :type github :pkgname "ChandleWEi/rails-el"))
 (rainbow-mode status "installed" recipe
	       (:name rainbow-mode :description "Colorize color names in buffers" :type elpa))
 (ruby-mode status "installed" recipe
	    (:name ruby-mode :description "Major mode for editing Ruby files. RubyMode provides font-locking, indentation support, and navigation for Ruby code." :type elpa))
 (scala-mode status "installed" recipe
	     (:name scala-mode :description "Major mode for editing Scala code." :type svn :url "http://lampsvn.epfl.ch/svn-repos/scala/scala-tool-support/trunk/src/emacs/" :build
		    ("make")
		    :load-path
		    (".")
		    :features scala-mode-auto))
 (slime status "removed" recipe nil)
 (tomorrow-theme status "installed" recipe
		 (:name tomorrow-theme :description "Colour Schemes for Hackers" :website "https://github.com/chriskempson/tomorrow-theme" :type github :pkgname "chriskempson/tomorrow-theme" :load-path "GNU Emacs" :minimum-emacs-version 24 :post-init
			(add-to-list 'custom-theme-load-path default-directory)))
 (yaml-mode status "installed" recipe
	    (:name yaml-mode :description "Simple major mode to edit YAML file for emacs" :type github :pkgname "yoshiki/yaml-mode"))
 (yasnippet status "installed" recipe
	    (:name yasnippet :website "https://github.com/capitaomorte/yasnippet.git" :description "YASnippet is a template system for Emacs." :type github :pkgname "capitaomorte/yasnippet" :features "yasnippet" :pre-init
		   (unless
		       (or
			(boundp 'yas/snippet-dirs)
			(get 'yas/snippet-dirs 'customized-value))
		     (setq yas/snippet-dirs
			   (list
			    (concat el-get-dir
				    (file-name-as-directory "yasnippet")
				    "snippets"))))
		   :post-init
		   (put 'yas/snippet-dirs 'standard-value
			(list
			 (list 'quote
			       (list
				(concat el-get-dir
					(file-name-as-directory "yasnippet")
					"snippets")))))
		   :compile nil :submodule nil))
 (zenburn-theme status "removed" recipe nil))
