;==============================================================================================
; Ola Mundo Z80 
;==============================================================================================
PrintChar 		equ &BB5A	; Funcao => Imprime um caracter

org &8000
	ld hl, Frase
ProximoChar:
	ld a,(hl)
	cp 13 
	jp z, FimString
	call PrintChar 
	inc hl
	jp ProximoChar
FimString:
	;call NovaLinha 
ret 

;==============================================================================================
; Pular uma linha 
;==============================================================================================
; Parametros => NA
;==============================================================================================
; Altera => NA 
;==============================================================================================
NovaLinha:
	push af
		ld a,13
		call PrintChar 
		ld a,10
		call Printchar
	pop af 
ret  

Frase:  
	db "Ola Mundo",13; 13 em ascii signifca ENTER