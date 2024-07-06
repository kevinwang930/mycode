#lang racket
(require 2htdp/image (except-in 2htdp/universe
                                left right))

;lazy version of dice game
;constant

(define PLAYER# 2)
(define DICE# 3)
(define BOARD 5)
(define GRID (* BOARD BOARD))
(define INIT-PLAYER 0)
(define INIT-SPARE-DICE 0)
(define AI-DEPTH 4)
(define AI 1)

;graphical constant
(define DICE-OFFSET 6)
(define SIDE 75)
(define OFFSET0 (* 2 SIDE))
(define ROTATION 30)
(define HEX 6)
(define (hexagon color)
  (rotate ROTATION (regular-polygon SIDE HEX "solid" color)))
(define X-OFFSET (image-width (hexagon "black")))
(define Y-OFFSET (* (image-height (hexagon "black")) 3/4))
(define TEXT-SIZE 25)
(define TEXT-COLOR "black")
(define INSTRUCT 
  "← and → to move among territories, <enter> to mark, <d> to unmark, and <p> to pass")
(define INSTRUCTIONS (text INSTRUCT TEXT-SIZE TEXT-COLOR))
(define WIDTH (+ (image-width INSTRUCTIONS) 50))
(define HEIGHT 600)

(define COLORS 
  (list (make-color 255 0 0 100) 
        (make-color 0 255 0 100) 
        (make-color 0 0 255 100)))
(define FOCUS (rotate ROTATION (regular-polygon SIDE 6 "outline" "black")))

(define D1 (bitmap "graphics/dice1.png"))
(define D2 (bitmap "graphics/dice2.png"))
(define D3 (bitmap "graphics/dice3.png"))
(define D4 (bitmap "graphics/dice4.png"))
(define IMG-LIST (list D1 D2 D3 D4)) 
(define (PLAIN)
  (define iw (image-width INSTRUCTIONS))
  (define bw (* SIDE 2 BOARD))
  (set! WIDTH  (+ (max iw bw) 50))
  (set! HEIGHT (+ (* SIDE 2 BOARD) 50))
  (empty-scene WIDTH HEIGHT))
(define (ISCENE)
  (define mt (PLAIN))
  (when (or (> (image-width mt) 1280) (> (image-height mt) 800))
    (error 'scene "it is impossible to draw a ~s x ~s game scene for a 1280 x 800 laptop screen" (image-width mt) (image-height mt)))
  (place-image INSTRUCTIONS (* .5 WIDTH) (* .9 HEIGHT) mt))
(define AI-TURN "It's the Mighty AI's turn")
(define YOUR-TURN "It's your turn")
(define INFO-X-OFFSET 100)
(define INFO-Y-OFFSET 50)

;game structure
; board is a list of territories
(struct dice-world (src board gt) #:transparent)
(struct territory (index player dice x y) #:transparent)
;(struct game (board player moves) #:transparent)
(define-values (game game? game-board game-player game-moves)
  (let ()
    (struct game (board player delayed-moves) #:transparent)
    (values game
            game?
            game-board
            game-player
            (lambda (g) ((game-delayed-moves g))))))
(struct move (action gt) #:transparent)

(define (territory-set-dice t dice)
  (territory (territory-index t) (territory-player t) dice (territory-x t) (territory-y t)))
(define (territory-set-player t player)
  (territory (territory-index t) player (territory-dice t) (territory-x t) (territory-y t)))

;main procedure
(define (roll-the-dice)
  (big-bang (create-world-of-dice-and-doom)
    (on-key interact-with-board)
    (to-draw draw-dice-world)
    (stop-when no-more-moves-in-world?
               draw-end-of-dice-world)))

;create world
(define (create-world-of-dice-and-doom)
  (define board (territory-build))
  (define gamet (game-tree board INIT-PLAYER INIT-SPARE-DICE))
  (define new-world (dice-world #f board gamet))
  (if (no-more-moves-in-world? new-world)
      (create-world-of-dice-and-doom)
      new-world))


;create the board
(define (territory-build)
  (for/list ([n (in-range GRID)])
    (territory n (modulo n PLAYER#) (dice) (get-x n) (get-y n))))
(define (dice)
  (add1 (random DICE#)))
(define (get-x n)
  (+ OFFSET0
     (if (odd? (get-row n)) 0 (/ X-OFFSET 2))
     (* X-OFFSET (modulo n BOARD))))
(define (get-y n)
  (+ OFFSET0 (* Y-OFFSET (get-row n))))
(define (get-row pos)
  (quotient pos BOARD))

;create game tree
(define (game-tree board player dice)
  (define (attacks board)
    (for*/list ([src board]
                [dst (neighbors (territory-index src))]
                #:when (attackable? board player src dst))
      (define from (territory-index src))
      (define dice (territory-dice src))
      (define newb (execute board player from dst dice))
      (define more (lambda () (cons (passes newb) (attacks newb))))
      (move (list from dst) (game newb player more))))
  (define (passes board)
    (define-values (new-dice newb) (distribute board player dice))
    (move '() (game-tree newb (switch player) new-dice)))
  (game board player (lambda () (attacks board))))



;moves judgement
(define (no-more-moves-in-world? w)
  (define tree (dice-world-gt w))
  (define board (dice-world-board w))
  (define player (game-player tree))
  (or (no-more-moves? tree)
      (for/and ((t board))
        (= (territory-player t) player))))

(define (no-more-moves? tree)
  (define moves (game-moves tree))
  (null? moves))



;input handling 
(define (interact-with-board w k)
  (cond [(key=? "left" k)
         (refocus-board w left)]
        [(key=? "right" k)
         (refocus-board w right)]
        [(key=? "p" k)
         (pass w)]
        [(key=? "\r" k)
         (mark w)]
        [(key=? "d" k)
         (unmark w)]
        [else w]))
(define (refocus-board w direction)
  (define source (dice-world-src w))
  (define board (dice-world-board w))
  (define tree (dice-world-gt w))
  (define player (game-player tree))
  (define (owner? tid)
    (if source (not (= tid player)) (= tid player)))
  (define new-board (rotate-until owner? board direction))
  (dice-world source new-board tree))
(define (rotate-until owned-by board rotate)
  (define next-list (rotate board))
  (if (owned-by (territory-player (first next-list)))
      next-list
      (rotate-until owned-by next-list rotate)))
(define (right l)
  (append (rest l) (list (first l))))
(define (left l)
  (define rl (reverse l))
  (cons (first rl)
          (reverse (rest rl))))

#;(define (pass w)
  (define m (find-move (game-moves (dice-world-gt w)) '()))
  (cond [(not m) w]
        [else (dice-world #f (game-board m) m)]))
(define (find-move moves action)
  (define m
    (findf (lambda (m) (equal? (move-action m) action)) moves))
  (and m (move-gt m)))
(define (mark w)
  (define tree (dice-world-gt w))
  (define board (dice-world-board w))
  (define source (dice-world-src w))
  (define focus (territory-index (first board)))
  (if source
      (attacking w source focus)
      (dice-world focus board tree)))
(define (attacking w source target)
  (define feasible (game-moves (dice-world-gt w)))
  (define attack (list source target))
  (define next (find-move feasible attack))
  (if next (dice-world #f (game-board next) next) w))
(define (unmark w)
  (dice-world #f (dice-world-board w) (dice-world-gt w)))




;rendering dice world

(define (draw-end-of-dice-world w)
  (define board (dice-world-board w))
  (define message (text (won board) TEXT-SIZE TEXT-COLOR))
  (define background (add-board-to-scene w (PLAIN)))
  (overlay message background))
(define (draw-dice-world w)
  (add-player-info
   (game-player (dice-world-gt w))
   (add-board-to-scene w (ISCENE))))

(define (add-player-info player s)
  (define str (whose-turn player))
  (define txt (text str TEXT-SIZE TEXT-COLOR))
  (place-image txt (- WIDTH INFO-X-OFFSET) INFO-Y-OFFSET s))
(define (whose-turn player)
  (if (= player AI) AI-TURN YOUR-TURN))

(define (add-board-to-scene w s)
  (define board (dice-world-board w))
  (define player (game-player (dice-world-gt w)))
  (define focus? (dice-world-src w))
  (define trtry1 (first board))
  (define p-focus (territory-player trtry1))
  (define t-image (draw-territory trtry1))
  (define image (draw-focus focus? p-focus player t-image))
  (define base-s (add-territory trtry1 image s))
  (for/fold ([s base-s]) ([t (rest board)])
    (add-territory t (draw-territory t) s)))
(define (draw-territory t)
  (define color (color-chooser (territory-player t)))
  (overlay (hexagon color) (draw-dice (territory-dice t))))
(define (draw-focus marked? p-in-focus p t-image)
  (if (or (and (not marked?) (= p-in-focus p))
          (and marked? (not (= p-in-focus p))))
      (overlay FOCUS t-image)
      t-image))
(define (add-territory t image scene)
  (place-image image (territory-x t) (territory-y t) scene))
(define (color-chooser n)
  (list-ref COLORS n))
(define (draw-dice n)
  (define first-dice (get-dice-image 0))
  (define height-dice (image-height first-dice))
  (for/fold ([s first-dice]) ([i (- n 1)])
    (define dice-image (get-dice-image (+ i 1)))
    (define y-offset (* height-dice (+ 0.5 (* i 0.25))))
    (overlay/offset s 0 y-offset dice-image)))

(define (get-dice-image i)
  (list-ref IMG-LIST (modulo i (length IMG-LIST))))




(define (switch player)
  (modulo (add1 player) PLAYER#))

(define (distribute board player spare-dice)
  (for/fold ([dice spare-dice] [new-board '()]) ([t board])
    (if (and (= (territory-player t) player)
             (< (territory-dice t) DICE#)
             (not (zero? dice)))
        (values (- dice 1) (cons (add-dice-to t) new-board))
        (values dice (cons t new-board)))))

(define (add-dice-to t)
  (territory-set-dice t (add1 (territory-dice t))))

#;(define (neighbors n)
  (list upper-right
        bottom-right
        upper-left
        bottom-left
        right
        left))

(define (add b x)
  (if b empty (list x)))

;neighbors judgement
(define (neighbors pos)
  (define top? (< pos BOARD))
  (define bottom? (= (get-row pos) (sub1 BOARD)))
  (define even-row? (zero? (modulo (get-row pos) 2)))
  (define right? (zero? (modulo (add1 pos) BOARD)))
  (define left? (zero? (modulo pos BOARD)))
  (if even-row?
      (even-row pos top? bottom? right? left?)
      (odd-row pos top? bottom? right? left?)))

(define (even-row pos top? bottom? right? left?)
  (append (add (or top? right?) (add1 (- pos BOARD)))
          (add (or bottom? right?) (add1 (+ pos BOARD)))
          (add top? (- pos BOARD))
          (add bottom? (+ pos BOARD))
          (add right? (add1 pos))
          (add left? (sub1 pos))))

(define (odd-row pos top? bottom? right? left?)
  (append (add (or top? right?) (- pos BOARD))
          (add (or bottom? right?) (+ pos BOARD))
          (add top? (sub1 (- pos BOARD)))
          (add bottom? (sub1 (+ pos BOARD)))
          (add right? (add1 pos))
          (add left? (sub1 pos))))
;attackbale judgement
(define (attackable? board player src dst)
  (define dst-t
    (findf (lambda (t) (= (territory-index t) dst)) board))
  (and dst-t
       (= (territory-player src) player)
       (not (= (territory-player dst-t) player))
       (> (territory-dice src) (territory-dice dst-t))))
;attack execution
(define (execute board player src dst dice)
  (for/list ([t board])
    (define idx (territory-index t))
    (cond [(= idx src) (territory-set-dice t 1)]
          [(= idx dst)
           (define s (territory-set-dice t (- dice 1)))
           (territory-set-player s player)]
          [else t])))

(define (won board)
  (define-values (best-score w) (winners board))
  (if (cons? (rest w)) "It's a tie" "You won."))

(define (winners board)
  (for/fold ([best 0] [winners '()]) ([p PLAYER#])
    (define p-score (sum-territory board p))
    (cond [(> p-score best) (values p-score (list p))]
          [(< p-score best) (values best winners)]
          [(= p-score best) (values best (cons p winners))])))

(define (sum-territory board player)
  (for/fold ([result 0]) ([t board])
    (if (= (territory-player t) player)
        (+ result 1)
        result)))

;AI code
(define (rate-moves tree depth)
  (for/list ([move (game-moves tree)])
    (list move (rate-position (move-gt move) (- depth 1)))))
(define (rate-position tree depth)
  (cond [(or (= depth 0) (no-more-moves? tree))
         (define-values (best w) (winners (game-board tree)))
         (if (member AI w) (/ 1 (length w)) 0)]
        [else
         (define ratings (rate-moves tree depth))
         (apply (if (= (game-player tree) AI) max min)
                (map second ratings))]))

(define (the-ai-plays tree)
  (define ratings (rate-moves tree AI-DEPTH))
  (define the-move (first (argmax second ratings)))
  (define new-tree (move-gt the-move))
  (if (= (game-player new-tree) AI)
      (the-ai-plays new-tree)
      new-tree))

(define (pass w)
  (define m (find-move (game-moves (dice-world-gt w)) '()))
  (cond [(false? m) w]
        [(or (no-more-moves? m) (not (= (game-player m) AI)))
          (dice-world #f (game-board m) m)]
        [else
         (define ai (the-ai-plays m))
         (dice-world #f (game-board ai) ai)]))









;test

;(draw-dice 3)
(define board (territory-build))
board
;(dice-world #f board (game-tree board INIT-PLAYER INIT-SPARE-DICE))
#|
(define (attacks board player)
    (for*/list ([src board]
                [dst (neighbors (territory-index src))]
                #:when (attackable? board player src dst))
      (define from (territory-index src))
      (define dice (territory-dice src))
      (define newb (execute board player from dst dice))
      (define more (cons (passes newb player) (attacks newb player)))
      (move (list from dst) (game newb player more))))
  (define (passes board player dice)
    (define-values (new-dice newb) (distribute board player dice))
    (move '() (game-tree newb (switch player) new-dice)))
|#
;(attacks board 0)




















