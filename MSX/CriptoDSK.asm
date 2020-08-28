; ========================================================================================
; Criptologic 0.1 para MSX 
; ========================================================================================
; Manoel Neto 2020-08-15
; ========================================================================================
include "hardware\BiosMSX.asm"			; contem as funcoes de bios do MSX 
include "assets\Constantes.asm" 		; valores que nao mudarao durante o programa
include "assets\Variaveis.asm" 			; valores que serao colocados na RAM MSX (&E000)

; ========================================================================================
; INICIO PROGRAMA
; ========================================================================================
org &810A
	call LimpaMem						; limpa a memoria e inicializa as variaveis
	call LimparTela						; limpa a tela
	call PegarFrase						; pega a frase do jogador 1
	call Sortear						; sorteia como sera embaralhada a frase
	call Embaralhar						; embaralha a frase
	call PegarChutes					; pega os chutes do jogador 2
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