"Tests for the test engine `yes.lisp`."
; vim: noai:ts=2:sw=2:et: 
(load "got")
(got "yes")

(dofun fail ()
  (yes nil))

