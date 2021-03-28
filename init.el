(require 'package)

(add-to-list 'package-archives '("melpa-qing" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") t) 

;;(add-to-list 'package-archives '("melpa-milkbox" . "http://melpa.milkbox.net/packages/") t) 
;;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/combofish/") (add-to-list
						  'load-path "~/.emacs.d/site-lisp")

(when (not package-archive-contents) (package-refresh-contents))


(defvar package-list '( better-defaults company pip-requirements
					anaconda-mode company-anaconda ;undo-tree
					counsel js2-mode web-mode nodejs-repl ;magit
					htmlize pdf-tools js2-refactor
					highlight-parentheses helm evil yasnippet
					neotree all-the-icons ;; tabbar ;; tabbar-ruler
					vue-mode matlab-mode ;el-get ;cnfonts
					;default-text-scale lua-mode ;exwm ;exwm-edit
					;helm-ag ;全局搜索。
					hungry-delete
					youdao-dictionary slime slime-company
					elisp-slime-nav swiper smartparens
					monokai-theme flycheck elpy

					julia-mode flycheck-julia ;pyim ;posframe
					;use-package ; ein 
					expand-region 
					py-autopep8 
					;					dashboard ;markdown-mode ;material-theme ;fcitx
					use-package

					;New config 
					key-chord
					;;iy-go-to-char 
					multiple-cursors 
					iedit

					company hungry-delete better-defaults
					youdao-dictionary monokai-theme expand-region
					yasnippet uptimes

					use-package

					markdown-mode smartparens
					
					ob-restclient ;restclient
					ob-go ox-gfm ;ob-shell

					;exwm 
					swiper 
					lua-mode
					better-defaults which-key company-anaconda
					counsel yaml-mode exec-path-from-shell magit
					helm ))


(mapc #'(lambda (pkg) (unless (package-installed-p pkg)
			(package-install pkg))) package-list)


;;own function.  (defun open-my-init-file () (interactive) (find-file "~/.emacs.d/init.el"))

(defun open-eshell-other-buffer () "Open eshell in other buffer"
       (interactive) (split-window-vertically) (eshell))

;;(fset 'eval-replace (kmacro-lambda-form [?\C-j backspace ?\C-a
;;      backspace ?  ?\C-b ?\C-= backspace ?\M-x ?d ?e ?l down return
;;      ?\M-f] 0 "%d"))

(global-set-key (kbd "C-c t e") 'eval-replace)

;;;<init-packages>

(autoload 'lua-mode "lua-mode" "Lua editing mode." t) (add-to-list
						       'auto-mode-alist '("\\.lua$" . lua-mode)) (add-to-list
						       'interpreter-mode-alist '("lua" . lua-mode))

(setq auto-mode-alist (append '(("\\.handlebars\\'" . web-mode))
			      '(("\\.js\\'" . js2-mode)) '(("\\.wpy\\'" . vue-mode))
			      '(("\\.html\\'" . web-mode)) '(("\\.wxml\\'" . web-mode))
			      auto-mode-alist))

;;(add-hook 'js-mode-hook #'js2-refactor-mode)
;;(js2r-add-keybindings-with-prefix "C-c C-m")

(defun my-web-mode-indent-setup () (setq web-mode-markup-indent-offset	 2) ; web-mode, html tag in html file 
       (setq web-mode-css-indent-offset 2) ; web-mode, css in html file 
       (setq web-mode-code-indent-offset 2) ; web-mode, ;js code in html file )
       (add-hook 'web-mode-hook 'my-web-mode-indent-setup)

       (defun my-toggle-web-indent () (interactive) ;; web development (if
	      (or (eq major-mode 'js-mode) (eq major-mode 'js2-mode)) (progn (setq
									      js-indent-level (if (= js-indent-level 2) 4 2)) (setq
									      js2-basic-offset (if (= js2-basic-offset 2) 4 2))))

       (if (eq major-mode 'web-mode) (progn (setq
					     web-mode-markup-indent-offset (if (=
										web-mode-markup-indent-offset 2) 4 2)) (setq
					     web-mode-css-indent-offset (if (= web-mode-css-indent-offset 2)
									    4 2)) (setq web-mode-code-indent-offset (if (=
															 web-mode-code-indent-offset 2) 4 2)))) (if (eq major-mode
																					'css-mode) (setq css-indent-offset (if (= css-indent-offset 2) 4
																									     2)))

       (setq indent-tabs-mode nil))

(global-set-key (kbd "C-c t i") 'my-toggle-web-indent)

;;(require 'nodejs-repl)
;; (add-hook 'js-mode-hook (lambda () (define-key js-mode-map (kbd
;; 			  "C-x C-e")
;; 			  'nodejs-repl-send-last-expression)
;; 			  (define-key js-mode-map (kbd "C-c C-j")
;; 			  'nodejs-repl-send-line) (define-key
;; 			  js-mode-map (kbd "C-c C-r")
;; 			  'nodejs-repl-send-region) (define-key
;; 			  js-mode-map (kbd "C-c C-l")
;; 			  'nodejs-repl-load-file) (define-key
;; 			  js-mode-map (kbd "C-c C-z")
;; 			  'nodejs-repl-switch-to-repl)))

(require 'yasnippet) (yas-global-mode 1)

;; (use-package markdown-mode :ensure t :mode (("README\\.md\\'"
;;   . gfm-mode) ("\\.md\\'" . markdown-mode) ("\\.markdown\\'"
;;   . markdown-mode)) :init (setq markdown-command "multimarkdown"))

(setq inferior-lisp-program "/usr/bin/sbcl" slime-contribs
      '(slime-fancy slime-company))

;;(load (expand-file-name "~/quicklisp/slime-helper.el"))

;; (define-key company-active-map (kbd "\C-n") 'company-select-next)
;; (define-key company-active-map (kbd "\C-p")
;; 'company-select-previous) (define-key company-active-map (kbd
;; "\C-d") 'company-show-doc-buffer) (define-key company-active-map
;; (kbd "M-.") 'company-show-location)

(elpy-enable) (when (require 'flycheck nil t) (setq elpy-modules (delq
								  'elpy-module-flymake elpy-modules)) (add-hook 'elpy-mode-hook
														'flycheck-mode))



(mapc #'(lambda (pkg) (unless (package-installed-p pkg)
			(package-install pkg))) package-list)

;; 加载 .el 文件列表
(defvar package-list-require '(cl all-the-icons
				  neotree
				  linum 
				  ;;magit

				  julia-mode
				  flycheck-julia 
				  ;; New config

				  key-chord ;; iy-go-to-char 
				  multiple-cursors
				  combofish-test 
				  ;; End new config

				  highlight-parentheses
				  magit 
					;ox-gfm 
				  funcs
				  tools
				  combofish-defaults
				  combofish-org
				  combofish-keybindings ))


(mapc #'(lambda (plug-in) (require plug-in)) package-list-require)


(combofish-mode 1) (key-chord-mode 1)

(flycheck-julia-setup) 
;;(add-to-list 'flycheck-global-modes 'julia-mode) 
;;(add-to-list 'flycheck-global-modes 'ess-julia-mode)

(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;;(global-undo-tree-mode)

;; (dolist (charset '(kana han cjk-misc bopomofo)) (set-fontset-font
;;     "fontset-default" charset (font-spec :family "STHeiti")))

(set-fontset-font "fontset-default" 'cp936 '("SimSun"
					     . "unicode-bmp"))


(setq custom-file (expand-file-name "combofish/combofish-custom.el"
				    user-emacs-directory))

(when (file-exists-p custom-file) (load-file custom-file))

(provide 'init)
