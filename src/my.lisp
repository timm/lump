"Define globals."
; vim: noai:ts=2:sw=2:et: 
#+lump (lump "macros")

(defvar *my*
       '(ch (     skip  #\?
                    less  #\<
                    more  #\>
                    num   #\$
                    klass #\!)
         bins (     max 512 
              )
         some (     max 512 
                    step .5 
                    cohen .3 
                    trivial 1.05)
         seed 1
         yes   (    it ""
                    pass 0
                    fail 0)))

(defmacro my (&rest fs) 
   "getter for globals"
   `(getr getf *my* ,@fs))
