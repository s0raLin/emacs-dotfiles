;;; -*- lexical-binding: t; -*-
;;; setup-appearance.el --- 字体与视觉配置

;; 1. 设置英文主字体 (Maple Mono)
(set-face-attribute 'default nil 
                    :font "Maple Mono-13" 
                    :weight 'regular)

;; 2. 设置中文字体 (霞鹜文楷)
;; 使用 'han' 范围覆盖简体和繁体中文
(set-fontset-font t 'han (font-spec :family "LXGW WenKai Screen"))

;; 3. 针对性调整：微调中文字体大小以实现视觉平衡
;; 通常霞鹜文楷和 Maple Mono 搭配时，1.2 左右的缩放能让中英文看起来高度一致
(add-to-list 'face-font-rescale-alist '("LXGW WenKai Screen" . 1.2))

;; 4. 解决 Arch Linux 下可能出现的图标显示问题（如果你之后安装 Nerd Icons）
;; 这里的 provide 名字要和你在 init.el 里 require 的一致
(provide 'setup-appearance)
