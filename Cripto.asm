; ========================================================================================
; Criptologic 0.1 para MSX 
; ========================================================================================
; Manoel Neto 2019-05-10
; ========================================================================================
read "BiosCPC.asm"		; contem as funcoes do amstrad CPC 
read "Variaveis.asm" 		; read = include 

; ========================================================================================
; INICIO PROGRAMA
; ========================================================================================
org &8000
	call LimpaMem
	call SCR_MODE_CLEAR
	call PegarFrase
	call Sortear
	call Embaralhar	
	call PegarChutes
ret 

read "PegarFrase.asm"
read "Sortear.asm"
read "Embaralhar.asm"
read "PegarChutes.asm"
; ========================================================================================
; FIM PROGRAMA
; ========================================================================================	
read "Biblioteca.asm"
read "Strings.asm"

