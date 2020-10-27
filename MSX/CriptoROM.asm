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
	; ===========================================================================
  	; Verifico se o MSX eh PAL ou NTSC
  	; ===========================================================================
  	ld a,NTSC               ; a princípio eh NTSC
  	ld (vdpCycle1),a        ; carrego o valor 1/10s (1 ciclo de VDP)
  	ld a,NTSC*10            ; multiplico por 10
  	ld (vdpCycle5),a        ; carrego o valor 1s (5 ciclos de VDP)
  	ld a,(0x002b)           ; leio a versão do MSX na ROM
  	bit 7,a                 ; se o bit 7 for 1 é 50Hz senão é 60Hz
  	jr z, noPalAdjust       ; sendo 0 eu sigo adiante
palAdjust:
	ld a,PAL                ; defino o novo valor para PAL
  	ld (vdpCycle1),a        ; o valor para 1/10s em PAL
  	ld a,PAL*10             ; 1/10*10=1, certo?
  	ld (vdpCycle5),a        ; o valor é o de 1s em PAL
noPalAdjust:
	call LimpaMem
	call LimparTela
	call PegarFrase
	call Sortear
	call Embaralhar	
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