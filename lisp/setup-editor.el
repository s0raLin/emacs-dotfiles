;;; -*- lexical-binding: t; -*-
;;; setup-editor.el --- 编辑行为配置

;; ─────────────────────────────────────────
;; Evil（Vim 键位）
;; ─────────────────────────────────────────
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)   ; 交给 evil-collection 处理
  (setq evil-undo-system 'undo-redo) ; Emacs 28+ 原生 undo/redo
  (setq evil-want-C-u-scroll t)     ; C-u 向上翻页（Vim 习惯）
  :config
  (evil-mode 1))

;; 必须在 evil 之后、general 之前加载，避免 SPC 冲突
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; jk 退出 insert mode
(use-package evil-escape
  :after evil
  :config
  (setq evil-escape-key-sequence "jk")
  (setq evil-escape-delay 0.2)
  (evil-escape-mode 1))

;; 注释：gc gc（类似 vim-commentary）
(use-package evil-commentary
  :after evil
  :config (evil-commentary-mode))

;; s/S 快速跳转（类似 flash.nvim）
(use-package evil-snipe
  :after evil
  :config
  (evil-snipe-mode 1)
  (evil-snipe-override-mode 1))

;; ─────────────────────────────────────────
;; Leader key（SPC，类似 Neovim）
;; ─────────────────────────────────────────
(use-package general
  :config
  (general-create-definer my/leader
    :states '(normal visual)
    :prefix "SPC")

  (my/leader
    ;; 文件
    "ff" 'find-file
    "fr" 'recentf-open-files
    "fs" 'save-buffer
    ;; Buffer
    "bb" 'switch-to-buffer
    "bd" 'kill-current-buffer
    ;; 窗口
    "wv" 'split-window-right
    "ws" 'split-window-below
    "wd" 'delete-window
    "wh" 'windmove-left
    "wl" 'windmove-right
    "wk" 'windmove-up
    "wj" 'windmove-down
    ;; 搜索
    "/"  'consult-ripgrep
    ;; LSP（在 rust buffer 中生效）
    "ca" 'eglot-code-actions
    "cr" 'eglot-rename
    "cf" 'eglot-format-buffer
    ;; Git
    "gs" 'magit-status))

;; ─────────────────────────────────────────
;; 文件搜索 / 模糊查找
;; ─────────────────────────────────────────
(use-package vertico
  :init (vertico-mode))

(use-package consult
  :bind ("C-s" . consult-line))

(use-package orderless
  :config
  (setq completion-styles '(orderless basic)))

;; ─────────────────────────────────────────
;; which-key（按键提示，和 Neovim which-key 一样）
;; ─────────────────────────────────────────
(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.3))

;; ─────────────────────────────────────────
;; 其他 QoL
;; ─────────────────────────────────────────
(use-package magit)

;; 相对行号
(setq display-line-numbers-type 'relative)

;; --- 全局缩进设置 ---
(setq-default indent-tabs-mode nil) ; 将 Tab 转换为空格
(setq-default tab-width 2)          ; Tab 宽度设为 2
(setq-default standard-indent 2)    ; 标准缩进设为 2

;; 允许 Evil 的复制粘贴与系统剪贴板同步
(setq select-enable-clipboard t)

;; 退出时不用输入全名 yes/no，只输入 y/n 即可
(fset 'yes-or-no-p 'y-or-n-p)

;; 自动保存（可选：创造“不用手动保存”的需求）
(setq auto-save-visited-mode t)
;; 自动配对括号
(electric-pair-mode 1)

(provide 'setup-editor)
