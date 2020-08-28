"Manage rows of data, plus summaries of each col."
; vim: noai:ts=2:sw=2:et: 
#+lump (lump "oo" "is" "strings" "col")

(defthing rows thing (all) (cols (make-instance 'cols)))
(defthing row thing (cells) (_rows))
(defthing cols thing (all) (nums) (syms) 
  (xnums) (xsyms) (x) (y) (klass))

;;; columns -------------------------------------
(defmethod header ((i cols) headers)
  (with-slots (all nums syms xsyms xnums x y klass) i
    (doitems (txt pos headers)
      (let ((new (make-instance 
                   (if (num? txt) 'num 'sym)
                   :txt txt :pos pos
                   :w (if (less? txt) -1 1))))
        (push new all)
        (if (num?  txt) (push new nums) (push new syms))
        (if (goal? txt) (push new y)    (push new x))
        (when (klass? txt)
          (setf klass new))
        (unless (goal? txt)
          (print `(notgoal ,txt))
          (if (num?  txt) 
            (push new xnums) 
            (push new xsyms)))))
    (setf xnums (reverse xnums)
          xsyms (reverse xsyms)
          nums  (reverse nums)
          syms  (reverse syms)
          x     (reverse x)
          all   (reverse all)
          y     (reverse y))))

(defmethod row ((i cols) rows cells)
  (make-instance 
    'row 
    :_rows rows
    :cells (mapcar #'add (? i all) cells)))

;;; rows ----------------------------------------

(defmethod add ((i rows) lst)
 "simply add one `lst` of data to `i`"
  (with-slots (all cols) i
    (if (? cols all)
      (push (row cols i lst) all)
      (header cols lst))))

(defmethod adds ((i rows) lst)
  "Add N things, skipping any `ignore?`ed columns."
  (labels 
    ((use? (lst &aux out)
           (doitems (txt pos (car lst) out) 
             (unless (ignore? txt) (push pos out))))
     (use! (using one &aux out)
           (dolist (use using out) 
             (push (elt one use) out))))
    (let ((using (use? lst)))
      (dolist (one lst i)
        (add i (use! using one))))))

