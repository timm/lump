"Load control (never load the same thing twice)."
; vim: noai:ts=2:sw=2:et: 

(pushnew :lump *FEATURES*)

(defvar *gotten* nil)

(defun lump (&rest files)
  (mapc 
    (lambda (f)
      (unless (member f *gotten* :test 'equalp)
        (format *error-output* "; ~(~a~).lisp~%" f)
        (push f *gotten*)
        #-sbcl (load f) 
        #+sbcl (handler-bind
                 ((style-warning #'muffle-warning))
                 (load f))))
    files))
