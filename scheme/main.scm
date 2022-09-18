;(define MAX-N 10000)
(define MAX-N 440000000)

(define cache
  (list->vector
    (cons
      0
      (let loop ((i 1))
        (if (> i 10)
          '()
          (cons (expt i i)
                (loop (+ i 1))))))))

(define (munchausen? num)
  (let loop ((n num)
             (total 0))
    (cond ((> total num) #f)
          ((> n 0)
            (loop (quotient n 10)
                  (+ total
                     (vector-ref cache
                                 (remainder n 10)))))
          (else (= num total)))))

(let loop ((i 0))
  (when (munchausen? i)
    (display i)
    (newline))

  (when (< i MAX-N)
    (loop (+ i 1))))
