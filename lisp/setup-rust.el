;;; -*- lexical-binding: t; -*-
;;; setup-rust.el --- Rust 开发配置

(use-package rustic
  :ensure t
  :config
  (setq rustic-lsp-client 'lsp-mode)
  (setq rustic-format-on-save t)
  (setq rustic-analyzer-command '("rust-analyzer")))

(use-package lsp-mode
  :ensure t
  :hook (rustic-mode . lsp)
  :commands lsp
  :config
  (setq lsp-rust-analyzer-cargo-watch-command "clippy")
  (setq lsp-rust-analyzer-display-inlay-hints t)       ; 内联类型提示
  (setq lsp-rust-analyzer-display-chaining-hints t)    ; 方法链类型提示
  (setq lsp-idle-delay 0.5))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

; 启用 Tree-sitter 高亮：
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-ts-mode))

(provide 'setup-rust)
