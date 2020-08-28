; ========================================================================================
<<<<<<< HEAD
; CONSTANTES
; ========================================================================================
romSize:           equ 32768        ; O tamanho que a ROM deve ter
romArea:           equ &4000       ; Minha ROM começa aqui (OU &8000) 
ramArea:           equ &E000       ; Inicio da área de variáveis (RAM)
; ========================================================================================
=======
; Constantes.asm
; ========================================================================================
; Contem todas as constantes usadad no programa 
; Manoel Neto 2020-08-14
; ========================================================================================
romSize:                     EQU 32768  ; tamanho da nossa rom
romArea:                     EQU &4000  ; endereco de memoria incial da ROM (8000 ou 4000)
ramArea:                     EQU &E000  ; endereco de memoria da RAM do MSX   
>>>>>>> a46a24ea30b95d9319e5fd67760475e459ff30fe
