(defun first-index (str delim)
	(dotimes (i (length str))
		(if (string= (char str i) delim)
			  (return-from first-index i)
		)
	)
	(return-from first-index -1)
)

(defun ktoi (k)
	(cond
		((string= k "byr") 0)
		((string= k "iyr") 1)
		((string= k "eyr") 2)
		((string= k "hgt") 3)
		((string= k "hcl") 4)
		((string= k "ecl") 5)
		((string= k "pid") 6)
		((string= k "cid") 7)
	)
)

(defun set-nth (arr n value)
	(fill (copy-seq arr) value :start n :end (1+ n))
)

(defun is-valid (pp)
	;(format t "checking ~A~%" pp)
	(and 
		(string/= (nth 0 pp) nil)
		(string/= (nth 1 pp) nil)
		(string/= (nth 2 pp) nil)
		(string/= (nth 3 pp) nil)
		(string/= (nth 4 pp) nil)
		(string/= (nth 5 pp) nil)
		(string/= (nth 6 pp) nil)
		;(string/= (nth 7 pp) nil) ;ignore cid
	)
)

(defun read-file (path)
	(setq valids 0)
	; line is not visible outside the loop so I keep track whether the last
	; record was evaluated using this variable:
	(setq evald t)
	(setq pp (list nil nil nil nil nil nil nil nil))
	(let ((in (open path :if-does-not-exist nil)))
		(when in 
			(loop for line = (read-line in nil)
						while line do 
						(if 
							(string= line "")
							(progn
								(if (is-valid pp)
										(setq valids (1+ valids))
										(format t "~A is invalid~%" pp )
								)
								(setq pp (list nil nil nil nil nil nil nil nil))
								(setq evald t)
							)
							(progn
								(setq x 0)
								(loop while (/= x -1)
									do
										(setq x (first-index line " "))
										(setq dpos (first-index line ":"))
										(setq kid (ktoi (subseq line 0 dpos)))
										(if (= x -1)
											(setq pp (set-nth pp kid (subseq line (+ dpos 1))))
											(setq pp (set-nth pp kid (subseq line (+ dpos 1) x)))
										)
										(setq line (subseq line (+ x 1)))
								)
								(setq evald nil)
							)
						)
				)
		)
	(if (not evald) ; we ended on a non-empty line, eval the last record
			(if (is-valid pp)
					(setq valids (1+ valids))
			)
	)
	(close in)
	)
	valids
)

(format t "Found ~D valid passports~%" (read-file "in1.txt"))
(format t "Found ~D valid passports~%" (read-file "input"))
;(ktoi "byr")
;(format t "r is @ ~D~%" (first-index "qwertz" "r"))
;(format t "q is @ ~D~%" (first-index "qwertz" "q"))
;(format t "a is @ ~D~%" (first-index "qwertz" "a"))
