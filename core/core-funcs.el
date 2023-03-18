;;own function.
(defun open-my-init-file ()  
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;;(setq shell-command-buffer-name-async "s")

(defun compile-and-run-single-cpp-file ()
  "Compile and run single cpp file."
  (interactive)
  (indent-region-or-buffer)
  (save-buffer)
  ;;(save-some-buffers)
  (async-shell-command (concat "runsf.py " (buffer-file-name)))
  ;; (shrink-window-if-larger-than-buffer (get-buffer-window shell-command-buffer-name-async)) 

  ;; (fit-frame-to-buffer (get-buffer-window shell-command-buffer-name-async)
  ;; 		       ;; max-height
  ;; 		       150
  ;; 		       ;; min-height
  ;; 		       100)

  ;;; Error by not a live frame
  ;; (fit-frame-to-buffer (get-buffer-window (buffer-name))
  ;; 		       ;; max-height
  ;; 		       150
  ;; 		       ;; min-height
  ;; 		       100)
  
  )

(provide 'core-funcs)


