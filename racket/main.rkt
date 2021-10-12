#lang racket

(define n 440000000)

(define cache
  (for/vector ([i 10])
    (if (= i 0)
      0
      (expt i i))))

(define (munchausen? number)
  (define (loop n total)
    (cond
      ((= n 0)
        (= total number))
      ((> total number)
        #f)
      (else
        (let-values ([(q r) (quotient/remainder n 10)])
          (loop q (+ total (vector-ref cache r)))))))
  (loop number 0))

(for ([i n])
  (when (munchausen? i)
    (display i)
    (newline)))
