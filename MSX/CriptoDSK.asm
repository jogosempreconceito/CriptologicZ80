; ========================================================================================
; Criptologic 0.1 para MSX 
; ========================================================================================
; Manoel Neto 2019-05-10
; ========================================================================================
include "hardware\BiosMSX.asm"			; contem as funcoes de bios do MSX 
include "assets\Variaveis.asm" 		
; ========================================================================================
; INICIO PROGRAMA
; ========================================================================================
org &810A
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