; ========================================================================================
; Exemplo de leitura do registrador de status do VDP
; ========================================================================================
; Manoel Neto 2021-03-26
; ========================================================================================
include "..\assets\Constantes.asm" 	
; ========================================================================================
; INICIO PROGRAMA
; ========================================================================================
org romArea
	db "AB"                     ; identifica como ROM
 	dw startCode                ; endereço de execução
 	db "CL01"                   ; string de identificação
 	ds 6,0						; define seis bytes com zeros 

startCode: 	
	call CHGET
	cp 13
	jp z,startCode
ret

; ========================================================================================
; FIM PROGRAMA
; ========================================================================================	
include "..\hardware\BiosMSX.asm"			; contem as funcoes de bios do MSX
include "..\hardware\TMS9918.ASM"			; contem as funcoes de audio
include "..\library\Biblioteca.asm"

; =============================================================================
; Padding
; =============================================================================
romPad:
 ds romSize-(romPad-romArea),0