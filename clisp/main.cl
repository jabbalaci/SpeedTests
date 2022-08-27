(setq cache (make-array '(10)))
(setf (aref cache 0) 0)
(loop :for i :from 1 :to 9
      :do (setf (aref cache i) (expt i i)))

(defun munchausenp (num)
  (setq n num)
  (setq total 0)
  (loop :for n = num :then (floor n 10)
        :for digit = (mod n 10)
        :while (> n 0)
        :sum (aref cache digit) :into total
        :if (> total num) return nil
        :finally (return (= total num))))

(dotimes (i 440000000)
  (if (munchausenp i)
    (progn
      (write i)
      (terpri))))
