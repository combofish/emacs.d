;;; package --- Summary
;;; Commentary:

;;; code

(defun combofish-goto-current-test ()
  (search-backward-regexp "use function" nil t))

(defun combofish-toggle-test-name-prefix (prefix)
  (save-excursion
    (combofish-goto-current-test)
    (forward-char 0)
    (if (not (looking-at prefix))
	(insert prefix " ")
      (delete-char (length prefix))
      (while (looking-at " ") (delete-char 1)))))

					;(defvar combofish-compile-command "ipconfig"
(defvar combofish-compile-command "cat G:\\combofish\\progress.txt"
  "Command used to run.") 

(defun combofish-run-date ()
  (interactive)
					;  (switch-to-buffer-other-window "*combofish-date*")
					;  (call-process "ipconfig" nil "*combofish-date*"))
  (compile combofish-compile-command t))


(defun combofish-toggle-deffered ()
  (interactive)
  (combofish-toggle-test-name-prefix "//"))

(defun combofish-toggle-focus-rocket ()
  (interactive)
  (combofish-toggle-test-name-prefix "=>"))

(defvar combofish-mode-map (make-sparse-keymap)
  "combofish-mode keymap")

(define-key combofish-mode-map
  (kbd "C-c C-b") 'combofish-run-date)

(define-key combofish-mode-map
  (kbd "C-c C-n") 'combofish-toggle-deffered)

(define-key combofish-mode-map
  (kbd "C-c C-v") 'combofish-toggle-focus-rocket)

(defun combofish-mode--clean-up-ansi-mess (&rest ignore)
  (with-current-buffer "*compilation*"
    (save-excursion
      (goto-char (point-min))
      (while (search-forward "ttl" nil t)
	(delete-char -4)
	(delete-char (- (current-column)))))))

(define-minor-mode combofish-mode
  "Combofish Mode"
  nil
  " Combofish" combofish-mode-map
  (when combofish-mode
    (add-hook 'compilation-finish-functions 'combofish-mode--clean-up-ansi-mess)))



(provide 'combofish-test)
;;; combofish-test.el ends here

