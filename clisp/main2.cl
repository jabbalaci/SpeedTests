(declaim (optimize (speed 3) (debug 0) (safety 0)))

(defconstant MAX-N 440000000)

(let ((cache (make-array 10 :element-type '(unsigned-byte 64) :initial-element 0)))
  (declare (type (simple-array (unsigned-byte 64)) cache))
  (loop :for i :from 1 :to 9 :do
       (setf (aref cache i) (expt i i)))
  (defun munchausenp (num)
    (declare (type (unsigned-byte 64) num))
    (labels ((check (n total)
               (declare (type (unsigned-byte 64) n total))
               (cond ((> total num) nil)
                     ((> n 0)
                      (multiple-value-bind (n digit)
                          (floor n 10)
                        (check n (+ total (aref cache digit)))))
                     (t (= total num)))))
      (declare (inline check))
      (check num 0))))

(defun main ()
  (dotimes (i MAX-N)
    (when (munchausenp i)
      (write i)
      (terpri))))

(main)
