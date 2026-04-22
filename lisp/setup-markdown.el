;;; -*- lexical-binding: t; -*-
;;; setup-markdown.el --- Markdown 编辑配置

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode) ; 默认使用 Github Flavored Markdown
  :init
  (setq markdown-command "multimarkdown") ; 预览时调用的后端命令
  :config
  ;; 开启代码块内的语法高亮（非常重要！）
  (setq markdown-fontify-code-blocks-natively t)
  
  ;; 快捷键映射（Evil 用户推荐）
  (with-eval-after-load 'evil
    (evil-define-key 'normal markdown-mode-map
      (kbd "TAB") 'markdown-cycle        ; 按 TAB 折叠/展开章节
      (kbd "RET") 'markdown-follow-link-at-point))) ; 回车跳转链接

(provide 'setup-markdown)
