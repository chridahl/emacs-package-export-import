;; 

(defun save-installed-packages ()
  "Creates a file named .my-emacs-packages containing all activated emacs packages."
  (setq export-filename "~/.my-emacs-packages")  
  (if (file-exists-p export-filename) (delete-file export-filename))
  (dolist (x package-activated-list)
    (append-to-file
     (format "%s\r\n" (symbol-name x))
     nil export-filename))
  (message "Done writing export file."))

(defun restore-packages ()
  (setq export-filename "~/.my-emacs-packages")
  (if (file-exists-p export-filename)
      (mapcar
       (lambda (package)
         (package-install 'package))
       (with-temp-buffer
         (insert-file-contents export-filename)
         (split-string (buffer-string) "\n" t))
       )
    (message (format "Could not find %s. Cancelling package import." export-filename)))  
  )
  



