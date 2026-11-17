(defrule find-men
   (person (gender male) (name $?name) (age ?age))
   =>
   (printout t "Man: " $?name ", age: " ?age crlf)
)
