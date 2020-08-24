"Tests for the test engine `bins.lisp`."
; vim: noai:ts=2:sw=2:et: 
(load "got")
(got "yes" "bins" "yes_data")

(dofun weather (&aux (data (make-instance 'rows)))
  (adds data (lines (getf *data* 'weather)))
  (print "")
  (print (? data cols xsyms))
  (print (? data cols klass))
  (let* ((goal "yes")
        (yes (gethash goal (? data cols klass seen)))
        (no  (- (length (? data rows)) yes)))
    (dolist (xsym (? data cols xsyms))
      (dolist (bin (syms2bins (? data all)
                              :yes yes :no no
                              :goal "yes"
                              :x (? xsym pos)
                              :y (? data cols klass pos)))
        (print `(score ,(? bin score) 
                       col ,(? bin col) ys ,(? bin ys)))))))
