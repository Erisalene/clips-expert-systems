; Лабораторна робота № 4 (Варіант № 4)
; Експертна система класифікації зірок із використанням функцій користувача (deffunction)

; ==================== ШАБЛОНИ (deftemplate) ====================
(deftemplate star
   (slot name)
   (slot spectral-class (allowed-values O B A F G K M))
   (slot magnitude (type INTEGER))
   (slot distance (type NUMBER))
)

; ==================== БАЗА ЗНАНЬ (deffacts) ====================
(deffacts stars-catalog
   (star (name "Sirius")      (spectral-class A) (magnitude 1)  (distance 8.8))
   (star (name "Canopus")     (spectral-class F) (magnitude -3) (distance 98))
   (star (name "Arcturus")    (spectral-class K) (magnitude 0)  (distance 36))
   (star (name "Vega")        (spectral-class A) (magnitude 1)  (distance 26))
   (star (name "Capella")     (spectral-class G) (magnitude -1) (distance 46))
   (star (name "Rigel")       (spectral-class B) (magnitude -7) (distance 880))
   (star (name "Procyon")     (spectral-class F) (magnitude 3)  (distance 11))
   (star (name "Betelgeuse")  (spectral-class M) (magnitude -5) (distance 490))
   (star (name "Altair")      (spectral-class A) (magnitude 2)  (distance 16))
   (star (name "Aldebaran")   (spectral-class K) (magnitude -1) (distance 68))
   (star (name "Spica")       (spectral-class B) (magnitude -3) (distance 300))
   (star (name "Antares")     (spectral-class M) (magnitude -4) (distance 250))
   (star (name "Pollux")      (spectral-class K) (magnitude 1)  (distance 35))
   (star (name "Deneb")       (spectral-class A) (magnitude -7) (distance 1630))
)

; Вхідні факти запиту користувача
(deffacts user-query
   (query-class A)
   (query-magnitude 1)
)

; ==================== ФУНКЦІЇ КОРИСТУВАЧА (deffunction) ====================

; Функція 1: Визначає температурний діапазон (°F) та колір за спектральним класом
(deffunction get-temp-range (?class)
   (if (eq ?class O) then (return "bilshe 37 000 F (syniy)"))
   (if (eq ?class B) then (return "17 001 - 37 000 F (bilо-syniy)"))
   (if (eq ?class A) then (return "12 501 - 17 000 F (bilyy)"))
   (if (eq ?class F) then (return "10 301 - 12 500 F (zhovto-bilyy)"))
   (if (eq ?class G) then (return "8 001 - 10 300 F (zhovtyy)"))
   (if (eq ?class K) then (return "5 501 - 8 000 F (pomaranchevyy)"))
   (if (eq ?class M) then (return "5 500 F abo menshe (chervonyy)"))
   (return "nevidomyy diapazon")
)

; Функція 2: Перевіряє коректність вхідних даних (чи входить величина в межі [-7; 15])
(deffunction validate-input (?class ?mag)
   (if (not (member$ ?class (create$ O B A F G K M))) then
      (printout t "Pomylka: nevirnyy spektralnyy klas " ?class crlf)
      (return FALSE)
   )
   (if (or (not (integerp ?mag)) (< ?mag -7) (> ?mag 15)) then
      (printout t "Pomylka: zoryana velychyna maye buty v mezhakh [-7; 15]" crlf)
      (return FALSE)
   )
   (return TRUE)
)

; Функція 3: Форматований вивід інформації про зірку (з груповим параметром $?extra)
(deffunction print-star (?name ?class ?mag $?extra)
   (printout t " - " ?name " [klas: " ?class ", velychyna: " ?mag)
   (if (> (length$ ?extra) 0) then
      (printout t ", vidstan: " (nth$ 1 ?extra) " sv. rokiv")
   )
   (printout t "]" crlf)
)

; Функція 4: Друк заголовків етапів пошуку
(deffunction print-section-header (?step ?title)
   (printout t crlf "=== Etap " ?step ": " ?title " ===" crlf)
)

; ==================== ПРАВИЛА (defrule) ====================

; Валідація вхідних фактів із викликом функції у лівій частині (LHS)
(defrule check-query-validity
   (declare (salience 110))
   (query-class ?c)
   (query-magnitude ?m)
   (test (validate-input ?c ?m))
   =>
   (assert (query-valid))
   (printout t "Vkhidni dani korektni. Temperaturnyy diapazon klasu " ?c ": " (get-temp-range ?c) crlf)
)

; Етап 1: Пошук усіх зірок заданого спектрального класу
(defrule header-by-class
   (declare (salience 100))
   (query-valid)
   (query-class ?c)
   =>
   (print-section-header 1 (str-cat "Zirky spektralnoho klasu " ?c))
)

(defrule find-by-class
   (declare (salience 90))
   (query-valid)
   (query-class ?c)
   (star (name ?n) (spectral-class ?c) (magnitude ?m))
   =>
   (print-star ?n ?c ?m)
)

; Етап 2: Пошук усіх зірок заданої зоряної величини
(defrule header-by-magnitude
   (declare (salience 70))
   (query-valid)
   (query-magnitude ?m)
   =>
   (print-section-header 2 (str-cat "Zirky z velychynoiu " ?m))
)

(defrule find-by-magnitude
   (declare (salience 60))
   (query-valid)
   (query-magnitude ?m)
   (star (name ?n) (spectral-class ?c) (magnitude ?m))
   =>
   (print-star ?n ?c ?m)
)

; Етап 3: Пошук зірок за обома параметрами з передачею відстані у груповий параметр $?extra
(defrule header-by-both
   (declare (salience 40))
   (query-valid)
   (query-class ?c)
   (query-magnitude ?m)
   =>
   (print-section-header 3 (str-cat "Zirky klasu " ?c " i velychyny " ?m " z vidstanniu"))
)

(defrule find-by-both
   (declare (salience 30))
   (query-valid)
   (query-class ?c)
   (query-magnitude ?m)
   (star (name ?n) (spectral-class ?c) (magnitude ?m) (distance ?d))
   =>
   (print-star ?n ?c ?m ?d)
)
