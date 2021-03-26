; ========================================================================================
; Exemplo de leitura do registrador de status do VDP
; ========================================================================================
; Manoel Neto 2021-03-26
; ========================================================================================
include "..\..\..\assets\Constantes.asm" 	
; ========================================================================================
; INICIO PROGRAMA
; ========================================================================================
org romArea
	db "AB"                     ; identifica como ROM
 	dw startCode                ; endereço de execução
 	db "CL01"                   ; string de identificação
 	ds 6,0						; define seis bytes com zeros 

startCode: 
    call readStatus             ; coloca o conteudo do status em a startCode
    bit 7,a                     ; testa se o bit 7 esta setado
    jp nz,imprimeFimCiclo       ; testa se o bit 7 esta setado
	jp startCode
imprimeFimCiclo:
    ld hl,MsgUsuario
    call PrintString    
ret

PrintString:
	ld a,(hl)
	cp 13
	jp z,EndString
	call CHPUT
	inc hl
	jp PrintString	
EndString:
ret

MsgUsuario:
    db "Fim do ciclo",13

; ========================================================================================
; FIM PROGRAMA
; ========================================================================================	
include "..\..\..\hardware\BiosMSX.asm"			; contem as funcoes de bios do MSX
include "..\..\..\hardware\TMS9918.ASM"			; contem as funcoes de audio

; =============================================================================
; Padding
; =============================================================================
romPad:
 ds romSize-(romPad-romArea),0