; Лабораторна робота № 5 - Індивідуальне завдання (Варіант № 4)
; Обчислення суми площ та суми периметрів геометричних фігур

; ==================== ШАБЛОНИ (deftemplate) ====================
(deftemplate square
   (slot id)
   (slot side-length (type NUMBER))
)

(deftemplate rectangle
   (slot id)
   (slot width (type NUMBER))
   (slot height (type NUMBER))
)

(deftemplate circle
   (slot id)
   (slot radius (type NUMBER))
)

; Допоміжні шаблони для накопичення сум та обліку оброблених фігур
(deftemplate total-area
   (slot value (type NUMBER) (default 0))
)

(deftemplate total-perimeter
   (slot value (type NUMBER) (default 0))
)

(deftemplate area-processed
   (slot id)
)

(deftemplate perimeter-processed
   (slot id)
)

; ==================== ТЕСТОВІ ФАКТИ (deffacts) ====================
(deffacts test-8-8
   (square (id A) (side-length 3))
   (square (id B) (side-length 5))
   (rectangle (id C) (width 5) (height 7))
   (circle (id D) (radius 2))
   (circle (id E) (radius 6))
   (total-area (value 0))
   (total-perimeter (value 0))
)

; ==================== ПРАВИЛА ДЛЯ СУМИ ПЛОЩ ====================
(defrule area-square
   (declare (salience 50))
   (square (id ?id) (side-length ?a))
   (not (area-processed (id ?id)))
   ?t <- (total-area (value ?sum))
   =>
   (bind ?s (* ?a ?a))
   (modify ?t (value (+ ?sum ?s)))
   (assert (area-processed (id ?id)))
   (printout t "Ploshcha kvadrata " ?id " = " ?s crlf)
)

(defrule area-rectangle
   (declare (salience 50))
   (rectangle (id ?id) (width ?w) (height ?h))
   (not (area-processed (id ?id)))
   ?t <- (total-area (value ?sum))
   =>
   (bind ?s (* ?w ?h))
   (modify ?t (value (+ ?sum ?s)))
   (assert (area-processed (id ?id)))
   (printout t "Ploshcha pryamokutnyka " ?id " = " ?s crlf)
)

(defrule area-circle
   (declare (salience 50))
   (circle (id ?id) (radius ?r))
   (not (area-processed (id ?id)))
   ?t <- (total-area (value ?sum))
   =>
   (bind ?pi 3.14159265)
   (bind ?s (* ?pi (* ?r ?r)))
   (modify ?t (value (+ ?sum ?s)))
   (assert (area-processed (id ?id)))
   (printout t "Ploshcha kola " ?id " = " ?s crlf)
)

; ==================== ПРАВИЛА ДЛЯ СУМИ ПЕРИМЕТРІВ ====================
(defrule perim-square
   (declare (salience 40))
   (square (id ?id) (side-length ?a))
   (not (perimeter-processed (id ?id)))
   ?t <- (total-perimeter (value ?sum))
   =>
   (bind ?p (* 4 ?a))
   (modify ?t (value (+ ?sum ?p)))
   (assert (perimeter-processed (id ?id)))
   (printout t "Perymetr kvadrata " ?id " = " ?p crlf)
)

(defrule perim-rectangle
   (declare (salience 40))
   (rectangle (id ?id) (width ?w) (height ?h))
   (not (perimeter-processed (id ?id)))
   ?t <- (total-perimeter (value ?sum))
   =>
   (bind ?p (* 2 (+ ?w ?h)))
   (modify ?t (value (+ ?sum ?p)))
   (assert (perimeter-processed (id ?id)))
   (printout t "Perymetr pryamokutnyka " ?id " = " ?p crlf)
)

(defrule perim-circle
   (declare (salience 40))
   (circle (id ?id) (radius ?r))
   (not (perimeter-processed (id ?id)))
   ?t <- (total-perimeter (value ?sum))
   =>
   (bind ?pi 3.14159265)
   (bind ?p (* 2 (* ?pi ?r)))
   (modify ?t (value (+ ?sum ?p)))
   (assert (perimeter-processed (id ?id)))
   (printout t "Dovzhyna kola " ?id " = " ?p crlf)
)

; ==================== ПІДСУМКОВЕ ВИВЕДЕННЯ РЕЗУЛЬТАТІВ ====================
(defrule print-totals
   (declare (salience 10))
   (total-area (value ?ta))
   (total-perimeter (value ?tp))
   =>
   (printout t "========================================" crlf)
   (printout t "a) Zahalna suma ploshch figur: " ?ta crlf)
   (printout t "b) Zahalna suma perymetriv figur: " ?tp crlf)
   (printout t "========================================" crlf)
)
