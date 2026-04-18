;;; setup-edit.el --- 编辑逻辑配置

(electric-pair-mode t)
(setq show-paren-delay 0
      paren-mode t
      indent-tabs-mode nil
      tab-width 2
      c-basic-offset 2
      indent-line-function 'insert-tab)
(global-hl-line-mode t)

(provide 'setup-edit)
