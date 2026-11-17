; Лабораторна робота № 2 - Завдання 2 (Варіант № 4)
; Семантична мережа родини (Рис. 2) у вигляді фактів deffacts та шаблонів deftemplate

; Кілька конструкцій deftemplate для різних типів відношень семантичної мережі
(deftemplate marriage
   (slot relation (allowed-values wife-of husband-of))
   (slot person1)
   (slot person2)
)

(deftemplate parenthood
   (slot relation (allowed-values mother-of father-of))
   (slot parent)
   (slot child)
)

(deftemplate sibling
   (slot relation (allowed-values sister-of brother-of))
   (slot person1)
   (slot person2)
)

; Оператор deffacts з усіма зв'язками з Рисунку 2
(deffacts semantic-network-family
   ; Зв'язки sister-of (верхній рівень: Ann <-> Carol)
   (sibling (relation sister-of) (person1 Ann) (person2 Carol))
   (sibling (relation sister-of) (person1 Carol) (person2 Ann))
   
   ; Подружні зв'язки (wife-of та husband-of)
   (marriage (relation wife-of) (person1 Ann) (person2 Bill))
   (marriage (relation husband-of) (person1 Bill) (person2 Ann))
   
   (marriage (relation wife-of) (person1 Carol) (person2 David))
   (marriage (relation husband-of) (person1 David) (person2 Carol))
   
   (marriage (relation wife-of) (person1 Susan) (person2 Tom))
   (marriage (relation husband-of) (person1 Tom) (person2 Susan))
   
   ; Батьківські зв'язки (mother-of та father-of)
   (parenthood (relation mother-of) (parent Ann) (child Susan))
   (parenthood (relation father-of) (parent Bill) (child Susan))
   
   (parenthood (relation mother-of) (parent Carol) (child Tom))
   (parenthood (relation father-of) (parent David) (child Tom))
   
   (parenthood (relation mother-of) (parent Susan) (child John))
   (parenthood (relation father-of) (parent Tom) (child John))
)
