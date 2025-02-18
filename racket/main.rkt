#lang racket/base

(require (for-syntax racket/base)
         (only-in racket/fixnum for/fxvector)
         racket/require
         (filtered-in
          (lambda (name)
            (regexp-replace #rx"^unsafe-" name ""))
          racket/unsafe/ops))

(define n 440000000)

(define cache
  (for/fxvector ([i (in-range 10)])
    (if (fx= i 0)
        0
        (expt i i))))

(define (munchausen? number)
  (let loop ([n number]
             [total 0])
    (cond
      [(fx= n 0)
       (fx= total number)]
      [(fx> total number)
       #f]
      [else
       (define q (fxquotient n 10))
       (define r (fxremainder n 10))
       (loop q (fx+ total (fxvector-ref cache r)))])))

(module+ main
  (for ([i (in-range n)])
    (when (munchausen? i)
      (display i)
      (newline))))
