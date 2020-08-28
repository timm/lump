"Tests for the test engine `yes.lisp`."
; vim: noai:ts=2:sw=2:et: 
#+lump (lump "yes")

(dofun fail ()
  (yes nil))

