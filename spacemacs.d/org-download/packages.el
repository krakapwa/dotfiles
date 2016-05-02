;;; packages.el --- org-download layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Laurent Lejeune <olol85@gmail.com>
;; URL: https://github.com/krakapwa
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;;; Code:

(defconst org-download-packages
  '(
    org
    org-download
    )
  )


(defun org-download/init-org-download()
 (use-package org-download 
    :config
    :init
    ) 
  )

(defun org-download/post-init-org ()
  (spacemacs/set-leader-keys-for-major-mode 'org-mode
    "iy" 'org-download-yank
    "is" 'org-download-screenshot
    ))

;;; packages.el ends here