"Tests for the test engine `bins.lisp`."
; vim: noai:ts=2:sw=2:et: 
(load "got")
(got "yes" "bins" "yes_data")

(dofun weather (&aux (data (make-instance 'rows)))
  (adds data (lines (getf *data* 'weather)))
  (print "")
  (print (? data cols xsyms))
  (dolist (xsym (? data cols xsyms))
    (dolist (bin (syms2bins (? data all)
                            :goal "yes"
                            :x (? xsym pos)
                            :y (? data cols klass pos)))
      (print `(score ,(? bin score) 
                x ,(? bin x) ys ,(? bin ys))))))
