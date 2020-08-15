; ========================================================================================
; Criptologic 0.1 para MSX Versao Cartucho
; ========================================================================================
; Manoel Neto 2020-08-14
; ========================================================================================
include "hardware\BiosMSX.asm"			; contem as funcoes de bios MSX 
include "assets\Constantes.asm"			; valores que nao mudarao durante o programa
include "assets\Variaveis.asm" 			; valores que serao colocados na RAM MSX (&E000) 

; ========================================================================================
; INICIO PROGRAMA
; ========================================================================================
org romArea
	db "AB"
  	dw ProgramStart
  	db 00,00,00,00,00
ProgramStart:
	call LimpaMem
	call LimparTela
	call PegarFrase
	call Sortear
	call Embaralhar	
	call PegarChutes
ret 

include "PegarFrase.asm"
include "Sortear.asm"
include "Embaralhar.asm"
include "PegarChutes.asm"
; ========================================================================================
; FIM PROGRAMA
; ========================================================================================	
include "library\Biblioteca.asm"
include "assets\Strings.asm"

romPad:
 ds romSize-(romPad-romArea),0