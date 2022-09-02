(declaim (optimize (speed 3) (debug 0) (safety 0)))

(defconstant MAX-N 440000000)

(declaim (type (simple-array fixnum) cache))
(defvar cache (make-array 10 :element-type 'fixnum))
(setf (aref cache 0) 0)
(loop :for i :from 1 :to 9
      :do (setf (aref cache i) (expt i i)))

(defun munchausenp (num)
  (declare (type fixnum num))
  (loop :with n fixnum = num :and digit fixnum
        :do (setf (values n digit) (floor n 10))
        :sum (aref cache digit) :into total fixnum
        :while (> n 0)
        :if (> total num) return nil
        :finally (return (= total num))))

(defun main ()
  (dotimes (i MAX-N)
    (if (munchausenp i)
      (progn
        (write i)
        (terpri)))))

(main)
