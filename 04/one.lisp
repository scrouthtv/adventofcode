(defun first-index (str delim)
	(dotimes (i (length str))
		(if (string= (char str i) delim)
			  (return-from first-index i)
		)
	)
	-1
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

(defun num-in-range (num lowest highest)
	(and
		(>= num lowest)
		(<= num highest)
	)
)

(defun field-is-in-range (pp field lowest highest)
	(setq i (ktoi field))
	(setq val (read-from-string (nth i pp)))
	(num-in-range val lowest highest)
)

(defun is-valid-height (pp)
	(setq hgt (nth (ktoi "hgt") pp))
	(setq unit (subseq hgt (- (length hgt) 2)))
	(setq value (read-from-string (subseq hgt 0 (- (length hgt) 2))))
	(cond
		((string= unit "cm") (num-in-range value 150 193))
		((string= unit "in") (num-in-range value 59 76))
		(t nil)
	)
)

(defun is-valid-hcl (pp)
	(setq hcl (nth (ktoi "hcl") pp))
	(and 
		(= (length hcl) 7)
		(string= (subseq hcl 0 1) "#")
		(all-in-string "0123456789abcdef" (subseq hcl 1 7))
	)
)

(setq valid-ecls '("amb" "blu" "brn" "gry" "grn" "hzl" "oth"))
(defun is-valid-ecl (pp)
	(setq ecl (nth (ktoi "ecl") pp))
	(is-in-list valid-ecls ecl)
)

(defun is-in-list (l v)
	(dotimes (i (length l))
		(if (string= (nth i l) v)
				(return-from is-in-list t)
		)
	)
	nil
)

(defun is-valid-pid (pp)
	(setq pid (nth (ktoi "pid") pp))
	(and 
		(= (length pid) 9)
		(all-in-string "0123456789" pid)
	)
)

(defun all-in-string (valid str)
	(dotimes (i (length str))
		(if (not (is-in-string valid (subseq str i (+ i 1))))
				(return-from all-in-string nil)
		)
	)
	t
)

(defun is-in-string (s ch)
	(dotimes (i (length s))
		(if (string= (subseq s i (+ i 1)) ch)
				(return-from is-in-string t))
	)
	nil
)

(defun is-more-valid (pp)
	(and
		(is-valid pp)
		(field-is-in-range pp "byr" 1920 2002)
		(field-is-in-range pp "iyr" 2010 2020)
		(field-is-in-range pp "eyr" 2020 2030)
		(is-valid-height pp)
		(is-valid-hcl pp)
		(is-valid-ecl pp)
		(is-valid-pid pp)
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
								(if (is-more-valid pp)
										(setq valids (1+ valids))
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
			(if (is-more-valid pp)
					(setq valids (1+ valids))
			)
	)
	(close in)
	)
	valids
)

(format t "Found ~D valid passports~%" (read-file "in1.txt"))
(format t "Found ~D valid passports~%" (read-file "allinv.txt"))
(format t "Found ~D valid passports~%" (read-file "allval.txt"))
(format t "Found ~D valid passports~%" (read-file "input"))
;(format t "Is amb in list: [ amb blu brn gry ]: ~A~%"
				;(is-in-list '("amb" "blu" "brn" "gry") "amb"))
;(format t "Is brn in list: [ amb blu brn gry ]: ~A~%"
				;(is-in-list '("amb" "blu" "brn" "gry") "brn"))
;(format t "Is gry in list: [ amb blu brn gry ]: ~A~%" 
				;(is-in-list '("amb" "blu" "brn" "gry") "gry"))
;(format t "Is gr in list: [ amb blu brn gry ]: ~A~%" 
				;(is-in-list '("amb" "blu" "brn" "gry") "gr"))
;(format t "16842 all numbers: ~A~%" (all-in-string "0123456789" "16842"))
;(format t "16842a all numbers: ~A~%" (all-in-string "0123456789" "16842a"))
;(format t "Found ~D valid passports~%" (read-file "input"))
;(ktoi "byr")
;(format t "r is @ ~D~%" (first-index "qwertz" "r"))
;(format t "q is @ ~D~%" (first-index "qwertz" "q"))
;(format t "a is @ ~D~%" (first-index "qwertz" "a"))
