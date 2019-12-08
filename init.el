(require 'package)

(add-to-list 'package-archives '("melpa-qing" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") t)
(add-to-list 'package-archives '("melpa-milkbox" . "http://melpa.milkbox.net/packages/")   t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/")   t)
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/combofish/")

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar package-list '(company
		       hungry-delete
		       better-defaults
		       youdao-dictionary
		       monokai-theme
		       expand-region
		       yasnippet
		       uptimes

		       use-package

		       markdown-mode
		       smartparens
		       
		       restclient
		       ob-go
		       ox-gfm
					;ob-shell

					;exwm
		       swiper
		       lua-mode
		       better-defaults
		       which-key
		       company-anaconda
		       counsel
		       yaml-mode
		       exec-path-from-shell
		       magit
		       helm))


(mapc #'(lambda (pkg)
	  (unless (package-installed-p pkg)
	    (package-install pkg)))
      package-list)

;; 加载 .el 文件列表
(defvar package-list-require
  '(magit

					;ox-gfm
    funcs
    tools
    combofish-defaults
    combofish-org
    combofish-keybindings
    ))

(mapc #'(lambda (plug-in)
	  (require plug-in))
      package-list-require)  

(setq custom-file (expand-file-name 
		   "combofish/combofish-custom.el" user-emacs-directory))

(when (file-exists-p custom-file)
  (load-file custom-file))

(provide 'init)
