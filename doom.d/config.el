(map! :leader
      :desc "Kill buffer" "x" #'kill-this-buffer
      :desc "Expand region" "e" #'er/expand-region
      :desc "Increase font size" "+" #'doom/increase-font-size
      :desc "Decrease font size" "-" #'doom/decrease-font-size
      :desc "Next buffer" "k" #'iflipb-next-buffer
      :desc "Previous buffer" "j" #'iflipb-previous-buffer
      :desc "Switch window" "TAB" #'ace-window)

(setq doom-theme 'doom-dracula)

(map! :localleader
      :map LaTeX-mode-map
      :desc "Master"    "m" 'TeX-command-master)
(setq TeX-parse-self t) ; Enable parse on load.
(setq TeX-auto-save t) ; Enable parse on save.

(use-package! iflipb
:config
    (setq iflipb-ignore-buffers '("(?!(\*Python\*))(^[*])")))

(use-package! yaml-mode
  :ensure t
  :mode ("\\.ya?ml\\'" . yaml-mode))

(add-hook 'python-mode-hook 'py-yapf-enable-on-save)

(defvar python--pdb-breakpoint-string "import pdb; pdb.set_trace() ## DEBUG ##")
(pyvenv-activate "/home/laurent/anaconda3/envs/my")
(setq pyvenv-default-virtual-env-name '"/home/laurent/anaconda3/envs/")
(setq pyvenv-virtual-env '"/home/laurent/anaconda3/envs/my")
(defun python-add-breakpoint ()
"Inserts a python breakpoint using `pdb'"
    (interactive)
    (back-to-indentation)
    ;; this preserves the correct indentation in case the line above
    ;; point is a nested block
    (split-line)
    (insert python--pdb-breakpoint-string)
    (python-set-debug-highlight))


(defun python-set-debug-highlight ()
(interactive)
(highlight-lines-matching-regexp "pdb" 'hi-red-b)
(highlight-lines-matching-regexp "pdb[.]?" 'hi-red-b))

(defun python-add-debug-highlight ()
"Adds a highlighter for use by `python--pdb-breakpoint-string'"
(interactive)
(python-set-debug-highlight))
(add-hook 'python-mode-hook 'python-add-debug-highlight)

(map! :localleader
      :map python-mode-map
      :desc "Insert breakpoint"    "d" 'python-add-breakpoint
      :desc "Fix code"    "f" 'py-yapf-buffer)

(use-package! org-ref
    :init
        (setq org-latex-pdf-process
            '("pdflatex -interaction nonstopmode -output-directory %o %f"
            "bibtex %b"
            "pdflatex -interaction nonstopmode -output-directory %o %f"
            "pdflatex -interaction nonstopmode -output-directory %o %f"))
        (setq org-ref-bibliography-notes "~/Documents/paper-notes/paper-notes.org"
            org-ref-default-bibliography "~/Documents/paper-notes/refs.bib"
            bibtex-completion-bibliography org-ref-default-bibliography
            org-ref-pdf-directory "~/Nextcloud/papers/"
            bibtex-completion-library-path "~/Nextcloud/papers"
            bibtex-completion-notes-path "~/Documents/paper-notes/paper-notes.org"
            bibtex-completion-pdf-open-function
                (lambda (fpath)
                (call-process "zathura" nil 0 nil fpath))))

(map! :localleader
      :map org-mode-map
      :desc "Insert citation"    "c" 'ivy-bibtex)

(after! org
  (require 'ox-extra)
  (ox-extras-activate '(ignore-headlines)))

(add-to-list 'org-latex-classes
               '("koma-article" "\\documentclass{scrartcl}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-latex-classes
 '("elsarticle"
 "\\documentclass{elsarticle}
 [NO-DEFAULT-PACKAGES]
 [PACKAGES]
 [EXTRA]"
 ("\\section{%s}" . "\\section*{%s}")
 ("\\subsection{%s}" . "\\subsection*{%s}")
 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
 ("\\paragraph{%s}" . "\\paragraph*{%s}")
 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-file-apps '("\\.pdf\\'" . "zathura %s"))
;; (setq org-export-in-background t)
