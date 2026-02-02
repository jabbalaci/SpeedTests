;(define MAX-N 10000)
(define MAX-N 440000000)

(define cache
  (list->fxvector
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
    (cond ((fx> total num) #f)
          ((fx> n 0)
            (loop (fxquotient n 10)
                  (fx+ total
                     (fxvector-ref cache
                                 (fxremainder n 10)))))
          (else (fx= num total)))))

(let loop ((i 0))
  (when (munchausen? i)
    (display i)
    (newline))
  (when (fx< i MAX-N)
    (loop (fx+ i 1))))
