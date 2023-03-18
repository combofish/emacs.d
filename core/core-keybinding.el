
;; test
(defvar user-key-map '(("<f1>"     . manual-entry)
		       ("<f2>"     . open-my-init-file)
					;("<f3>"     . repeat-complex-command)
                                        ;("<f4>"     . other-window);; 跳转到 Emacs 的另一个buffer窗口
					;("<f4>"     . slime)
		       ("<f5>"     . gdb)
		       ("<f6>"     . eshell)
		       ;;  ("<f7>"     . open-eshell-other-buffer)
		       ;;  ("<f8>"     . neotree)
		       ;;		       ("<f9>"     . open-my-note-file)
                                        ;       ("<f8>"     . loop-alpha)

		       ("C-<return>" . newline)
                                        ;        ("C-SPC"      . nil)
                                        ;       ("s-SPC"      . set-mark-command)
		       ("C-="        . er/expand-region)
		       ("C-o"        . compile-and-run-single-cpp-file)

                                        ;       ("C--"        . local-decrease-font-size)
                                        ;       ("C-+"        . local-increase-font-size)
                                        ;("C-;"        . nil)

		       ("C-s"        . swiper)

					;("C-w"        . backward-kill-word)

		       ;; ( "C-S-c C-S-c" . mc/edit-lines)
		       ;; ( "C->" . mc/mark-next-like-this)
		       ;; ( "C-<" . mc/mark-previous-like-this)

		       ;; ("C-c C-<" . mc/mark-all-like-this)

		       ;; ("C-h f"      . counsel-describe-function)            ;override.
		       ;; ("C-h v"      . counsel-describe-variable)
		       
					;override.
					;("C-c t"      . toggle-transparency)
                                        ;("C-c p s"    . helm-do-ag-project-root);全局搜索.

		       ("C-c a"      . org-agenda)
		       ;; ("C-c y"      . youdao-dictionary-search-at-point)
		       ;; ("C-c C-r"    . ivy-resume)

		       ;; ("C-x t"      . window-transparent)
		       ("C-x C-r"    . recentf-open-files)

		       ("C-h C-f"    . find-function)
		       ("C-h C-v"    . find-variable)
		       ("C-h C-k"    . find-function-on-key)

		       ("M-g"        . goto-line)
					;	("M-j"        . tabbar-backward)
					;	("M-k"        . tabbar-forward)
		       
		       ;;  ("M-s m"      . counsel-imenu)                    ;函数列表。
		       ;;  ("M-s o"      . occur-do-what-i-mean)
		       ;;  ("M-s e"      . iedit-mode)                      ;默认是C-;.

		       ("C-M-\\"     . indent-region-or-buffer)
		       ))

;; map keybindings   
(mapc #'(lambda (entry)
	  (global-set-key (kbd (car entry)) (cdr entry)))
      user-key-map)

(provide 'core-keybinding)
