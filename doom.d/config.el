(map! :leader
      :desc "Kill buffer" "x" #'kill-this-buffer
      :desc "Expand region" "e" #'er/expand-region
      :desc "Increase font size" "+" #'doom/increase-font-size
      :desc "Decrease font size" "-" #'doom/decrease-font-size
      :desc "Next buffer" "k" #'iflipb-next-buffer
      :desc "Previous buffer" "j" #'iflipb-previous-buffer
      :desc "Switch window" "TAB" #'ace-window)

(after! ranger
    (setq ranger-override-dired 'ranger)
    (setq ranger-override-dired-mode t))

(defface ispell-alpha-num-choice-face
  '((t (:background "black" :foreground "red")))
  "Face for `ispell-alpha-num-choice-face`."
  :group 'ispell)

(defface ispell-text-choice-face
  '((t (:background "black" :foreground "forestgreen")))
  "Face for `ispell-text-choice-face`."
  :group 'ispell)

(defun my-ispell-change-dictionaries ()
"Switch between language dictionaries."
(interactive)
  (let ((choice (read-char-exclusive (concat
          "["
          (propertize "E" 'face 'ispell-alpha-num-choice-face)
          "]"
          (propertize "nglish" 'face 'ispell-text-choice-face)
          " | ["
          (propertize "F" 'face 'ispell-alpha-num-choice-face)
          "]"
          (propertize "rench" 'face 'ispell-text-choice-face)))))
    (cond
      ((eq choice ?E)
        (setq flyspell-default-dictionary "english")
        (setq ispell-dictionary "english")
        (setq ispell-personal-dictionary "/home/laurent/aspell.en.pws")
        (ispell-kill-ispell)
        (message "English"))
      ((eq choice ?F)
        (setq flyspell-default-dictionary "french")
        (setq ispell-dictionary "french")
        (setq ispell-personal-dictionary "/home/laurent/aspell.fr.pws")
        (ispell-kill-ispell)
        (message "French"))
      (t (message "No changes have been made."))) ))

(defvar compilation-buffer-visible nil)

(defun toggle-compilation-visible ()
  (interactive)
  (setq compilation-buffer-visible (not compilation-buffer-visible))
  (message "Compilation buffer %s"
           (if compilation-buffer-visible "visible" "not visible")))

(defun notify-compilation-result(buffer msg)
  (with-current-buffer buffer
    (progn
      (cond
       ((and (string-match "^finished" msg) (string= "*compilation*" (buffer-name)))
        (progn
          (unless compilation-buffer-visible (delete-windows-on buffer))
          ))
       ((string= "*compilation*" (buffer-name))
        (progn
          ;; you can add a custom message here, like (buffer-contents, but I like the default ones from
          ;; compilation-mode
          ;;
          ;; (message "Compilation failed: %s" (buffer-substring () ()))
          ))
       )
      (setq current-frame (car (car (cdr (current-frame-configuration)))))
      (raise-frame current-frame))))

(add-to-list 'compilation-finish-functions 'notify-compilation-result)

(setq doom-theme 'doom-nord)
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 16))
(setq doom-big-font-increment 2)

(map! :localleader
      :map LaTeX-mode-map
      :desc "Master"    "m" 'TeX-command-master)
(setq TeX-parse-self t) ; Enable parse on load.
(setq TeX-auto-save t) ; Enable parse on save.

(require 'ox-extra)
(add-to-list 'org-latex-classes
             '("TMI"
               "\\documentclass[journal, web, twoside]{ieeecolor}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(setq TeX-view-program-list
      '(("zathura"
	 ("zathura" (mode-io-correlate "-sync.sh")
	  " "
	  (mode-io-correlate "%n:1:%t ")
	  "%o"))))

(use-package! typopunct
  :config
  (typopunct-change-language 'french t))

(use-package! iflipb
:config
    (setq iflipb-ignore-buffers '("(?!(\*Python\*))(^[*])")))

(setq langtool-language-tool-jar "/home/laurent/bin/LanguageTool-5.2/languagetool-commandline.jar")

(defun langtool-autoshow-detail-popup (overlays)
  (when (require 'popup nil t)
    ;; Do not interrupt current popup
    (unless (or popup-instances
                ;; suppress popup after type `C-g` .
                (memq last-command '(keyboard-quit)))
      (let ((msg (langtool-details-error-message overlays)))
        (popup-tip msg)))))

(setq langtool-autoshow-message-function
      'langtool-autoshow-detail-popup)

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
            '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
            "bibtex %b"
            "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
            "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
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

(defmacro by-backend (&rest body)
  `(case (if (boundp 'backend) (org-export-backend-name backend) nil) ,@body))

(setq org-export-allow-bind-keywords t)
(setq org-export-in-background nil)



(add-to-list 'org-latex-classes
             '("koma-article" "\\documentclass{scrartcl}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("koma-article-fr" "\\documentclass[french]{scrartcl}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("memoir-fr"
               "\\documentclass[a4paper,11pt,titlepage, twoside]{memoir}
                \\usepackage[utf8]{inputenc}
                \\usepackage[T1]{fontenc}
                \\usepackage{fixltx2e}
                \\usepackage{hyperref}
                \\usepackage{mathpazo}
                \\usepackage{color}
                \\usepackage{enumerate}
                \\definecolor{bg}{rgb}{0.95,0.95,0.95}
                \\tolerance=1000
                \\linespread{1.1}
                \\hypersetup{pdfborder=0 0 0}"
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-file-apps '("\\.pdf\\'" . "zathura %s"))

(setq fr-quotes '("fr"
                  (primary-opening :utf-8 "« " :html "&laquo;&nbsp;" :latex "\\enquote{" :texinfo "@guillemetleft{}@tie{}")
                  (primary-closing :utf-8 " »" :html "&nbsp;&raquo;" :latex "}" :texinfo "@tie{}@guillemetright{}")
                  (secondary-opening :utf-8 "« " :html "&laquo;&nbsp;" :latex "\\\enquote{" :texinfo "@guillemetleft{}@tie{}")
                  (secondary-closing :utf-8 " »" :html "&nbsp;&raquo;" :latex "\\}" :texinfo "@tie{}@guillemetright{}")
                  (apostrophe :utf-8 "’" :html "&rsquo;")))

(add-to-list 'org-export-smart-quotes-alist fr-quotes)
