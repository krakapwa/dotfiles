(defun org-download/init-org-download()
  (use-package org-download 
    :config
    ))

(defun org-download/post-init-org ()
  (spacemacs/set-leader-keys-for-major-mode 'org-mode
    "iy" 'org-download-yank
    "is" 'org-download-screenshot
    ))
