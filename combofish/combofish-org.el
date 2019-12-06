;;;<init-org>

(with-eval-after-load 'org
  ;;   (setq org-src-fontify-natively t
  ;;         org-agenda-files '("~/.emacs.d/org"))

                                        ; 代码块中的语法高亮
  ;; (setq org-src-fontify-natively t)
  
  '(require 'org-pdfview)
  ;; why ? 
  '(require 'ox-gfm nil t)
					;(setq python-shell-completion-native-turn off t)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (restclient . t)
     (python . t)
     ;; error
     ;;     (sh . t)
     ;(shell . t)
     (R . t)
     (ruby . t)
     (js .t)
     ;;(javascript .t)
     ;; (nodejs . t)
     (ditaa . t)
     (dot . t)
     (octave . t)
     (sqlite . t)
     (perl . t)
     (C . t)
     ))

  (setq python-shell-completion-native-disabled-interpreters '("python"))
  (setq python-indent-offset 4)

  (add-to-list 'org-file-apps 
               '("\\.pdf\\'" . (lambda (file link)
                                 (org-pdfview-open link))))
  
  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline "~/.emacs.d/gtd.org" 
					   "任务安排")
           "* TODO [#B] %?\n %i\n"
           :empty-lines 1)))

  (setq org-tag-alist '(("homework"    . ?h)
                        ("extensive"   . ?e)
                        ("getDownNow"  . ?n)
			(:startgroup   . nil)
			("@study"      . ?s)
			(:endgroup     . nil)))

  (setq org-agenda-custom-commands
        '(("k" "work haha"
           ((agenda "")
            (tags-todo "work")
            (tags-todo "支持")))))

  ;; (setq org-todo-keywords
  ;;     '((sequence "TODO(t!)" "NEXT(n)" "WAITTING(w)" 
  "SOMEDAY(s)" "|" "DONE(d@/!)" "ABORT(a@/!)")
;;    ))

(setq org-agenda-custom-commands
      '(
        ("w" . "任务安排")
        ("wa" "重要且紧急的任务" tags-todo "+PRIORITY=\"A\"")
        
        ("wb" "重要且不紧急的任务" tags-todo 
	 "-weekly-monthly-daily+PRIORITY=\"B\"")
        ("wc" "不重要且紧急的任务" tags-todo "+PRIORITY=\"C\"")
        ("W" "Weekly Review"
         ((stuck "") ;; review stuck projects as designated by 
	  org-stuck-projects
          (tags-todo "project")
          (tags-todo "daily")
          (tags-todo "weekly")
          (tags-todo "school")
          (tags-todo "code")
          (tags-todo "theory")
          ))
        ))

;;(add-hook 'org-mode-hook #'(lambda () (setq truncate-lines nil)))

;;remmber.
(global-set-key (kbd "C-c r") 'org-capture)

(provide 'combofish-org)
