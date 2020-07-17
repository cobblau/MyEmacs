;;; package --- Summary
;;; Commentary:
;;; CobbLiu's  config file
;;; Code:
(setq user-full-name "CobbLiu")
(setq user-mail-address "cobblau@gmail.com")
(setq byte-compile-warnings nil)

;; third party source
(require 'package)
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;;(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/marmalade/"))
(add-to-list 'package-archives '("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/"))
(package-initialize)

;; 第三方库的路径
;;(add-to-list 'load-path "/usr/share/emacs/site-lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;; 第三方库主题的路径
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'wombat t)

;;======================  cl
;; if not required, some error occur.
(require 'cl)

;; go语言的自动补全设置
;; 需要预先安装gocode到$PATH中：github.com/nsf/gocode
;;(require 'go-complete)
;;(require 'go-autocomplete)

;; ======================= yasnippet ========
;; (require 'yasnippet)
;; (yas-global-mode 1)

;; 代码补全的配置
;; ===================================================
(require 'company)
(require 'irony)
(require 'company-irony)
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'c-mode-hook 'company-mode)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 2)
(setq company-dabbrev-downcase nil)
(add-to-list 'company-backends 'company-dabbrev)
(add-to-list 'company-backends 'company-dabbrev-code)
(add-to-list 'company-backends 'company-files)
(add-to-list 'company-backends 'company-semantic)
(add-to-list 'company-backends 'company-keywords)
(add-to-list 'company-backends 'company-irony)
;;(add-to-list 'company-backends 'company-gtags)
(add-to-list 'company-backends 'company-capf)
(require 'company-c-headers)
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

;; ====================== cmode only =======================
(defun my-c-mode-hook()
 ;; 删掉行尾的空格
 (add-hook 'before-save-hook 'delete-trailing-whitespace))
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)
;;(add-hook 'before-save-hook #'gofmt-before-save)
(add-hook 'completion-at-point-functions 'go-complete-at-point)

;; ====================== sr-speedbar ======================
;; sr-speedbar是一个轻量级的代码树插件，可以在左侧查看代码树
(require 'sr-speedbar)
;;(setq sr-speedbar-left-side nil)  ;;右侧
(setq sr-speedbar-right-side nil)  ;;右侧
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


;; ======================== ido mode =======================
;; ido是Emacs自带的一个很好的补全方式
;; ido可以在find-file或者switch-buffer的时候, 通过输入关键字自动筛选结果.
(require 'ido)
(ido-mode t)
;; enable fuzzy matching
(setq ido-enable-flex-matching t)
;; C-s ido-next-match
;; C-r ido-prev-match

;; ======================= helm =====================
(require 'helm-config)
(helm-mode 1)
(helm-autoresize-mode 1)
(global-set-key (kbd "C-h C-l") 'helm-find-files)
;;(global-set-key (kbd "C-h C-f") 'helm-find) ;; C-u C-h C-f 指定要搜索的目录
(global-set-key (kbd "C-h C-m") 'helm-imenu)
(global-set-key (kbd "C-h C-o") 'helm-occur)
;;(require 'find-file-in-project)
;;(setq ffip-project-root "~/projs/PROJECT_DIR")
;; M-x find-file-in-project-by-selected
;; M-x find-file-in-project
;; M-x find-file-in-project-at-point
;;(global-set-key (kbd "C-h C-f") 'find-file-in-project)
;;(global-set-key (kbd "C-h C-j") 'find-file-in-project-at-point)

(require 'helm-projectile)
(helm-projectile-on)
(setq projectile-indexing-method 'native)
;; (setq projectile-enable-caching t)
(add-to-list 'projectile-globally-ignored-directories "third")
(add-to-list 'projectile-globally-ignored-directories "build")
(add-to-list 'projectile-globally-ignored-directories ".git")
(global-set-key (kbd "C-h C-f") 'helm-projectile-find-file)
(global-set-key (kbd "C-h C-d") 'helm-projectile-find-dir)
(global-set-key (kbd "C-h C-p") 'helm-projectile-find-file-dwim)

;; ===================== gtags =====================
(require 'gtags)
(require 'helm-gtags)
(autoload 'gtags-mode "gtags" "" t)
(add-hook 'c-mode-common-hook 'gtags-mode)
(add-hook 'c++-mode-common-hook 'gtags-mode)
(global-set-key (kbd "C-c v") 'helm-gtags-find-rootdir)
(global-set-key (kbd "C-c C-j") 'helm-gtags-select-tag)
(global-set-key (kbd "M-.") 'helm-gtags-find-tag)
(global-set-key (kbd "M-*") 'helm-gtags-pop-stack)
(global-set-key (kbd "C-c C-r") 'helm-gtags-find-rtag)
(global-set-key (kbd "C-j") 'helm-gtags-select-tag)
;; gtags自动更新
;; 代码来源：https://www.emacswiki.org/emacs/GnuGlobal
(defun gtags-update-single(filename)
  "Update Gtags database for changes in a single file"
  (interactive)
  (start-process "update-gtags" "update-gtags" "bash" "-c" (concat "cd " (gtags-root-dir) " ; gtags --single-update " filename )))
(defun gtags-update-current-file()
  (interactive)
  (defvar filename)
  (setq filename (replace-regexp-in-string (gtags-root-dir) "." (buffer-file-name (current-buffer))))
  (gtags-update-single filename)
  (message "Gtags updated for %s" filename))

(defun gtags-update-hook()
  "Update GTAGS file incrementally upon saving a file"
  (when gtags-mode
    (when (gtags-root-dir)
      (gtags-update-current-file))))
(add-hook 'after-save-hook #'gtags-update-hook)

;; (autoload 'gtags-mode "gtags" "" t)
;; (add-hook 'c-mode-common-hook 'gtags-mode)
;; (add-hook 'c++-mode-common-hook 'gtags-mode)
;; (define-key gtags-mode-map (kbd "C-c v") 'gtags-find-rootdir)
;; (define-key gtags-mode-map (kbd "C-c C-j") 'gtags-select-tag)
;; (define-key gtags-mode-map (kbd "M-.") 'gtags-find-tag)
;; (define-key gtags-mode-map (kbd "M-*") 'gtags-pop-stack)
;; (define-key gtags-mode-map (kbd "C-c C-r") 'gtags-find-rtag)
;; (global-set-key (kbd "C-j") 'gtags-select-tag)
;; (global-set-key (kbd "M-.") 'helm-gtags-find-tag)
;; (global-set-key (kbd "M-*") 'gtags-pop-stack)

;; ==================== fill-column-indicator
;; 显示80行的标线
;; (require 'fill-column-indicator)
;; (setq fci-rule-width 2)
;; (setq fci-rule-color "yellow")
;; (setq fci-rule-column 80)
;; ;; avaiable in c source codes
;; ;; (add-hook 'c-mode-hook 'fci-mode)
;; (define-globalized-minor-mode
;;   global-fci-mode fci-mode (lambda () (fci-mode 1)))
;;(global-fci-mode 0)


;; =================== HideShow Mode
(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)
(global-set-key (kbd "C-.") 'hs-toggle-hiding)

;; 编译的一些设置
(global-set-key (kbd "M-m") 'compile)

;; 显示当前光标在哪个函数中
(which-function-mode 1)
(setq-default header-line-format
              '((which-func-mode ("" which-func-format " "))))
(setq mode-line-misc-info
      ;; We remove Which Function Mode from the mode line, because it's mostly
      ;; invisible here anyway.
      (assq-delete-all 'which-func-mode mode-line-misc-info))

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
(setq column-number-mode t)

;; C++代码风格设置
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

;; =================== Diminish
(require 'diminish)
(diminish 'abbrev-mode)
(diminish 'company-mode)
(diminish 'helm-mode)
(diminish 'gtags-mode)
(diminish 'helm-gtags-mode)
(diminish 'hs-minor-mode)
(diminish 'whitespace-mode)

;; M-Del删除的单词不加入到剪切板
(defun backward-delete-word (arg)
    "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times."
    (interactive "p")
    (delete-region (point) (progn (backward-word arg) (point))))
(global-set-key (kbd "C-M-<backspace>") 'backward-kill-word)
(global-set-key (kbd "M-DEL") 'backward-delete-word)

;; 一些窗口操作的快捷键
(global-set-key (kbd "M-4") 'delete-window)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-3") 'split-window-horizontally)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "C-^") 'enlarge-window)
;(global-set-key (kbd "C-*") 'shrink-window)
(global-set-key (kbd "C-q") 'kill-ring-save)
(global-set-key (kbd "C-{") 'backward-page)
(global-set-key (kbd "C-}") 'forward-page)

;; Buffer 之间跳转的快捷键
(global-set-key (kbd "C-x C-j") 'switch-to-prev-buffer)
(global-set-key (kbd "C-x C-k") 'switch-to-next-buffer)

;; 括号间跳转
(global-set-key (kbd "M-0") 'forward-list)
(global-set-key (kbd "M-9") 'backward-list)

;; 跳转到某行
(global-set-key (kbd "M-g") 'goto-line)

;; 字符替换
(global-set-key (kbd "M-r") 'replace-string)
(global-set-key (kbd "C-!") 'toggle-input-method)

;; 一些缩进设置
(setq default-tab-width 4)
(setq tab-width 4)
(setq-default indent-tabs-mode nil)
;;(c-set-style "C++")
;;(electric-pair-mode t)

;; set-rgrep-command
(global-set-key (kbd "M-s") 'rgrep)

;; fold-this mode 的一些设置
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
