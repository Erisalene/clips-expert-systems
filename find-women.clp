(defrule find-women
   (person (gender female) (name $?name) (age ?age))
   =>
   (printout t "Woman: " $?name ", age: " ?age crlf)
)
