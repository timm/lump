"Tests for `my.lisp`."
; vim: noai:ts=2:sw=2:et: 
#+lump (lump "my" "yes")
                   
(dofun the ()
   (print (my ch skip))
   (yes (eql (my ch skip) #\?))
   (setf (my ch skip) #\a)
   (yes (eql (my ch skip) #\a))
   (setf (my ch skip) #\?)
)
