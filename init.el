1(require 'package)

(add-to-list 'package-archives '("melpa-qing" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") t)
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

(require 'uptimes)

(when (not package-archive-contents)
  (package-refresh-contents))

(mapc #'(lambda (pkg)
          (unless (package-installed-p pkg)
            (package-install pkg)))
      '(
	better-defaults
        company
        which-key
        org-mind-map
	pip-requirements
	anaconda-mode
	company-anaconda
	undo-tree
        counsel
	js2-mode
	web-mode
	nodejs-repl
					;magit
	htmlize
	pdf-tools
	js2-refactor
	highlight-parentheses
	helm
	evil
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
	slime slime-company elisp-slime-nav
        swiper
        smartparens
	monokai-theme
        flycheck
	elpy

	julia-mode
	flycheck-julia
					;pyim
					;posframe
					;use-package
                                        ;       ein
        expand-region
	py-autopep8
                                        ; dashboard
        markdown-mode
					;material-theme
					;fcitx
        use-package
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
       '(("\\.handlebars\\'"  . web-mode))
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
;; snippet2
(require 'yasnippet)
(yas-global-mode 1)

;; markdown
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
  "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

;; (use-package markdown-mode
;;   :ensure t
;;   :mode (("README\\.md\\'" . gfm-mode)
;;          ("\\.md\\'" . markdown-mode)
;;          ("\\.markdown\\'" . markdown-mode))
;;   :init (setq markdown-command "multimarkdown"))

(setq inferior-lisp-program "/usr/bin/sbcl"
      slime-contribs '(slime-fancy slime-company))

;; (load (expand-file-name "~/quicklisp/slime-helper.el"))

;; (define-key company-active-map (kbd "\C-n") 'company-select-next)
;; (define-key company-active-map (kbd "\C-p") 'company-select-previous)
;; (define-key company-active-map (kbd "\C-d") 'company-show-doc-buffer)
;; (define-key company-active-map (kbd "M-.") 'company-show-location)

(elpy-enable)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; ;;enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;;(require-package 'pip-requirements)

;; (when (maybe-require-package 'anaconda-mode)
;;   (after-load 'python
;;     (add-hook 'python-mode-hook 'anaconda-mode)
;;     (add-hook 'python-mode-hook 'anaconda-eldoc-mode))
;;   (when (maybe-require-package 'company-anaconda)
;;     (after-load 'company
;;       (after-load 'python
;;         (push 'company-anaconda company-backends)))))

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
(helm-mode t)
(require 'evil)
(evil-mode 1)

(setq evil-default-state 'emacs) 
(define-key evil-emacs-state-map (kbd "C-o") 'evil-execute-in-normal-state)

(define-key evil-insert-state-map (kbd "C-d") 'evil-change-to-previous-state) 
(define-key evil-normal-state-map (kbd "C-d") 'evil-force-normal-state) 
(define-key evil-replace-state-map (kbd "C-d") 'evil-normal-state) 
(define-key evil-visual-state-map (kbd "C-d") 'evil-exit-visual-state)

(require 'elisp-slime-nav)
(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
  (add-hook hook 'elisp-slime-nav-mode))

(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
  (add-hook hook 'turn-on-elisp-slime-nav-mode))

;; 以下设置时使用t作为多剪贴板的起始按键，比如 tay(不是 "ay哦) tap(就是"ap啦)~ 
(define-key evil-normal-state-map "t" 'evil-use-register)

(defun evil-execute-in-normal-state () 
  "Execute the next command in Normal state. C-o o works in insert-mode" 
  (interactive) 
  (evil-delay '(not (memq this-command 
			  '(evil-execute-in-normal-state 
			    evil-use-register 
			    digit-argument 
			    negative-argument 
			    universal-argument 
			    universal-argument-minus 
			    universal-argument-more 
			    universal-argument-other-key))) 
      `(progn 
	 (if (evil-insert-state-p) 
	     (let ((prev-state (cdr-safe (assoc 'normal evil-previous-state-alist)))) 
	       (evil-change-state prev-state) 
	       (setq evil-previous-state 'normal)) 
	   (evil-change-to-previous-state)) 
	 (setq evil-move-cursor-back ',evil-move-cursor-back)) 
    'post-command-hook) 
  (setq evil-move-cursor-back nil) 
  (evil-normal-state) 
  (evil-echo "Switched to Normal state for the next command ...")) 


(setq python-indent-offset 4)
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)

;; anaconda-mode
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-eldoc-mode)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; This is an Emacs package that creates graphviz directed graphs from
;; the headings of an org file
(use-package org-mind-map
  :init
  (require 'ox-org)
  :ensure t
  ;; Uncomment the below if 'ensure-system-packages` is installed
  ;;:ensure-system-package (gvgen . graphviz)
  :config
  (setq org-mind-map-engine "dot")       ; Default. Directed Graph
  ;; (setq org-mind-map-engine "neato")  ; Undirected Spring Graph
  ;; (setq org-mind-map-engine "twopi")  ; Radial Layout
  ;; (setq org-mind-map-engine "fdp")    ; Undirected Spring Force-Directed
  ;; (setq org-mind-map-engine "sfdp")   ; Multiscale version of fdp for the layout of large graphs
  ;; (setq org-mind-map-engine "twopi")  ; Radial layouts
  ;; (setq org-mind-map-engine "circo")  ; Circular Layout
  )



;;(auto-image-file-mode t)

;; (require 'org-mind-map)

(require 'which-key)
(which-key-mode)
(which-key-setup-side-window-right)

;;>>>>
(mapc #'(lambda (plug-in)
	  (require plug-in))
      '(cl
	all-the-icons
	neotree
	linum
	;;magit

	julia-mode
	flycheck-julia
	
	highlight-parentheses
	combofish-defaults
	combofish-org
	combofish-keybindings))

(flycheck-julia-setup)
;;(add-to-list 'flycheck-global-modes 'julia-mode)
;;(add-to-list 'flycheck-global-modes 'ess-julia-mode)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

(global-undo-tree-mode)

;; (dolist (charset '(kana han cjk-misc bopomofo))
;;     (set-fontset-font "fontset-default" charset
;;                       (font-spec :family "STHeiti")))

(set-fontset-font "fontset-default" 'cp936 '("SimSun" . "unicode-bmp"))

(setq custom-file (expand-file-name 
		   "combofish/combofish-custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load-file custom-file))
;;# line 99
(provide 'init)
