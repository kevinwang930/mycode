(+ (read) (+ (let ((v (+ 2 (let ((x 6)) x)))) (+ (let ((v 2)) v) v)) (+ 2 (read))))
