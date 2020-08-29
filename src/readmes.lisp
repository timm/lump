"Generate ../README.md from docstrings."
; vim: noai:ts=2:sw=2:et: 
#+lump (lump "os")

(defmacro doread ((it f &optional out 
                      &key (take #'read)) &body body)
  "Iterator for running over files or strings."
  (let ((str (gensym)))
    `(with-open-file (,str ,f)
       (loop for 
             ,it = (handler-case (funcall ,take ,str)
                   (end-of-file () (loop-finish)))
             while ,it do 
             (progn ,@body))
       ,out)))

(defun readme(&optional (s t))
  "Generate README.md from doco strings from LISP code in a directory."
  (dolist (f (sort (directory "*.lisp") 
                   #'(lambda (x y) (string< (pathname-name x) 
                                            (pathname-name y)))))
    (let ((name (pathname-name f)))
      (format t "~%~%## [~a.lisp](src/~a.lisp)~%~%" name name)
      (doread (x f)
        (labels
          ((defp   () (and (consp x)
                           (member (first x) 
                                  '(dofun defun defmacro defmethod))))
           (fyip   () (stringp x))
           (secret () (and (consp x)
                           (char= #\_ (elt (symbol-name (second x)) 0))))
           (docp   () (and    (consp x)
                              (> (length x) 3)
                              (stringp (fourth x))
                              (not (equal "" (fourth x)))))
           (dump   (str  &optional (pad ""))
                   (format s "~%<ul>~%~%~a~a~%~%</ul>~%" pad str)))
          (when (fyip)
            (terpri s) (terpri s)
            (dump x)
            (terpri s) (terpri s)
            )
          (when (and (defp) (docp) (not (secret)))
            (format s "~%### ~(~a~) ~(~a~)~%~%" 
                    (second x) (or (third x) ""))
            (dump (fourth x))
            (format s "~%")))))))

(let ((cli (args)))
  (if (and cli (member "--makedoc" cli :test #'equalp))
    (readme)))
