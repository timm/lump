; vim: noai:ts=2:sw=2:et: 
(load "got")
(got "rows")

(defthing posval thing (pos 0) (val))

(defthing bin thing 
  (x)
  (score 0)
  (ys (make-hash-table :test 'equalp))
  (lo (make-instance 'posval))
  (hi (make-instance 'posval)))

(defmethod within ((x number) (y number) (z number))
  (<= x y z))

(defmethod within ((x string) (y string) (z string))
  (and (string-equal x y)
       (string-equal y z)))

(defmethod selects ((i bin) row)
  (within (? i lo val)
          (elt (? row cells) (? i x))
          (? i hi val)))

(defmethod score ((i bin) all &aux (e 0.0000001))
  (let ((yes (/ (gethash 1 (? i ys) 0)
                (+ e (gethash 1 all 0))))
         (no (/ (gethash 0 (? i ys) 0)
                (+ e (gethash 0 all 0))))
         (tmp (float (/ (* yes yes) i
                     (+ e yes no)))))
   (setf (? i score)
         (if (< tmp 0.01) 0 tmp))
   i))

(defmethod merge ((i bin) (j bin))
  (let ((k (make-instance :x (? i x))))
     (setf (? k lo pos) (? i lo pos)
           (? k hi pos) (? j hi pos))
     (do-hash (key val (? i ys))
       (setf (gethash key (? k ys)) val))
     (do-hash (key val (? j ys))
       (incf (gethash key (? k ys 0)) val))
     k))

(defmethod add2 ((i bin) y want)
  (incf (gethash (if (eql y want) 1 0) 
                 (? i ys) 
                 0)))

(defun syms2bins (lst &keys goal (x 0) (y (1- (length lst))))
   (let (out
         (bins (make-hash-table :test #'equalp)) 
         (all (make-instance 'bin :x x)))
      (dolist (row lst)
        (let ((xx  (elt (? row cells) x))
              (yy  (elt (? row cells) y)))
          (unless (ignore? xx)
            (unless (gethash xx bins)
               (setf (gethash xx bins)
                     (make-instance 'bin :x x ))))
           (add2 all goal)
           (add2 (gethas xx bins))))
      (do-hash (k v bins out)
         (push (score v all) out))))
      
