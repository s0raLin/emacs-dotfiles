;;; init.el --- 主配置文件

;; 1. 将 lisp/ 目录加入加载路径
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; 2. 初始化包管理 (使用 use-package)
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; 3. 调用模块
(require 'setup-ui)      ; 加载界面配置
(require 'setup-keybindings) ;快捷键映射（Evil
(require 'setup-editor)  ; 加载编辑器行为（如 Evil）
(require 'setup-appearance) ; 字体和视觉配置
(require 'setup-rust)  ; Rust开发配置
(require 'setup-go) ; Go 开发配置
(require 'setup-corfu) ; 自动补全UI
(require 'setup-markdown) ; Markdown
(require 'setup-tools) ; 工具类


;; 启动完成后将垃圾回收阈值改回正常水平（8MB）
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 8 1024 1024))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
