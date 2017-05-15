;Python
(use-package elpy
  :ensure t
  :commands elpy-enable
  :init (with-eval-after-load 'python (elpy-enable))

  :config
  (electric-indent-local-mode -1)
  (delete 'elpy-module-highlight-indentation elpy-modules)
  (delete 'elpy-module-flymake elpy-modules)

  (defun ha/elpy-goto-definition ()
    (interactive)
    (condition-case err
        (elpy-goto-definition)
      ('error (xref-find-definitions (symbol-name (symbol-at-point))))))

  :bind (:map elpy-mode-map ([remap elpy-goto-definition] .
                             ha/elpy-goto-definition)))

(use-package pyenv-mode
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
  :ensure t
  :init (add-hook 'python-mode-hook 'anaconda-mode)
        (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
  :config (use-package company-anaconda
            :ensure t
            :init (add-hook 'python-mode-hook 'anaconda-mode)
            (eval-after-load "company"
              '(add-to-list 'company-backends '(company-anaconda :with company-capf)))))

(use-package python
  :general
  (:keymaps 'python-mode-map
    :states '(normal insert emacs)
    :major-mode 'python-mode
    :prefix "SPC"
    :non-normal-prefix "M-SPC"
    :which-key "Python"
    "mv" 'pyenv-mode-set
    "mb" 'elpy-shell-send-region-or-buffer
    "md" 'anaconda-mode-find-references
    "mg" 'anaconda-mode-find-assignments
    "mf" 'elpy-yapf-fix-code
    "mi" 'run-python))

(setq python-shell-interpreter "ipython"
    python-shell-interpreter-args "--simple-prompt -i")
