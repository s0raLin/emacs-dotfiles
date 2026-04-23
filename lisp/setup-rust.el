;;; setup-rust.el

;; 1. 语法高亮
(use-package treesit-auto
  :ensure t
  :config
  (setq treesit-auto-install 'prompt)
  (global-treesit-auto-mode))

;; 2. LSP 核心 (必须配置 Hook 才能启动)
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook ((rustic-mode . lsp-deferred)      ; 进入 rustic-mode 时启动 lsp
         (rust-ts-mode . lsp-deferred))    ; 进入 treesit 模式时启动 lsp
  :custom
  (lsp-inlay-hint-enable t) ; 核心设置：全局开启内嵌提示
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-completion-provider :none)          ; 关键：为了让 Corfu 接管提示
  (lsp-idle-delay 0.1)                     ; 加快提示速度
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))


;; 3. LSP UI (负责报错的红线和浮窗)
(use-package lsp-ui
  :ensure t
  :custom
  (lsp-ui-sideline-enable t)               ; 行末显示错误
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-doc-enable t))                   ; 鼠标悬停显示文档

;; 4. Rustic
(use-package rustic
  :ensure t
  :custom
  (rustic-format-on-save t)
  (rustic-lsp-client 'lsp-mode)
  :bind (:map rustic-mode-map
              ("M-j" . lsp-dwim)           ; 现在这个函数能找到了
              ("C-c f" . rustic-format-buffer)
              ("C-c C-c a" . lsp-execute-code-action)))

(provide 'setup-rust)
