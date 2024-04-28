#lang racket
(define WIDTH 100)
(define HEIGHT 200)
(define X-CENTER (quotient WIDTH 2))
(define y-CENTER (quotient HEIGHT 2))
(unless (> HEIGHT 0)
  (error 'guess-my-number "HEIGHT may not be negative"))
(define SQR-COLOR "red")
(define SQR-SIZE 10)
(define (draw-square img x y)
  (place-image (square SQR-SIZE "solid" SQR-COLOR)
               x y
               img))


