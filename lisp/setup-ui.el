;;; setup-ui.el --- 界面配置

(setq inhibit-startup-message nil
      inhibit-startup-screen nil
      fancy-startup-screen t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode t)

(dolist (mode '(term-mode-hook shell-mode-hook eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package ef-themes
  :ensure t
  :config
  (load-theme 'ef-dream t))

(setq initial-buffer-choice
      (lambda ()
        (with-current-buffer (get-buffer-create "*startup*")
          (insert "
   _______                  _             _ 
  |__   __|                (_)           | |
     | | ___ _ __ _ __ ___  _ ___ ___   __| |
     | |/ _ \\ '__| '_ ` _ \\| / __/ __| / _` |
     | |  __/ |  | | | | | | |__\\__ \\| (_| |
     |_|\\___|_|  |_| |_| |_|_____\\___/ \\__,_|
                                        
")
          (goto-char (point-min))
          (current-buffer))))

(provide 'setup-ui)
