; -*- mode: lisp -*-

;; for Aquamacs
(when (boundp 'aquamacs-version)
  (setq mac-command-modifier 'meta)
  (cua-mode 0)
  (setq x-select-enable-clipboard t)
  (global-set-key [?\M-`] 'next-multiframe-window)
  )

;; some custom key bindings
(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

(define-key my-keys-minor-mode-map (kbd "\C-z") 'undo)
(define-key my-keys-minor-mode-map (kbd "\M-[") 'previous-tab-or-buffer)
(define-key my-keys-minor-mode-map (kbd "\M-]") 'next-tab-or-buffer)

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)

(defun my-minibuffer-setup-hook ()
  (my-keys-minor-mode 0))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)

(my-keys-minor-mode 1)

;; location for external packages.
(setq load-path
      (cons "~/.emacs.d/site-lisp"
      (cons "/opt/scala/misc/scala-tool-support/emacs"
            load-path)))

;; customization to separate file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

;; better default window titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

(setq make-backup-files nil)
(setq-default column-number-mode t)
(tool-bar-mode -1)
(transient-mark-mode t)
(global-set-key [?\C-z] 'undo)
(global-set-key [?\M-[] 'previous-tab-or-buffer)
(global-set-key [?\M-]] 'next-tab-or-buffer)
(server-start)

;; Global
(setq-default indent-tabs-mode nil)
(global-auto-revert-mode t)
(put 'narrow-to-region 'disabled nil)

;; C/C++
(setq-default c-basic-offset 4)
(setq c-default-style "stroustrup")

;; Auto-indent mode
(add-hook 'c-mode-common-hook
  (lambda()
    (require 'dtrt-indent)
    (dtrt-indent-mode t)))

;; Perl
(setq-default cperl-indent-level 4)

(autoload 'cperl-mode "cperl-mode" "Yay Perl" t)
(setq auto-mode-alist (cons '("\\.[pP][lLmM]$" . cperl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.pod$" . cperl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.t$" . cperl-mode) auto-mode-alist))

;; Scala
(require 'scala-mode-auto)
(setq-default scala-mode-indent:step 4)

;; Dired
(set-variable 'completion-ignored-extensions
              (cons ".pbc" completion-ignored-extensions))

;; C#
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist
   (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))

;; HaXe
(autoload 'haxe-mode "haxe-mode" "Yay HaXe" t)
(setq auto-mode-alist (cons '("\\.hx$" . haxe-mode) auto-mode-alist))

;; Ack
(require 'ack)

;; emacs client
(add-hook 'server-visit-hook 'make-frame)

;; show trailing white-spaces
(mapc (lambda (hook)
        (add-hook hook (lambda ()
                         (setq show-trailing-whitespace t))))
      '(python-mode-hook csharp-mode-hook c-mode-hook cperl-mode-hook
        java-mode-hook nxml-mode-hook scala-mode-hook
        c++-mode-hook javascript-mode-hook))
