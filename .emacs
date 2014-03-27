;; CobbLiu's emacs config file
(setq user-full-name "CobbLiu")
(setq user-mail-address "cobblau@gmail.com")

;; 第三方库的路径
;;(add-to-list 'load-path "/usr/share/emacs/site-lisp")

;; ======================= auto-complete-config ============
;; auto-completion是一个代码自动补全工具
(add-to-list 'load-path "~/.emacs.d/site-lisp/auto-complete")
(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/cobbliu/.emacs.d/site-lisp/ac-dict")
;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(define-key ac-completing-map (kbd "C-n") 'ac-next)
(define-key ac-completing-map (kbd "C-p") 'ac-previous)

;; ====================== sr-speedbar ======================
;; sr-speedbar是一个轻量级的代码树插件，可以在左侧查看代码树
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(require 'sr-speedbar)
;;(setq sr-speedbar-left-side nil)
(setq sr-speedbar-width 35)
(setq sr-speedbar-max-width 35)
(setq dframe-update-speed t)
(global-set-key (kbd "<f5>") (lambda()
          (interactive)
          (sr-speedbar-toggle)))

;; ======================= tabbar ==========================
;; tabbar是在Emacs内部的一个标签页插件，可以方便地在标签页中切换源文件
(require 'tabbar)
(tabbar-mode 1)
(global-set-key [(meta j)] 'tabbar-forward)
(global-set-key [(meta k)] 'tabbar-backward)
(global-set-key [(meta p)] 'tabbar-forward-group)
(global-set-key [(meta n)] 'tabbar-backward-group)
; close default tabs
(setq tabbar-buffer-list-function
    (lambda ()
        (remove-if
          (lambda(buffer)
             (find (aref (buffer-name buffer) 0) " *"))
          (buffer-list))))
(setq tabbar-buffer-groups-function
      (lambda()(list "All")))
(set-face-attribute 'tabbar-button nil )
(set-face-attribute 'tabbar-default nil
                    :background "gray"
                    :foreground "gray30")
(set-face-attribute 'tabbar-selected nil
                    :inherit 'tabbar-default

                    :background "green"
                    :box '(:line-width 3 :color "DarkGoldenrod") )
(set-face-attribute 'tabbar-unselected nil
                    :inherit 'tabbar-default
                    :box '(:line-width 3 :color "gray"))
(custom-set-variables '(tabbar-separator (quote (1.5))))

;; ======================== ido mode =======================
;; ido是Emacs自带的一个很好的补全方式
;; ido可以在find-file或者switch-buffer的时候, 通过输入关键字自动筛选结果.
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching

;; ======================= cscope ==========================
(require 'xcscope)
;; C-c s a 设定初始化的目录，一般是你代码的根目录
;; C-s s I 对目录中的相关文件建立列表并进行索引
;; C-c s s 序找符号
;; C-c s g 寻找全局的定义
;; C-c s c 看看指定函数被哪些函数所调用
;; C-c s C 看看指定函数调用了哪些函数
;; C-c s e 寻找正则表达式
;; C-c s f 寻找文件
;; C-c s i 看看指定的文件被哪些文件include
;;(add-hook 'c-mode-common-hook' (lambda()(require 'xcscope)))   ;;C only

;; windmove makes window moving sufficient
(windmove-default-keybindings)
(windmove-default-keybindings 'meta)

;; ========================= fill-column-indicator =========
;; 显示80行的标线
(require 'fill-column-indicator)
(setq fci-rule-width 2)  
(setq fci-rule-color "yellow")
(setq fci-rule-column 80) 
;; avaiable in c source codes
(add-hook 'c-mode-hook 'fci-mode)
;(define-globalized-minor-mode   
;  global-fci-mode fci-mode (lambda () (fci-mode 1)))  
;(global-fci-mode 1)  

;; 删掉行尾的空格
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; 关闭菜单栏
(menu-bar-mode nil)
(display-time)

;; 删除 "filename~" 文件
(setq backup-inhibited t)

;; 删除 #filename# 文件
(setq auto-save-default nil)

;; 显示行号和列号
(global-linum-mode t)
(setq linum-mode t)
(setq column-number-mode t)

;; 一些窗口操作的快捷键
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-3") 'split-window-horizontally)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "C-^") 'enlarge-window)
;(global-set-key (kbd "C-*") 'shrink-window)
(global-set-key (kbd "C-q") 'kill-ring-save)
(global-set-key (kbd "C-{") 'backward-page)
(global-set-key (kbd "C-}") 'forward-page)

;; 跳转到某行
(global-set-key (kbd "M-g") 'goto-line)

;; 字符替换
(global-set-key (kbd "M-r") 'replace-string)

;; 一些缩进设置
(setq c-basic-offset 4)
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)