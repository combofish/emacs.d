(require 'package)

(add-to-list 'package-archives '("melpa-qing" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
(add-to-list 'package-archives '("melpa-milkbox" . "http://melpa.milkbox.net/packages/")   t)
;;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/")   t)
(package-initialize)

(defvar combofish-init-time 'nil)
(defun combofish-display-benchmark()
  (message "Emacs loaded %s packages in %.03fs"
           (length package-activated-list)
           (or combofish-init-time
               (setq combofish-init-time (float-time (time-subtract (current-time) before-init-time))))))

(add-hook 'emacs-startup-hook #'combofish-display-benchmark)

(add-to-list 'load-path "~/.emacs.d/combofish/")

;; (when (not package-archive-contents)
;;    (package-refresh-contents))

(mapc #'(lambda (pkg)
          (unless (package-installed-p pkg)
            (package-install pkg)))
      '(
	better-defaults
        company
        counsel
	js2-mode
	web-mode
	nodejs-repl
	js2-refactor
	highlight-parentheses
	helm
	yasnippet
	neotree
	all-the-icons
;;	tabbar
;;	tabbar-ruler
	vue-mode
                                        ;el-get
                                        ;cnfonts
					;default-text-scale
	lua-mode
	exwm
                                        ;exwm-edit
					;helm-ag   ;全局搜索。
        hungry-delete
        iedit
        youdao-dictionary
					;slime
        swiper
        smartparens
	monokai-theme
        flycheck
	elpy
					;pyim
					;posframe
					;use-package
                                        ;       ein
        expand-region
	py-autopep8
                                        ; dashboard
					;markdown-mode
					;material-theme
					;fcitx
                                        ;use-package
        ))

;;own function.
(defun open-my-init-file ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun open-eshell-other-buffer ()
  "Open eshell in other buffer"
  (interactive)
  (split-window-vertically)
  (eshell))

;;;<init-packages>

(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       '(("\\.wpy\\'" . vue-mode))
       '(("\\.html\\'" . web-mode))
       '(("\\.wxml\\'" . web-mode))
       auto-mode-alist))

(add-hook 'js-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-m")

(defun my-web-mode-indent-setup ()
  (setq web-mode-markup-indent-offset 2) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset 2)    ; web-mode, css in html file
  (setq web-mode-code-indent-offset 2)   ; web-mode, js code in html file
  )
(add-hook 'web-mode-hook 'my-web-mode-indent-setup)

(defun my-toggle-web-indent ()
  (interactive)
  ;; web development
  (if (or (eq major-mode 'js-mode) (eq major-mode 'js2-mode))
      (progn
	(setq js-indent-level (if (= js-indent-level 2) 4 2))
	(setq js2-basic-offset (if (= js2-basic-offset 2) 4 2))))

  (if (eq major-mode 'web-mode)
      (progn (setq web-mode-markup-indent-offset (if (= web-mode-markup-indent-offset 2) 4 2))
	     (setq web-mode-css-indent-offset (if (= web-mode-css-indent-offset 2) 4 2))
	     (setq web-mode-code-indent-offset (if (= web-mode-code-indent-offset 2) 4 2))))
  (if (eq major-mode 'css-mode)
      (setq css-indent-offset (if (= css-indent-offset 2) 4 2)))

  (setq indent-tabs-mode nil))

(global-set-key (kbd "C-c t i") 'my-toggle-web-indent)

(require 'nodejs-repl)

(add-hook 'js-mode-hook (lambda () (define-key js-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-expression)
			  (define-key js-mode-map (kbd "C-c C-j") 'nodejs-repl-send-line)
			  (define-key js-mode-map (kbd "C-c C-r") 'nodejs-repl-send-region)
			  (define-key js-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
			  (define-key js-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)))

(require 'yasnippet)
(yas-global-mode 1)

;; (use-package markdown-mode
;;   :ensure t
;;   :mode (("README\\.md\\'" . gfm-mode)
;;          ("\\.md\\'" . markdown-mode)
;;          ("\\.markdown\\'" . markdown-mode))
;;   :init (setq markdown-command "multimarkdown"))

;; Set your lisp system and, optionally, some contribs
;; (setq inferior-lisp-program "/usr/bin/sbcl"
;;                                         ;slime-contribs '(slime-fancy)
;;       )
;; (load (expand-file-name "~/quicklisp/slime-helper.el"))

(elpy-enable)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; ;;enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 15)


;;; package-init

;; (require 'exwm)
;; (require 'exwm-config)
;; (exwm-config-default)

;; (defun exwm-open-google-chrome-stable ()
;;   (interactive)
;;   (start-process-shell-command "start-google-chrome-stable" nil "google-chrome-stable"))
;; (start-process-shell-command "touming" nil "xcompmgr -FCf -nc -t -5 &")

;;>>>>
;; 设置垃圾回收，在 Windows 下，emacs25 版本会频繁出发垃圾回收，所以需要设置
(when (eq system-type 'windows-nt) 
  (setq gc-cons-threshold (* 512 1024 1024)) 
  (setq gc-cons-percentage 0.5) 
  (run-with-idle-timer 5 t #'garbage-collect)
  ;; 显示垃圾回收信息，这个可以作为调试用;; 
  (setq garbage-collection-messages t))

(helm-mode t)
;;>>>>
(mapc #'(lambda (plug-in)
	  (require plug-in))
      '(cl
	all-the-icons
	neotree
	highlight-parentheses
	combofish-defaults
	combofish-keybindings))

(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

					;(require 'combofish-org)

(setq custom-file (expand-file-name 
		   "combofish/combofish-custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load-file custom-file))
;;# line 99
(provide 'init)
