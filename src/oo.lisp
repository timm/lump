"Simpler OO in LISP."
; vim: ts=2 sw=2 et:
#+lump (lump "my" "macros" "os")

;;; base of all
(let ((id 0))
  (defclass thing () ((id :initform (incf id)))))

;;; define classes and slots --------------------
(defmacro defthing (x parent &rest slots)
  "Succinct class creation"
  `(defclass ,x (,parent)
     ,(loop 
        for (slot form) in slots collect 
        `(,slot 
           :initarg  ,(intern (symbol-name slot) "KEYWORD")
           :initform ,form
           :accessor ,(intern (format nil "~a-~a" x slot))))))

;;; pretty print (skipping private slots) --------
#+sbcl
(defmethod print-object ((object hash-table) stream)
  "Pretty print hash tables."
  (format stream "#HASH{~{~{(~a : ~a)~}~^ ~}}"
          (loop for key being the hash-keys of object
                using (hash-value value)
                collect (list key value))))

(defmethod print-object ((it thing) out)
  "For `thing` classes, print all public slots"
  (let ((lst (mapcar
               #'(lambda (s) (list s (slot-value it s)))
               (sort (_public-slot-names it) #'string<))))
    (format out "~a" (cons (class-name (class-of it)) lst))))

(defmethod _public-slot-names ((it thing))
  "return all thing slots that don't start with '_'"
  (remove-if
    #'(lambda (x) (and (symbolp x)
                       (equal (elt (symbol-name x) 0) #\_)))
    (mapcar #'klass-slot-definition-name (klass-slots it))))
