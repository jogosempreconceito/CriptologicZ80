;==============================================================================================
; Ola Mundo Z80 
;==============================================================================================
PrintChar 		equ &BB5A	; Funcao => Imprime um caracter

org &8000
	ld hl, Frase
ProximoChar:
	ld a,(hl)
	call PrintChar 
	cp 13 
	jp z, FimString
	inc hl
	jp ProximoChar
FimString:
	call NovaLinha 
ret 

NovaLinha:
	ld a,13
	call PrintChar 
	ld a,10
	call Printchar
ret  

Frase:  
	db "Ola Mundo",13 ; 13 em ascii signifca ENTER