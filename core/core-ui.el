(defun window-transparent ()
  (interactive)
  (set-frame-parameter (selected-frame) 'alpha '(85 65)))

;; frame
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;;       initial-scratch-message (insert "Hello Larry, how are you doing?" ))

;; (setq initial-frame-alist           '((top . 1) (left . 1) (width . 80) (height . 70)))

;; theme
(load-theme 'monokai 1)

(provide 'core-ui)
