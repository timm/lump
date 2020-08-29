(defsystem lump
  :author "Tim Menzies <timm@ieee.org>"
  :maintainer "Tim Menzies <timm@ieee.org>"
  :license "MIT"
  :version "0.2"
  :homepage "https://github.com/timm/lump"
  :bug-tracker "https://github.com/timm/lump/issues"
  :source-control (:git "git@github.com:timm/lump.git")
  :description "Some of my LISP tricks"
  :depends-on ()
  :components ((:module "src"
                :serial t
                :components (
                            (:file "bins")
                            (:file "col")
                            (:file "is")
                            (:file "lump")
                            (:file "macros")
                            (:file "misc")
                            (:file "my")
                            (:file "oo")
                            (:file "os")
                            (:file "readmes")
                            (:file "rows")
                            (:file "sandbox")
                            (:file "strings")
                            (:file "yes")
                            (:file "yes_bins")
                            (:file "yes_col")
                            (:file "yes_data")
                            (:file "yes_is")
                            (:file "yes_macros")
                            (:file "yes_my")
                            (:file "yes_rows")
                            (:file "yes_yes")
       )))
  :long-description #.(uiop:read-file-string (uiop:subpathname *load-pathname* "README.md")))
