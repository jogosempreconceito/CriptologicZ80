; ========================================================================================
; Criptologic 0.1 para MSX 
; ========================================================================================
; Manoel Neto 2019-05-10
; ========================================================================================
include "assets\Variaveis.asm" 		
include "assets\Constantes.asm" 	
; ========================================================================================
; INICIO PROGRAMA
; ========================================================================================
org romArea
	db "AB"                     ; identifica como ROM
 	dw startCode                ; endereço de execução
 	db "CL01"                   ; string de identificação
 	ds 6,0						; define seis bytes com zeros 

startCode: 
	call LimpaMem
	call LimparTela
	call PegarFrase
	call Sortear
	call Embaralhar	
	call SomEmbaralhar
	call PlaySound
	call PegarChutes
	ld hl, MsgUsuario9
	call PrintString
	call CHGET
	cp 13
	jp z,startCode
ret

include "PegarFrase.asm"
include "Sortear.asm"
include "Embaralhar.asm"
include "PegarChutes.asm"

; ========================================================================================
; FIM PROGRAMA
; ========================================================================================	
include "hardware\BiosMSX.asm"			; contem as funcoes de bios do MSX
include "hardware\AY38910.ASM"			; contem as funcoes de audio
include "library\Biblioteca.asm"
include "assets\Strings.asm"

; =============================================================================
; Padding
; =============================================================================
romPad:
 ds romSize-(romPad-romArea),0