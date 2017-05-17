;;; Python --- Mine
;;; Commentary:

; Highlight the call to pdb
(defun annotate-pdb ()
  (interactive)
    (highlight-lines-matching-regexp "^[ ]*import pdb; pdb.set_trace()"))
(add-hook 'python-mode-hook 'annotate-pdb)

(use-package elpy
  :defer t
  :ensure t
  :commands elpy-enable
  :init (with-eval-after-load 'python (elpy-enable))

  :config
  (highlight-lines-matching-regexp "^[ ]*import pdb; pdb.set_trace()")
  (electric-indent-local-mode -1)
  (delete 'elpy-module-highlight-indentation elpy-modules)
  (delete 'elpy-module-flymake elpy-modules)

  (defun python-add-breakpoint ()
    "Add a break point"
    (interactive)
    (move-beginning-of-line 1)
    ;(newline-and-indent)
    (insert "import pdb; pdb.set_trace()\n")
    (highlight-lines-matching-regexp "^[ ]*import pdb; pdb.set_trace()"))

  (defun my-elpy-shell-send-region-or-buffer (&optional arg)
    "Send the active region or the buffer to the Python shell.

    If there is an active region, send that. Otherwise, send the
    whole buffer.

    In Emacs 24.3 and later, without prefix argument, this will
    escape the Python idiom of if __name__ == '__main__' to be false
    to avoid accidental execution of code. With prefix argument, this
    code is executed."
    (interactive "P")
    ;; Ensure process exists
    (elpy-shell-get-or-create-process)
    (let ((if-main-regex "^if +__name__ +== +[\"']__main__[\"'] *:")
          (has-if-main nil))
      (if (region-active-p)
          (let ((region (elpy--region-without-indentation
                        (region-beginning) (region-end))))
            (setq has-if-main (string-match if-main-regex region))
            (python-shell-send-string region))
        (save-excursion
          (goto-char (point-min))
          (setq has-if-main (re-search-forward if-main-regex nil t)))
        (python-shell-send-buffer arg))
      (display-buffer (process-buffer (elpy-shell-get-or-create-process)))
      (when has-if-main
        (message (concat "Removed if __main__ == '__main__' construct, "
                        "use a prefix argument to evaluate.")))))

  (defun ha/elpy-goto-definition ()
    (interactive)
    (condition-case err
        (elpy-goto-definition)
      ('error (xref-find-definitions (symbol-name (symbol-at-point))))))

  :bind (:map elpy-mode-map ([remap elpy-goto-definition] .
                             ha/elpy-goto-definition)))

(use-package pyenv-mode
  :defer t
  :ensure t
  :config
    (defun projectile-pyenv-mode-set ()
      "Set pyenv version matching project name."
      (let ((project (projectile-project-name)))
        (if (member project (pyenv-mode-versions))
            (pyenv-mode-set project)
          (pyenv-mode-unset))))

    (add-hook 'projectile-switch-project-hook 'projectile-pyenv-mode-set)
    (add-hook 'python-mode-hook 'pyenv-mode))

(use-package anaconda-mode
  :defer t
  :ensure t
  :init (add-hook 'python-mode-hook 'anaconda-mode)
        (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
  :config (use-package company-anaconda
            :ensure t
            :init (add-hook 'python-mode-hook 'anaconda-mode)
            (eval-after-load "company"
              '(add-to-list 'company-backends '(company-anaconda :with company-capf)))))

(use-package window-purpose)
;(purpose-mode)
(add-to-list 'purpose-user-mode-purposes '(python-mode . py))
(add-to-list 'purpose-user-mode-purposes '(inferior-python-mode . py-repl))
(purpose-compile-user-configuration)

(use-package python
  :defer t
  :general
  (:keymaps 'python-mode-map
    :states '(normal insert emacs)
    :major-mode 'python-mode
    :prefix "SPC"
    :which-key "Python"
    "mv" 'pyenv-mode-set
    "mb" 'my-elpy-shell-send-region-or-buffer
    "md" 'python-add-breakpoint
    "mg" 'anaconda-mode-find-assignments
    "mf" 'elpy-yapf-fix-code
    "mi" 'run-python))

(setq python-shell-interpreter "ipython"
    python-shell-interpreter-args "--simple-prompt -i")
