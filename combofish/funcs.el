;;own function.
(defun open-my-init-file ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun open-eshell-other-buffer ()
  "Open eshell in other buffer"
  (interactive)
  (split-window-vertically)
  (eshell))


(provide 'funcs)
