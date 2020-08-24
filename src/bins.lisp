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
(defthing myall   thing (my 0) (all 0))
 
(defthing bin thing 
  (col)
  (goal)
  (score 0)
  (yes  (make-instance 'myall))
  (no   (make-instance 'myall))
  (lo   (make-instance 'posval))
  (hi   (make-instance 'posval)))

;;; A bin is a subrange within a column --------- 
(defmethod initialize-instance :around ((i bin) &key goal x yes no)
  (call-next-method 
    i 
    :x x
    :goal goal
    :yes (make-instance 'myall :my 0 :all yes)
    :no  (make-instance 'myall :my 0 :all no)))

(defmethod selects ((i bin) row)
  "Does this `row` have a value that falls into this bin?"
  (within (? i lo val)
          (elt (? row cells) (? i col))
          (? i hi val)))

(defmethod score ((i bin) all)
  "Updates this bin's `score` for how well it predicts 
  for the class. If the target and everything else
  occurs at frequency my1 my2 and in this range 
  see the target class at frequency al1 all2, then
  `n= all1+all2` and `best = b = my1/n`, and `rest=r=m2/n`
  and this range's score is `b^2/(b+r)`."
  (let* ((eps  0.000001)
         (my1  (? i yes my))
         (my2  (? i no  my))
         (all1 (? i yes all))
         (all2 (? i no  all))
         (n    (+ all1 all2))
         (b    (/ my1     (+ eps all1)))
         (r    (/ my2     (+ eps all2)))
         (s    (/ (* b b) (+ eps b r))))
    (if (< s 0.01) 0 (float s))))

(defmethod join ((i bin) (j bin))
  "Return a new range that stretches across `i` and `j`."
  (let ((k (make-instance 'bin 
              :col (? i x) :goal (? i goal) 
              :yes (? i yes all) :no (? i no all))))
     (setf (? k lo pos) (? i lo pos)
           (? k hi pos) (? j hi pos)
           (? k yes my) (+ (? i yes my) (?i j yes my))
           (? k no  my) (+ (? i no  my) (?i j no  my)))
     k))

(defmethod add ((i bin) y )
  "Update how often a bin sees the target class (or otherwise)."
  (if (equalp y (? i goal)) 
    (incf (? i yes my))
    (incf (? i no my)))
  (setf (? i score) (score i))
  i)

;;; symbolic columns ----------------------------
(defun syms2bins (lst &key yes no goal x y)
  (let ((bins (make-hash-table :test 'equalp)))
    (dolist (row lst (hash-values bins))
      (let ((xx  (elt (? row cells) x))
            (yy  (elt (? row cells) y)))
        (unless (ignore? xx)
          (unless (gethash xx bins)
            (setf (gethash xx bins) 
                  (make-instance 
                    'bin :col x :goal goal :yes yes :no no)))
          (add (gethash xx bins) yy))))))

