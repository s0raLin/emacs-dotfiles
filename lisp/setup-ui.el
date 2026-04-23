;;; -*- lexical-binding: t; -*-
;;; setup-ui.el --- 界面配置

;; 1. 基础性能与极简外观
(setq-default
 inhibit-startup-screen t
 inhibit-startup-message t
 cursor-in-non-selected-windows nil
 frame-title-format '("%b - Cangli's Emacs")
 ring-bell-function 'ignore
 word-wrap t
 indent-tabs-mode nil)

;; 2. 启动页定制
(use-package dashboard
  :ensure t
  :init
  (setq dashboard-banner-logo-title "Hi s0raLin, ready to hack?")
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner (expand-file-name "logo.png" user-emacs-directory)) ;; 后续可以换成你的 Miku png 路径

  (setq dashboard-items nil) ;; 设为 nil 则不显示任何列表
  ;; (setq dashboard-items '((recents  . 5)
  ;;                         (projects . 5)
  ;;                         (bookmarks . 5)))

  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-show-shortcuts t)
  (setq dashboard-center-content t)
  (setq dashboard-set-init-info t)

  ;; 修复 Evil 报错的核心位置
  (with-eval-after-load 'evil
    (evil-set-initial-state 'dashboard-mode 'normal)
    ;; 允许在 dashboard 里用 j/k 移动
    (evil-define-key 'normal dashboard-mode-map
      (kbd "j") 'dashboard-next-line
      (kbd "k") 'dashboard-previous-line
      (kbd "RET") 'dashboard-get-line)))

;; 3. 彻底关闭 UI 组件
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; 4. 行号优化 (Evil 用户标配相对行号)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

(defun my/disable-line-numbers ()
  (display-line-numbers-mode 0))

(dolist (hook '(term-mode-hook
                shell-mode-hook
                eshell-mode-hook
                vterm-mode-hook
                dashboard-mode-hook ; Dashboard 也不需要行号
                treemacs-mode-hook))
  (add-hook hook #'my/disable-line-numbers))

;; 5. 窗口美化
(use-package fringe
  :ensure nil
  :config
  (set-fringe-mode 10))

;; 6. 主题与状态栏 (推荐 Miku 蓝配色)
(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-one t) ;; doom-one 的深蓝基调很符合你的审美
  (doom-themes-org-config))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 22)
  (doom-modeline-bar-width 3)
  (doom-modeline-icon t)
  (doom-modeline-major-mode-icon t))

;; 7. 彩虹括号
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(provide 'setup-ui)
