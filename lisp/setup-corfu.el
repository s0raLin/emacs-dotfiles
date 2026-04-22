;;; -*- lexical-binding: t; -*-
;;; setup-corfu.el --- 自动补全 UI

(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)                 ; 开启自动补全
  (corfu-auto-prefix 2)          ; 输入两个字符后开始补全
  (corfu-auto-delay 0.1)         ; 补全延迟，追求极致响应
  (corfu-quit-at-boundary 'separator) ; 遇到分隔符时退出
  (corfu-echo-documentation t))  ; 在回显区显示文档

(provide 'setup-corfu)
