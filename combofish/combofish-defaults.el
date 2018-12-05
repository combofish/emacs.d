;;; defaults
;;;<init-better-defaults>

(setq ring-bell-function 'ignore     ;default-major-mode 'org-mode
      make-backup-files nil
      auto-save-default nil)

(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)



(global-linum-mode t)
(global-hl-line-mode t)
(global-auto-revert-mode t)           ;Emacs 自动加载外部修改过的文件。
(global-company-mode t)
(global-hungry-delete-mode)
(global-flycheck-mode t)
(smartparens-global-mode t)

(show-paren-mode t)

(delete-selection-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(set-language-environment "UTF-8")
(setenv "LC_ALL" "en_US.UTF-8")

;;;重新缩进全部缓冲区的代码.
(defun indent-buffer ()
  "Indent the currently visited buffer."
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indent selected region"))
      (progn
        (indent-buffer)
        (message "Indent buffer.")))))

(with-eval-after-load 'smartparens
  (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
  (sp-local-pair 'emacs-lisp-mode "\`" nil :actions nil)
  (sp-local-pair 'lisp-mode "'" nil :actions nil)
  (sp-local-pair 'lisp-mode "\`" nil :actions nil)
  (sp-local-pair 'lisp-interaction-mode "'" nil :actions nil)
  (sp-local-pair 'lisp-interaction-mode "\`" nil :actions nil)
  (sp-local-pair 'slime-repl-mode "'" nil :actions nil)
  (sp-local-pair 'slime-repl-mode "\`" nil :actions nil))

(abbrev-mode t)     ;;;缩写补全：输入下面的缩写 并以空格结束.
(define-abbrev-table 'global-abbrev-table '(("9cf" "combofish")
                                            ("sc0" "/sys/class/backlight/intel_backlight/brightness")))

(setq dired-recursive-copies 'always   ;;;递归删除或拷贝.
      dired-recursive-deletes 'always)

(require 'dired-x)         ;;启用 dired-x 可以让每一次进入 Dired 模式时，使用新的快捷键 C-x C-j 就可以进 ;;入当前文件夹的所在的路径。
(setq dired-dwin-target 1) 
;;则可以使当一个窗口（frame）中存在两个分屏 
;;（window）时，将另一个分屏自动设置成拷贝地址的目标。

(defun occur-do-what-i-mean ()    ; occur:使其默认搜索当前被选中的或者在光标下的字符串.
  "call occar with a same default."
  (interactive)
  (push (if (region-active-p)
            (buffer-substring-no-properties
             (region-beginning)
             (region-end))
          (let ((sym (thing-at-point 'symbol)))
            (when (stringp sym)
              (regexp-quote sym))))
        regexp-history)
  (call-interactively 'occur))

;;;</init-better-defaults>


;;; ui
(menu-bar-mode 0)
(tool-bar-mode -1)
;;(mouse-avoidance-mode 'animate)   
;;光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线。
(setq-default cursor-type 'bar)   ;;可选值"bar".
					;(set-frame-parameter (selected-frame) 'alpha '(85 55))

(defun combofish-transparent ()
  (interactive)
  (set-frame-parameter (selected-frame) 'alpha '(85 55)))

(display-time-mode 1)
(setq display-time-24hr-format t  ;;时间使用24小时制
      display-time-day-and-date t ;;时间显示包括日期和具体时间
      display-time-interval 10    ;;时间的变化频率
      inhibit-splash-screen t     ;;关闭启动帮助画面。
      mouse-yank-at-point t       ;;使用鼠标中键可以粘贴
      auto-image-file-mode t      ;;让 Emacs 可以直接打开和显示图片。
      frame-title-format "%e %n %b        %Ib"			;initial-frame-alist (quote ((fullscreen . maximized)))
      initial-scratch-message (insert "Day Day up, good good study!" )
      )

(load-theme 'monokai 1)

;;(require 'linum)
(setq linum-format "%4d\u2502")
(set-face-foreground 'linum "orange")

(provide 'combofish-defaults)

