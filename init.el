;;; package --- Summary
;;; Commentary:
;;; CobbLiu's  config file
;;; Code:
(setq user-full-name "CobbLiu")
(setq user-mail-address "cobblau@gmail.com")
(setq byte-compile-warnings nil)

;; third party source
(require 'package)
;;(add-to-list 'package-archives '("marmalade" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/marmalade/"))
;;(add-to-list 'package-archives '("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/"))
;; (add-to-list 'package-archives '("melpa" . "http://mirrors.cloud.tencent.com/elpa/melpa/"))
;; (add-to-list 'package-archives '("marmalade" . "http://mirrors.cloud.tencent.com/elpa/marmalade/"))
;; (add-to-list 'package-archives '("gnu" . "http://mirrors.cloud.tencent.com/elpa/gnu/"))
(setq package-archives '(("gnu"   . "http://mirrors.cloud.tencent.com/elpa/gnu/")
                         ("melpa" . "http://mirrors.cloud.tencent.com/elpa/melpa/")
			 ("marmalade" . "http://mirrors.cloud.tencent.com/elpa/marmalade/")))
(package-initialize)

;;
;; 第三方库的路径
;;
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;; 第三方库主题的路径
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'solarized-wombat-dark t)

;;
;; Bootstrap `use-package'
;;
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
;; use-package的示例
(use-package diminish
  :ensure t)
;; Enable use-package
(eval-when-compile
  (require 'use-package))
(use-package bind-key
  :ensure t)

;;
;; cl: common lisp
;;
;; if not required, some error occur.
(use-package cl
  :ensure t)

;;
;; cmode only
;;
(defun my-c-mode-hook()
  ;; 删掉行尾的空格
  (add-hook 'before-save-hook 'delete-trailing-whitespace))
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)
;;(add-hook 'before-save-hook #'gofmt-before-save)
(add-hook 'completion-at-point-functions 'go-complete-at-point)

;;
;; sr-speedbar
;;
;; sr-speedbar是一个轻量级的代码树插件，可以在左侧查看代码树
(use-package sr-speedbar
  :ensure t
  :config
  (setq sr-speedbar-right-side nil)
  (setq sr-speedbar-width 32)
  (setq sr-speedbar-max-width 32))
(global-set-key (kbd "<f5>") (lambda()
                               (interactive)
                               (sr-speedbar-open)))

;;
;; ido mode
;;
;; ido是Emacs自带的一个很好的补全方式
;; ido可以在find-file或者switch-buffer的时候, 通过输入关键字自动筛选结果.
(use-package ido
  :ensure t
  :config
  (ido-mode t)
  (setq ido-enable-flex-matching t))

;;
;; helm
;;
(use-package helm
  :ensure t
  :config
  (helm-mode 1)
  (helm-autoresize-mode 1))
;; (helm-mode 1)
;; (helm-autoresize-mode 1)
(global-set-key (kbd "C-h C-l") 'helm-find-files)
;;(global-set-key (kbd "C-h C-f") 'helm-find) ;; C-u C-h C-f 指定要搜索的目录
(global-set-key (kbd "C-h C-m") 'helm-imenu)
(global-set-key (kbd "C-h C-o") 'helm-occur)
 (global-set-key (kbd "C-x b") 'helm-buffers-list)

;;
;; helm-projectile
;;
(use-package helm-projectile
  :ensure t)
(helm-projectile-on)
(setq projectile-indexing-method 'native)
(add-to-list 'projectile-globally-ignored-directories "third")
(add-to-list 'projectile-globally-ignored-directories "build")
(add-to-list 'projectile-globally-ignored-directories ".git")
(global-set-key (kbd "C-h C-f") 'helm-projectile-find-file)
(global-set-key (kbd "C-h C-d") 'helm-projectile-find-dir)
(global-set-key (kbd "C-h C-p") 'helm-projectile-find-file-dwim)

;;
;; helm-gtags
;;
(use-package helm-gtags
  :ensure t)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(global-set-key (kbd "C-c v") 'helm-gtags-find-rootdir)
(global-set-key (kbd "C-c C-j") 'helm-gtags-select-tag)
(global-set-key (kbd "M-.") 'helm-gtags-find-tag)
(global-set-key (kbd "M-*") 'helm-gtags-pop-stack)
(global-set-key (kbd "C-c C-r") 'helm-gtags-find-rtag)
(global-set-key (kbd "C-j") 'helm-gtags-select-tag)
(custom-set-variables
 '(helm-gtags-path-style 'relative)
 '(helm-gtags-ignore-case t)
  '(helm-gtags-auto-update t))

;; =================== HideShow Mode
(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)
(global-set-key (kbd "C-.") 'hs-toggle-hiding)


;;
;; company + company's backends
;;
(use-package company
  :ensure t)
;;(use-package irony
;;  :ensure t)
;;(use-package company-irony
;;  :ensure t)
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'c-mode-hook 'company-mode)
;;(add-hook 'c++-mode-hook 'irony-mode)
;;(add-hook 'c-mode-hook 'irony-mode)
;;(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 2)
(setq company-dabbrev-downcase nil)
(add-to-list 'company-backends 'company-dabbrev)
(add-to-list 'company-backends 'company-dabbrev-code)
(add-to-list 'company-backends 'company-files)
(add-to-list 'company-backends 'company-semantic)
(add-to-list 'company-backends 'company-keywords)
;;(add-to-list 'company-backends 'company-irony)
;;(add-to-list 'company-backends 'company-gtags)
(add-to-list 'company-backends 'company-capf)
(add-to-list 'company-backends 'company-clang)
(use-package company-c-headers
  :ensure t)
(add-to-list 'company-c-headers-path-system "/usr/include/c++/4.9.2/")
(add-to-list 'company-backends 'company-c-headers)
(global-set-key (kbd "C-;") 'company-complete-common)
;;使用M-n 和 M-p 选择候选项
;;company 颜色设置
(defun theme-dark ()
  (interactive)
   (set-face-foreground 'company-tooltip "#000")
    (set-face-background 'company-tooltip "#fff")
     (set-face-foreground 'company-scrollbar-bg "#fff")
      (set-face-background 'company-scrollbar-fg "#999")
)
(theme-dark)
;; ===================================================

;; 编译的一些设置
(global-set-key (kbd "M-m") 'compile)

;;
;; 显示当前光标在哪个函数中
;;
(which-function-mode 1)
(setq-default header-line-format
              '((which-func-mode ("" which-func-format " "))))
(setq mode-line-misc-info
      ;; We remove Which Function Mode from the mode line, because it's mostly
      ;; invisible here anyway.
      (assq-delete-all 'which-func-mode mode-line-misc-info))

;;
;; 关闭菜单栏
;;
(menu-bar-mode 0)
(display-time)

;;
;; 删除 "filename~" 和 "#filename#" 文件
;;
(setq backup-inhibited t)
(setq auto-save-default nil)

;;
;; 高亮括号
;;
(show-paren-mode 1)

;;
;; 显示行号和列号
;;
(global-linum-mode t)
(setq column-number-mode t)

;;
;; C++代码风格设置
;;
(defconst cobbcpp
  '("linux" ; this is inheritance from the linux style
    (c-basic-offset . 4)
    (c-offsets-alist .
                     ((innamespace . [0])))))
(c-add-style "cobbcpp" cobbcpp)
(defun CobbCppHook()
  (c-set-style "cobbcpp")
  (setq indent-tabs-mode nil)
  (setq default-tab-width 4)
  (setq tab-width 4)
  (setq global-hl-line-mode t)
  )
(add-hook 'c++-mode-hook 'CobbCppHook)
(add-hook 'c-mode-hook 'CobbCppHook)

;;
;; diminish
;;
(use-package diminish
  :ensure t)
(diminish 'abbrev-mode)
(diminish 'company-mode)
(diminish 'helm-mode)
(diminish 'helm-gtags-mode)
(diminish 'hs-minor-mode)
(diminish 'whitespace-mode)
(diminish 'irony)

;;
;; M-Del删除的单词不加入到剪切板
;;
(defun backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
         With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (backward-word arg) (point))))
(global-set-key (kbd "C-M-<backspace>") 'backward-kill-word)
(global-set-key (kbd "M-DEL") 'backward-delete-word)

;;
;; 一些窗口操作的快捷键
;;
(global-set-key (kbd "M-4") 'delete-window)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-3") 'split-window-horizontally)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "C-^") 'enlarge-window)
                                        ;(global-set-key (kbd "C-*") 'shrink-window)
(global-set-key (kbd "C-q") 'kill-ring-save)
(global-set-key (kbd "C-{") 'backward-page)
(global-set-key (kbd "C-}") 'forward-page)

;;
;; Buffer 之间跳转的快捷键
;;
(global-set-key (kbd "C-x C-j") 'switch-to-prev-buffer)
(global-set-key (kbd "C-x C-k") 'switch-to-next-buffer)

;;
;; 括号间跳转
;;
(global-set-key (kbd "M-0") 'forward-list)
(global-set-key (kbd "M-9") 'backward-list)

;;
;; 跳转到某行
;;
(global-set-key (kbd "M-g") 'goto-line)

;;
;; 字符替换
;;
(global-set-key (kbd "M-r") 'replace-string)
(global-set-key (kbd "C-!") 'toggle-input-method)

;;
;; 一些缩进设置
;;
(setq default-tab-width 4)
(setq tab-width 4)
(setq-default indent-tabs-mode nil)
;;(c-set-style "C++")
;;(electric-pair-mode t)

;;
;; set-rgrep-command
;;
(global-set-key (kbd "M-s") 'rgrep)

;;
;; fold-this mode 的一些设置
;;
(global-set-key (kbd "C-c C-f") 'fold-this-all)
(global-set-key (kbd "C-c C-F") 'fold-this)
(global-set-key (kbd "C-c M-f") 'fold-this-unfold-all)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-error ((t (:inherit error :background "yellow" :underline (:color "cyan" :style wave)))))
 '(which-func ((t (:foreground "cyan")))))

(provide 'init)
    ;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "f5b6be56c9de9fd8bdd42e0c05fecb002dedb8f48a5f00e769370e4517dde0e8" "833ddce3314a4e28411edf3c6efde468f6f2616fc31e17a62587d6a9255f4633" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "3e200d49451ec4b8baa068c989e7fba2a97646091fd555eca0ee5a1386d56077" default)))
 '(package-selected-packages
   (quote
    (solarized-theme go-mode company-irony-c-headers irony use-package tabbar sr-speedbar helm-projectile helm-gtags find-file-in-project diminish company-irony company-c-headers))))
