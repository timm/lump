"Misc stuff that belongs nowhere else."
; vim: noai:ts=2:sw=2:et: 

(defmethod within ((x number) (y number) (z number))
  (<= x y z))

(defmethod within ((x string) (y string) (z string))
  (and (string-equal x y)
       (string-equal y z)))

(defun hash-values (h)
   (loop for v being the hash-values of h collect v))
