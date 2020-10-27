; ========================================================================================
; CONSTANTES
; ========================================================================================
romSize:           equ 32768        ; O tamanho que a ROM deve ter
romArea:           equ &4000        ; Minha ROM começa aqui (OU &8000) 
ramArea:           equ &E000        ; Inicio da área de variáveis (RAM)
PAL:               equ 5            ; 1/10s em 50Hz (PAL-B/G/N)
NTSC:              equ 6            ; 1/10s em 60Hz (NTSC & PAL-M)
; ========================================================================================
