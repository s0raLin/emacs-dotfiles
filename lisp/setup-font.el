;;; setup-font.el --- Font Configuration -*- lexical-binding: t; -*-

(defun my/setup-font ()
  (dolist (charset '(han cjk-misc bopomofo symbol kana))
    (set-fontset-font t charset (font-spec :family "霞鹜文楷" :weight 'bold)))
  (set-face-attribute 'default nil :family "Maple Mono NF CN" :height 130)
  (set-face-attribute 'fixed-pitch nil :family "Maple Mono NF CN" :height 130))

(my/setup-font)
(add-hook 'server-after-make-frame-hook #'my/setup-font)

(provide 'setup-font)