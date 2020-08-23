"Manage rows of data, plus summaries of each col."
; vim: noai:ts=2:sw=2:et: 
(load "got")
(got "oo" "is" "strings" "col")

(defthing rows thing (all) (cols (make-instance 'cols)))
(defthing row thing (cells) (_rows))
(defthing cols thing (all) (nums) (syms) (x) (y) (klass))

;;; columns -------------------------------------
(defmethod header ((i cols) headers)
  (with-slots (all nums syms x y klass) i
    (doitems (txt pos (reverse headers))
      (let ((new (make-instance 
                   (if (num? txt) 'num 'sym)
                   :txt txt :pos pos
                   :w (if (less? txt) -1 1))))
        (if (num?  txt) (push new nums) (push new syms))
        (if (goal? txt) (push new y)    (push new x))
        (push new all)
        (if (klass? txt)
          (setf klass new))))))

(defmethod row ((i cols) rows cells)
  (make-instance 
    'row 
    :_rows rows
    :cells (mapcar #'add (? i all) cells)))

;;; rows ----------------------------------------

(defmethod add ((i rows) lst)
 "simply add one `lst` of data to `i`"
  (with-slots (all cols) i
    ;(format t ">>~a~%" lst)
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


