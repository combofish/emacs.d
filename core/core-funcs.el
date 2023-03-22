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
  (save-some-buffers)
  (async-shell-command (concat "runsf.py " (buffer-file-name))))

;; (compile (concat "clang++ -std=c++17 -fsanitize=address -Wall -Werror -Wreturn-type -fno-omit-frame-pointer -g -o main "
;; 			       buffer-file-name " && timeout -s 9 60s ./main && rm main" )))

;; use shell script
;; (async-shell-command (concat "clang++ -std=c++17 -fsanitize=address -Wall -Werror -Wreturn-type -fno-omit-frame-pointer -g "
;; 			       (concat (buffer-file-name " -o main && timeout -s 9 60s ./main && rm main")))))


(provide 'core-funcs)

