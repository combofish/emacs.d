(require 'exwm)
(require 'exwm-config)
(exwm-config-default)

;;(exwm-enable)
(require 'exwm-systemtray)
(exwm-systemtray-enable)

                                        ;(setq default-input-method "chinese-cns-tsangchi")
                                        ;(setq default-input-method "pyim")
                                        ;(setq default-input-method "chinese-py")
                                        ;C-\\

                                        ;(toggle-input-method)
                                        ;(setq exwm-manage-configurations '((t char-mode t)))

(setq exwm-workspace-number 4)

;; (defmacro def-exwm-fast-startup ((name buffer command) &body body)
;;   `(defun ,name (,buffer ,command)
;;      ,@body))

;; (defmacro def-exwm-fast-startup (name parameters &body body)
;;   `(defun ,name ,parameters
;;      ,@body))

(defmacro spsc (b c)
  `(start-process-shell-command ,b nil ,c))

;; (def-exwm-fast-startup exwm-open-vlc ()
;;   (interactive)
;;   (spsc "open-vlc" "vlc"))

(defun exwm-open-vlc ()
  (interactive)     
  (spsc "open-vlc" "vlc"));(start-process-shell-command "open-vlc" nil "vlc")
(defun exwm-open-thunar ()
  (interactive)
  (start-process-shell-command "open-thunar" nil "thunar"))
(defun exwm-open-google-chrome-stable ()
  (interactive)
  (start-process-shell-command "start-google-chrome-stable" nil "google-chrome-stable"))
(defun exwm-open-libreoffice ()
  (interactive)
  (start-process-shell-command "start-libreoffice" nil "libreoffice"))
(defun exwm-xscreen-lock ()
  (interactive)
  (start-process-shell-command "lock-screen" nil "xscreensaver-command -lock" ))
(defun exwm-open-lxterminal ()
  (interactive)
  (start-process-shell-command "open-lxterminal" nil "lxterminal"))

(setq exwm-input-global-keys
      `(
        ([?\s-g] . exwm-open-google-chrome-stable)
        ([?\s-l] . exwm-xscreen-lock)
        ([?\s-o] . exwm-open-libreoffice)
        ([?\s-r] . exwm-reset)
        ([?\s-t] . exwm-open-thunar)                ;([?\s-t] . thunar)
        ([?\s-u] . exwm-open-lxterminal)
        ([?\s-v] . exwm-open-vlc)
        ([?\s-w] . exwm-workspace-switch)
        ,@(mapcar (lambda (i)
                    `(,(kbd (format "s-%d" i)) .
                      (lambda ()
                        (interactive)
                        (exwm-workspace-switch-create ,i))))
                  (number-sequence 0 9))))

;; (setq exwm-input-simulation-keys
;;       '(([?\C-b] . [left])
;;         ([?\C-f] . [right])
;;         ([?\C-p] . [up])
;;         ([?\C-n] . [down])
;;         ([?\C-a] . [home])
;;         ([?\C-e] . [end])
;;         ([?\M-v] . [prior])
;;         ([?\C-v] . [next])
;;         ([?\C-d] . [delete])
;;         ([?\C-k] . [S-end delete])))

(setq exwm-input-global-keys `(,(kbd "s-&") .
                               (lambda (command)
                                 (interactive (list (read-shell-command "$ ")))
                                 (start-process-shell-command command nil command))))
