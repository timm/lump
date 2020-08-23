(defsystem :cl-lump
    :depends-on (:cl-ppcre)
    :serial t
    :components (
                 (:file "package")
                 (:file "macros")
                 (:file "my")
                 (:file "is")
                 (:file "misc")
                 (:file "os")
                 (:file "bins")
                 (:file "col")
                 (:file "got")
                 (:file "oo")
                 (:file "readmes")
                 (:file "rows")
                 (:file "strings")
                 (:file "yes")
))
