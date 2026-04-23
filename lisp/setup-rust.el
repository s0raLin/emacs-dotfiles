;;; -*- lexical-binding: t; -*-
;;; setup-rust.el --- Rust 开发配置

;; 1. 语法高亮 (推荐方案)
;; 如果你使用的是 Emacs 29+, 推荐直接用内置 treesit
(use-package tree-sitter
  :ensure t
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; 修复报错：手动从 github 安装或确保 melpa 可用
;; 如果还是报错 unavailable，可以尝试删除这个包，改用下面的 treesit-auto
(use-package tree-sitter-langs
  :ensure t
  :after tree-sitter)

;; 2. LSP 核心配置
(use-package lsp-mode
  :ensure t
  :commands lsp
  :custom
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-rust-analyzer-display-inlay-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "always")
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-idle-delay 0.5)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-peek-enable t))

;; 3. Rustic 配置 (它会处理大部分 Rust 逻辑)
(use-package rustic
  :ensure t
  :bind (:map rustic-mode-map
              ("M-j" . lsp-dwim)
              ("C-c C-c a" . lsp-execute-code-action))
  :config
  (setq rustic-lsp-client 'lsp-mode) ; 强制指定使用 lsp-mode
  (add-hook 'rustic-mode-hook #'lsp-deferred)
  (setq rustic-format-on-save t)
  ;; 如果你的 rust-analyzer 在环境变量里，这一行通常不需要手动设
  ;; (setq rustic-analyzer-command '("rust-analyzer"))
  )

(provide 'setup-rust)
