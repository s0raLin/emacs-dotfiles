(use-package go-mode
  :hook
  (go-mode . eglot-ensure)
  (before-save . gofmt-before-save))

;; 配置 eglot 使用 gopls
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(go-mode . ("gopls"))))

(provide 'setup-go)
