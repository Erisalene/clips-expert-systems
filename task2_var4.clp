; Лабораторна робота № 3 - Завдання 2 (Варіант № 4)
; Класифікація зірок за спектральним класом та зоряною величиною

(deftemplate star
   (slot name)
   (slot spectral-class (allowed-values O B A F G K M))
   (slot magnitude (type INTEGER))
   (slot distance (type NUMBER))
)

; База знань зірок із Таблиці 1
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

; Вхідні факти запиту (приклад для демонстрації: клас A та величина 1 -> Сиріус і Вега)
; Для перевірки іншого запиту достатньо змінити ці два факти або додати їх через (assert)
(deffacts user-query
   (query-class A)
   (query-magnitude 1)
)

; Етап 1: Заголовки та виведення всіх зірок заданого спектрального класу
(defrule header-by-class
   (declare (salience 100))
   (query-class ?c)
   =>
   (printout t "=== 1. Zirky spektralnoho klasu " ?c " ===" crlf)
)

(defrule find-by-class
   (declare (salience 90))
   (query-class ?c)
   (star (name ?n) (spectral-class ?c))
   =>
   (printout t " - " ?n crlf)
)

; Етап 2: Заголовок та виведення всіх зірок заданої величини
(defrule header-by-magnitude
   (declare (salience 70))
   (query-magnitude ?m)
   =>
   (printout t crlf "=== 2. Zirky z velychynoiu " ?m " ===" crlf)
)

(defrule find-by-magnitude
   (declare (salience 60))
   (query-magnitude ?m)
   (star (name ?n) (magnitude ?m))
   =>
   (printout t " - " ?n crlf)
)

; Етап 3: Заголовок та виведення зірок, що відповідають ОБОМ умовам, з відстанню
(defrule header-by-both
   (declare (salience 40))
   (query-class ?c)
   (query-magnitude ?m)
   =>
   (printout t crlf "=== 3. Zirky klasu " ?c " i velychyny " ?m " (vidstan u svitlovykh rokakh) ===" crlf)
)

(defrule find-by-both
   (declare (salience 30))
   (query-class ?c)
   (query-magnitude ?m)
   (star (name ?n) (spectral-class ?c) (magnitude ?m) (distance ?d))
   =>
   (printout t " - " ?n " (vidstan: " ?d " sv. rokiv)" crlf)
)
