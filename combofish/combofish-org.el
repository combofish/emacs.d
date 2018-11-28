;;;<init-org>

(with-eval-after-load 'org
  (setq org-src-fontify-natively t
        org-agenda-files '("~/.emacs.d/org"))

  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline "~/.emacs.d/gtd.org" 
					   "任务安排")
           "* TODO [#B] %?\n %i\n"
           :empty-lines 1)))

  ;;添加tags.
  (setq org-tag-alist '(("苦差" . ?k)
                        ("薪水" . ?s)
                        ("课内作业")))

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

;;remmber.
(global-set-key (kbd "C-c r") 'org-capture)


)


(provide 'combofish-org)
