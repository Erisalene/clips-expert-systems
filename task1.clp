; Лабораторна робота № 2 - Завдання 1
; Перетворення речень у факти (deffacts) та визначення загальних шаблонів (deftemplate)

; Шаблони для більш загальних відношень
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

; Факти, задані в операторі deffacts
(deffacts family-relations
   ; Родинні зв'язки (батьки - дитина)
   (parent-child (role father) (parent Tom) (child John))
   (parent-child (role mother) (parent Susan) (child John))
   (parent-child (role parents) (parent Tom Susan) (child John))
   
   ; Соціальні/сімейні ролі
   (person-role (name Tom) (role father))
   (person-role (name Susan) (role mother))
   (person-role (name John) (role son))
   
   ; Стать осіб
   (person-gender (name Tom) (gender male))
   (person-gender (name Susan) (gender female))
   (person-gender (name John) (gender male))
)
