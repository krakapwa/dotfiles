;Latex
(use-package auctex
  :defer t
  :ensure t
  :mode ("\\.tex\\'" . latex-mode)
  :commands (latex-mode LaTeX-mode plain-tex-mode)
  :init
  (progn
    (add-hook 'LaTeX-mode-hook #'LaTeX-preview-setup)
    (add-hook 'LaTeX-mode-hook #'flyspell-mode)
    (add-hook 'LaTeX-mode-hook #'turn-on-reftex)
    (setq TeX-auto-save t
	  TeX-parse-self t
	  TeX-save-query nil
	  TeX-PDF-mode t)
    (setq-default TeX-master nil))
  :general
  (:keymaps 'latex-mode-map
   :states '(normal insert emacs)
   :major-mode 'latex-mode
   :prefix "SPC"
   :which-key "Latex"
      "mc" 'reftex-citation
   )
  )

;(general-define-key
; :keymaps '(normal visual)
; :major-mode 'latex-mode
; :which-key "Latex"
; :prefix "SPC"
;  "mc" 'reftex-citation)

;; So that RefTeX also recognizes \addbibresource.
(setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource"))
(setq reftex-default-bibliography '("~/Documents/2017_miccai/laurent_lejeune/refs.bib"))
