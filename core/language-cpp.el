
(setq package-selected-packages '(eglot flycheck flycheck-clangcheck lsp-mode lsp-treemacs helm-lsp hydra avy dap-mode))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))


;; (use-package eglot :ensure t)
;; (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd-12"))
;; (add-hook 'c-mode-hook 'eglot-ensure)
;; (add-hook 'c++-mode-hook 'eglot-ensure)

(add-hook 'c-mode-hook 'company-mode)
(add-hook 'c++-mode-hook 'company-mode)

(add-hook 'c-mode-hook 'flycheck-mode)
(add-hook 'c++-mode-hook 'flycheck-mode)

(add-hook 'c-mode-hook 'linum-mode)
(add-hook 'c++-mode-hook 'linum-mode)

(add-hook 'c-mode-hook #'smartparens-mode)
(add-hook 'c++-mode-hook #'smartparens-mode)

(add-hook 'c++-mode-hook
          (lambda ()
            (setq-local c++-basic-offset 4) ;; set indentation to 4 spaces
            (setq-local c-default-style "bsd") ;; set default style to BSD
            (setq-local flycheck-gcc-language-standard "c++17"))) ;; set C++17 standard for Flycheck

(fset 'user-macro-c-end-line
      (kmacro-lambda-form [?\C-e ?\; return] 0 "%d"))
(global-set-key (kbd "M-n") 'user-macro-c-end-line)

					; (add-hook 'c++-mode-hook #'(global-set-key (kbd "M-n") 'user-macro-c-end-line))

(with-eval-after-load 'c++-mode
  (global-set-key (kbd "M-n") 'user-macro-c-end-line))

(require 'dap-lldb)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      ;; company-idle-delay 0.0
      ;; company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast

(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(setq lsp-clients-clangd-args '("-std=c++17"))

(add-hook 'c++-mode-hook
          (lambda ()
            (setq flycheck-gcc-language-standard "c++17")
            (setq flycheck-clang-language-standard "c++17")
            (setq flycheck-clangcheck-analyze t)
            (setq flycheck-checker 'clangcheck)))

(add-hook 'c-mode-hook
          (lambda ()
            (setq flycheck-gcc-language-standard "c11")
            (setq flycheck-clang-language-standard "c11")
            (setq flycheck-clangcheck-analyze t)
            (setq flycheck-checker 'clangcheck)))


(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

(provide 'language-cpp)
