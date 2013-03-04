;; Tell emacs where is your personal elisp lib dir
;; this is default dir for extra packages
(add-to-list 'load-path "~/.emacs.d")
(progn (cd "~/.emacs.d") (normal-top-level-add-subdirs-to-load-path))

;; uniquify, for better buffer naming
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; web-mode, great for editing django templates
;; (HTML, javascript and django tags)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; yasnippet, best snippet extension ever!
(require 'yasnippet)
(yas-global-mode 1)
;; Fixing indentation in snippets
(setq yas/indent-line 'fixed)

;; expand-region, increases the selected region by semantic units
;; Just keep pressing the key until it selects what you want
(require 'expand-region)

;; Place all auto-saves and backups in the tmp directory
(setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

;; Highlight matching brackets
(show-paren-mode 1)
;; with no delay
(setq show-paren-delay 0)

;; Only spaces, no tabs
(setq indent-tabs-mode nil)

;; C and C++ with 4 spaces indentation (linux style)
(setq c-default-style "linux"
      c-basic-offset 4)

;; Javascript with 2 spaces indentation
(setq js-indent-level 2)

;; Maximize vertically emacs on startup, based on resolution
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

;; Key-binding (C-!) for expand-region
(global-set-key (kbd "C-!") 'er/expand-region)

;; Double the width of the frame and split window horizontally
;; contributor: Julio M. Alegria <julio.alegria@ucsp.edu.pe>
(defun double-width-split-frame (filename)
   (interactive "FFind file: ")
   (set-frame-width (selected-frame) 166)
   (split-window-horizontally)
   (find-file filename))

;; Key-binding (C-}) for double-width-split-frame
(global-set-key (kbd "C-}") 'double-width-split-frame)

;; Keeps current window (closes the rest) and returns to normal frame width
;; contributor: Julio M. Alegria <julio.alegria@ucsp.edu.pe>
(defun close-other-windows-normal-width ()
   (interactive)
   (delete-other-windows)
   (set-frame-width (selected-frame) 80))

;; Key-binding (C-{) for close-other-windows-normal-width
(global-set-key (kbd "C-{") 'close-other-windows-normal-width)

;; Key-binding (C-$) to open the shell
(global-set-key (kbd "C-$") 'shell)

;; Key-binding (C-%) to open the python shell (python-mode only)
(add-hook 'python-mode-hook
          (lambda () (local-set-key (kbd "C-%") 'run-python)))

;; Use local file pyflakespep8.py (pyflakes + PEP8) instead of default
;; pychecker for a source code warning and error report (C-c C-w)
(custom-set-variables
  '(py-pychecker-command (file-truename "~/.emacs.d/pyflakespep8.py"))
  '(py-pychecker-command-args (quote ("")))
  '(python-check-command (file-truename "~/.emacs.d/pyflakespep8.py")))

;; flymake: python checker on the fly using local file pyflakespep8.py
;; (pyflakes + PEP8) for better source code warning and error reports
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list (file-truename "~/.emacs.d/pyflakespep8.py")
	    (list local-file))))
  ;; Define the modes where you want flymake to be enabled,
  ;; in my case I just want flymake on python files
  (setq flymake-allowed-file-name-masks
	'(("\\.py\\'" flymake-pyflakes-init))))
(add-hook 'find-file-hook 'flymake-find-file-hook)
