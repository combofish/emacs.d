(fset 'yes-or-no-p 'y-or-n-p)

(menu-bar-mode 0)
(scroll-bar-mode 0)
(tool-bar-mode 0)

(delete-selection-mode t)
(global-hl-line-mode t)
(global-auto-revert-mode t)

;;; 重新缩进全部缓冲区的代码.
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

(provide 'core-defaults)
