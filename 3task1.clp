; Лабораторна робота № 3 - Завдання 1
; Виведення 9 речень про родину у чіткій послідовності за допомогою правил (defrule)

(deftemplate parent-child
   (slot role (allowed-values father mother parents))
   (multislot parent)
   (slot child)
)

(deftemplate person-role
   (slot name)
   (slot role (allowed-values father mother son))
)

(deftemplate person-gender
   (slot name)
   (slot gender (allowed-values male female))
)

(deffacts family-relations
   (parent-child (role father) (parent Tom) (child John))
   (parent-child (role mother) (parent Susan) (child John))
   (parent-child (role parents) (parent Tom Susan) (child John))
   (person-role (name Tom) (role father))
   (person-role (name Susan) (role mother))
   (person-role (name John) (role son))
   (person-gender (name Tom) (gender male))
   (person-gender (name Susan) (gender female))
   (person-gender (name John) (gender male))
)

; Правила з пріоритетами (salience) для забезпечення точного порядку виведення 9 рядків

(defrule r1-father-of
   (declare (salience 90))
   (parent-child (role father) (parent ?p) (child ?c))
   =>
   (printout t "The father of " ?c " is " ?p "." crlf)
)

(defrule r2-mother-of
   (declare (salience 80))
   (parent-child (role mother) (parent ?p) (child ?c))
   =>
   (printout t "The mother of " ?c " is " ?p "." crlf)
)

(defrule r3-parents-of
   (declare (salience 70))
   (parent-child (role parents) (parent ?p1 ?p2) (child ?c))
   =>
   (printout t "The parents of " ?c " are " ?p1 " and " ?p2 "." crlf)
)

(defrule r4-tom-father
   (declare (salience 60))
   (person-role (name Tom) (role father))
   =>
   (printout t "Tom is a father." crlf)
)

(defrule r5-susan-mother
   (declare (salience 50))
   (person-role (name Susan) (role mother))
   =>
   (printout t "Susan is a mother." crlf)
)

(defrule r6-john-son
   (declare (salience 40))
   (person-role (name John) (role son))
   =>
   (printout t "John is a son." crlf)
)

(defrule r7-tom-male
   (declare (salience 30))
   (person-gender (name Tom) (gender male))
   =>
   (printout t "Tom is a male." crlf)
)

(defrule r8-susan-female
   (declare (salience 20))
   (person-gender (name Susan) (gender female))
   =>
   (printout t "Susan is a female." crlf)
)

(defrule r9-john-male
   (declare (salience 10))
   (person-gender (name John) (gender male))
   =>
   (printout t "John is a male." crlf)
)
