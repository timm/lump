"Misc stuff that belongs nowhere else."
; vim: noai:ts=2:sw=2:et: 

(defun hash-values (h)
   (loop for v being the hash-values of h collect v))
