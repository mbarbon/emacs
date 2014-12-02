; -*- mode: lisp -*-

(autoload 'geben "geben" "DBGp Debugger on Emacs" t)

(defun my-geben-session-setup (session)
  (geben-save-frame-configuration)
  (delete-other-windows)
  (let ((code (selected-window))
        (info (split-window nil nil t))
        (height (window-total-height (selected-window))))
    (let ((middle (split-window info (/ height 3))))
      (let ((bottom (split-window middle)))
        (set-window-parameter code 'geben-role 'code)
        (set-window-parameter info 'geben-role 'context)
        (set-window-parameter middle 'geben-role 'backtrace)
        (set-window-parameter bottom 'geben-role 'misc))))
  (geben-dbgp-display-window (geben-session-context-buffer session) 'context)
  (geben-dbgp-display-window (geben-backtrace-buffer session) 'backtrace))

(add-hook 'geben-session-enter-hook 'my-geben-session-setup)

(custom-set-variables '(geben-temporary-file-directory "~/.emacs.d/state/geben"))
