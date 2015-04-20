;; CobbLiu's emacs config file
(setq user-full-name "CobbLiu")
(setq user-mail-address "cobblau@gmail.com")

;; third party source
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

;; 第三方库的路径
;;(add-to-list 'load-path "/usr/share/emacs/site-lisp")
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;;======================  cl
;; if not required, some error occur.
(require 'cl)


;; ======================= auto-complete-config ============
;; auto-completion是一个代码自动补全工具
;;(require 'auto-complete)
;;(require 'auto-complete-config)
;;(require 'auto-complete-clang)
;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/site-lisp/ac-dict")
;;(global-auto-complete-mode t)
;;(define-key ac-completing-map (kbd "C-n") 'ac-next)
;;(define-key ac-completing-map (kbd "C-p") 'ac-previous)


;; ====================== cmode only =======================
(defun my-c-mode-hook()
  ;; 删掉行尾的空格
  (add-hook 'before-save-hook 'delete-trailing-whitespace))
(add-hook 'c-mode-hook 'my-c-mode-hook)
;; call 'go fmt' before closing a go file
(add-hook 'before-save-hook #'gofmt-before-save)

;; ====================== sr-speedbar ======================
;; sr-speedbar是一个轻量级的代码树插件，可以在左侧查看代码树
(require 'sr-speedbar)
(setq sr-speedbar-left-side nil)  ;;右侧
(setq sr-speedbar-width 32)
(setq sr-speedbar-max-width 32)
(global-set-key (kbd "<f5>") (lambda()
          (interactive)
          (sr-speedbar-open)))

;; ======================= tabbar ==========================
;; tabbar是在Emacs内部的一个标签页插件，可以方便地在标签页中切换源文件
(require 'tabbar)
(tabbar-mode 1)
(global-set-key [(meta k)] 'tabbar-forward)
(global-set-key [(meta j)] 'tabbar-backward)
(global-set-key [(meta p)] 'tabbar-forward-group)
(global-set-key [(meta n)] 'tabbar-backward-group)
;;close default tabs
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
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(tabbar-separator (quote (1.5))))

;; ======================== ido mode =======================
;; ido是Emacs自带的一个很好的补全方式
;; ido可以在find-file或者switch-buffer的时候, 通过输入关键字自动筛选结果.
(require 'ido)
(ido-mode t)
;; enable fuzzy matching
(setq ido-enable-flex-matching t)

;; ======================= cscope 
;;(require 'xcscope)
;; C-c s a 设定初始化的目录，一般是你代码的根目录
;; C-s s I 对目录中的相关文件建立列表并进行索引
;; C-c s s 序找符号
;; C-c s g 寻找全局的定义
;; C-c s c 看看指定函数被哪些函数所调用
;; C-c s C 看看指定函数调用了哪些函数
;; C-c s e 寻找正则表达式
;; C-c s f 寻找文件
;; C-c s i 看看指定的文件被哪些文件include
;; C only
;;(add-hook 'c-mode-common-hook' (lambda()(require 'xcscope)))


;; ==================== fill-column-indicator
;; 显示80行的标线
(require 'fill-column-indicator)
(setq fci-rule-width 2)
(setq fci-rule-color "yellow")
(setq fci-rule-column 80)
;; avaiable in c source codes
;;(add-hook 'c-mode-hook 'fci-mode)
(define-globalized-minor-mode
  global-fci-mode fci-mode (lambda () (fci-mode 1)))
;;(global-fci-mode 0)

;; =================== HideShow Mode
(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)
(global-set-key (kbd "C-.") 'hs-toggle-hiding)

;; ================== Company Mode
(autoload 'company-mode "company" nil t)
;;如果你嫌它补全的等待时间过长，可以设置为直接补全，并且设置其最小补全前缀为1(默认为3)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)

(setq company-clang-arguments
        (mapcar(lambda (item)(concat "-I" item))
               (split-string
      ;echo "" | g++ -v -x c++ -E -
                "
 /usr/lib/gcc/x86_64-linux-gnu/4.8/include
 /usr/local/include
 /usr/lib/gcc/x86_64-linux-gnu/4.8/include-fixed
 /usr/include/x86_64-linux-gnu
 /usr/include
 .
    ")))
(global-company-mode t)
;;company 颜色设置
(defun theme-dark ()
  (interactive)
;;  (load-theme 'bclues t)
  (set-face-foreground 'company-tooltip "#000")
  (set-face-background 'company-tooltip "#fff")
  (set-face-foreground 'company-scrollbar-bg "#fff")
  (set-face-background 'company-scrollbar-fg "#999")
;;  (set-face-foreground 'company-tooltip-selection "#aaa")
;;  (set-face-background 'company-tooltip-common "#aaa")
;;  (set-face-background 'company-tooltip-common-selection "#aaa") 
;;  (set-face-background 'company-tooltip-annotation "#9a0000")
)
(theme-dark)

;; 编译的一些设置
(global-set-key (kbd "M-m") 'compile)

;; 关闭菜单栏
(menu-bar-mode 0)
(display-time)

;; 删除 "filename~" 和 "#filename#" 文件
(setq backup-inhibited t)
(setq auto-save-default nil)

;; 高亮括号
(show-paren-mode 1)

;; 显示行号和列号
(global-linum-mode t)
(setq lium-mode t)
(setq column-number-mode t)

;; 一些窗口操作的快捷键
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-3") 'split-window-horizontally)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "C-^") 'enlarge-window)

;; (global-set-key (kbd "C-*") 'shrink-window)
(global-set-key (kbd "C-q") 'kill-ring-save)
(global-set-key (kbd "C-{") 'backward-page)
(global-set-key (kbd "C-}") 'forward-page)

;; Buffer 之间跳转的快捷键
(global-set-key (kbd "C-x C-j") 'switch-to-prev-buffer)
(global-set-key (kbd "C-x C-k") 'switch-to-next-buffer)

;; 括号间跳转
(global-set-key (kbd "C-M-n") 'forward-list)
(global-set-key (kbd "C-M-p") 'backward-list)

;; 跳转到某行
(global-set-key (kbd "M-g") 'goto-line)

;; 字符替换
(global-set-key (kbd "M-r") 'replace-string)

;; 一些缩进设置
(setq c-basic-offset 4)
(setq default-tab-width 8)
(setq-default indent-tabs-mode nil)

;; fold-this mode 的一些设置
(global-set-key (kbd "C-c C-f") 'fold-this-all)
(global-set-key (kbd "C-c C-F") 'fold-this)
(global-set-key (kbd "C-c M-f") 'fold-this-unfold-all)
