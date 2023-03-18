(require 'package)

(add-to-list 'package-archives '("melpa-qing" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") t)
;;(add-to-list 'package-archives '("melpa-milkbox" . "http://melpa.milkbox.net/packages/") t) 
;;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(add-to-list 'load-path "~/.emacs.d/core")

;; 加载 .el 文件列表
(defvar package-list-require '(core-pkgs
			       core-ui
			       core-defaults
			       core-funcs
			       core-keybinding
			       core-org
			       language-cpp
			       language-latex))

(mapc #'(lambda (plug-in) (require plug-in))
      package-list-require)

(setq custom-file (expand-file-name "core/core-custom.el"
				    user-emacs-directory))

(when (file-exists-p custom-file) (load-file custom-file))

(provide 'init)
