"Discretizing and ranking columns of data."
; vim: noai:ts=2:sw=2:et: 
(load "got")
(got "misc" "rows")

"A `bin` is some subrange within the values of a column.
These are defined by the the column number
the refer too, and the min and max value in each bin.
These can also be e ranked according to how well they
predict for some target class."

(defthing posval  thing (pos 0) (val 0))
 
(defthing bin thing 
  (col)
  (score 0)
  (ys (make-hash-table :test 'equalp))
  (lo (makeinstance 'posval))
  (hi (makeinstance 'posval)))

;;; A bin is a subrange within a column --------- 
(defmethod selects ((i bin) row)
  "Does this `row` have a value that falls into this bin?"
  (within (? i lo val)
          (elt (? row cells) (? i col))
          (? i hi val)))

(defmethod score ((i bin) all &aux (e 0.0000001))
  "Updates this bin's `score` for how well it predicts 
  for the class. If the target and everything else
  occurs at frequency n1 n2 and in this range we
  see the target class at frequency m1 m2, then
  `best = b = m1/(n1+n2)`, and `rest=r=m2/(n1+n2)`
  and this range's score is `b^2/(b+r)`."
  (let* ((yes   (/   (gethash 1 (? i   ys) 0)
                (+ e (gethash 1 (? all ys) 0))))
         (no    (/   (gethash 0 (? i   ys) 0)
                (+ e (gethash 0 (? all ys) 0))))
         (tmp  (float (/ (* yes yes) 
                         (+ e yes no)))))
   (setf (? i score)
         (if (< tmp 0.01) 0 tmp))
   i))

(defmethod join ((i bin) (j bin))
  "Return a new range that stretches across both `i` and `j`."
  (let ((k (make-instance :x (? i x))))
     (setf (? k lo pos) (? i lo pos)
           (? k hi pos) (? j hi pos))
     (do-hash (key val (? i ys))
       (setf (gethash key (? k ys)) val))
     (do-hash (key val (? j ys))
       (incf (gethash key (? k ys 0)) val))
     k))

(defmethod add2 ((i bin) y want)
  "Update how often a bin sees the target class (or otherwise)."
  (let ((k (if (equalp y want) 1 0)))
    (incf (gethash k (? i ys) 0))))

;;; symbolic columns ----------------------------
(defun syms2bins (lst &key goal (x 0) (y (1- (length lst))))
   (let (out
         (bins (make-hash-table :test #'equalp)) 
         (all  (make-instance 'bin :x x)))
      (dolist (row lst)
        (let ((xx  (elt (? row cells) x))
              (yy  (elt (? row cells) y)))
          (unless (ignore? xx)
            (unless (gethash xx bins)
               (setf (gethash xx bins)
                     (make-instance 'bin :x x ))))
           (add2 all yy goal)
           (add2 (gethash xx bins) yy goal)))
      (do-hash (k v bins out) 
               (push (score v all) out))))

