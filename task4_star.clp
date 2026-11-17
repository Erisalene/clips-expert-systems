(deftemplate person
   (multislot name)
   (slot age (type INTEGER))
   (slot gender (allowed-values male female))
)

(deffacts people
   (person (name Ivan) (age 20) (gender male))
   (person (name Berta Ida) (age 22) (gender female))
   (person (name Petro) (age 19) (gender male))
)
