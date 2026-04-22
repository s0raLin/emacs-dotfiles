;;; early-init.el --- 早期初始化配置

;; 垃圾回收优化：启动时给 100MB 内存，启动后再调低
(setq gc-cons-threshold (* 100 1024 1024))

;; 彻底禁用不必要的界面元素，防止启动时闪烁
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars . nil) default-frame-alist)
(setq inhibit-startup-message t)

;; 禁用默认的加载提示
(setq inhibit-splash-screen t)
