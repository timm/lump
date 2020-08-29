"Load control (never load the same thing twice)."
; vim: noai:ts=2:sw=2:et: 

(pushnew :lump *FEATURES*)

(defvar *gotten* nil)

(defun lump (&rest files)
  (dolist (file files) 
    (unless (member file *gotten* :test 'equalp)
      (format *error-output* "; ~(~a~).lisp~%" file)
      (push file *gotten*)
      #-sbcl (load file) 
      #+sbcl (handler-bind
               ((style-warning #'muffle-warning))
               (load file)))))
