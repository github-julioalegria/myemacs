;; Tell emacs where is your personal elisp lib dir
;; this is default dir for extra packages
(add-to-list 'load-path "~/.emacs.d")
(progn (cd "~/.emacs.d") (normal-top-level-add-subdirs-to-load-path))

;; Only spaces, no tabs
(setq indent-tabs-mode nil)

;; Place all auto-saves and backups in the tmp directory
(setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

;; Maximize emacs on startup based on resolution
(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if (display-graphic-p)
  (progn
    ;; use 80 char wide window
    (add-to-list 'default-frame-alist (cons 'width 80))
    ;; for the height, subtract a couple hundred pixels
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist 
         (cons 'height (/ (- (x-display-pixel-height) 180)
                             (frame-char-height)))))))
(set-frame-size-according-to-resolution)

;; Settings horizontal split as  default, instead of vertical split
;; (setq split-height-threshold nil)
;; (setq split-width-threshold 0)

;; Double the width of the frame and split window horizontally
;; contributor: Julio M. Alegria
(defun double-width-split-frame (filename)
   (interactive "FFind file: ")
   (set-frame-width (selected-frame) 160)
   (split-window-horizontally)
   (find-file filename))

;; key-binding for double-width-split-frame (C-})
(global-set-key (kbd "C-}") 'double-width-split-frame)

;; Keeps current window (closes the rest) and returns to normal frame width
;; contributor: Julio M. Alegria
(defun close-other-windows-normal-width ()
   (interactive)
   (delete-other-windows)
   (set-frame-width (selected-frame) 80))

;; key-binding for close-other-windows-normal-width (C-{)
(global-set-key (kbd "C-{") 'close-other-windows-normal-width)

;; Highlight matching brackets
(show-paren-mode 1)
;; with no delay
(setq show-paren-delay 0)

;; Javascript with 2 spaces indentation
(setq js-indent-level 2)

;; uniquify, for better buffer naming
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; C and C++ with 4 spaces indentation (linux style)
(setq c-default-style "linux"
      c-basic-offset 4)

;; web-mode, great for editing django templates
;; (HTML, javascript and django tags)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; key-binding to open the python shell (python-mode only)
(add-hook 'python-mode-hook
          (lambda () (local-set-key [C-tab] 'run-python)))

;; yasnippet, best snippet extension ever!
(require 'yasnippet)
(yas-global-mode 1)
;; fixing indentation in snippets
(setq yas/indent-line 'fixed)
