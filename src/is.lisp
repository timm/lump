"Define bunch of magic symbols."
; vim: noai:ts=20:sw=2:et: 
#+lump (lump "my")

(labels 
  ((is (x &rest l)
       (when (> (length x) 0)
         (let ((n (elt x 0)))
           (dolist (one l)
             (if (eql n one)
               (return t)))))))

  (defun less?   (x) (is x (my ch less)))
  (defun ignore? (x) (is x (my ch skip)))
  (defun klass?  (x) (is x (my ch klass)))
  (defun goal?   (x) (is x (my ch less) (my ch more) (my ch klass)))
  (defun num?    (x) (is x (my ch num)  (my ch less) (my ch more)))
)


(defun skip? (x) 
  (and (stringp x)
       (eql x (my ch skip))))
