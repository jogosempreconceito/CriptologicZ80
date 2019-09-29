;=========================================================================================
; Sortear.asm
;=========================================================================================
; Manoel Neto 2019-09-29
; Sortear X numeros aleatorios entre 1 e N 
; N deve ser igual ao tamanho da frase do jogador 1
; Validar se o numero sorteado nao eh maior que N 	=> (ValidarMaiorN)
; Validar se o numero sorteado ja foi sorteado 	  	=> (ValidarJaFoi)
; Jogar o resultado para a variavel NumAleatorio  	=> (9001)
; Jogar o resultado para a matriz de numeros sorteados 	=> (NumerosSorteados)
; Converter o numero em seu codigo Hexadeciaml 		=> (9002)
; Imprimir o char convertido 				=> ImprimeChar
; Somar um a cada elemento da matriz			=> Somar um
;=========================================================================================
read "Bios.asm"			; contem as funcoes do amstrad CPC 
read "Variaveis.asm" 		; read = include 

; ========================================================================================
; INICIO PROGRAMA
; ========================================================================================
org &8000
	call LimpaMem			; Limpar a memoria 
	xor a				; ld a,0 so que mais rapido
	ld (NumSorteios),a		; zera contador de sorteios
	ld a,2  			; Tamanho da frase do jogador 1
	ld (NumTamFrase),a		; testar com 2, 9 e 14
	call AcharDivIdeal		; achar o divisor ideal 
SortearDeNovo:
	call SortearNumero		; Sorteei o numero em NumAleatorio
	jp ValidarMenorN		; O numero nao pode ser maior que a entrada
ValidadoMenorN:
	jp ValidarJafoi			; O Numero nao pode se repetir
ValidadoJaFoi:
	call GravarNaMatriz		; Grava o sorteio na matriz
	ld a,(NumTamFrase)		; carrega o contador de sorteios
	ld c,a				; so irei sortear de acordo com a entrada
	ld a,(NumSorteios)		; Pega o numero de sorteios
	inc a				; Aumenta numero de sorteios
	cp c				; testa se eh ultimo sorteio
	jp z,FimSorteio			; Acabou
	ld (NumSorteios),a		; Grava o numero de sorteios
	jp SortearDeNovo		; faz de novo
FimSorteio:
	call SomarUm			; soma um em cada elemento da matriz
	call ImprimirMatriz		; Imprimir a Matriz
ret


AcharDivIdeal:
	ld a,(NumTamFrase)
	ld b,a  
	ld a,128 
	ld d,0 
DivPorTamanho:
	sub a,b
	inc d
	jp nc,DivPorTamanho
	dec d
  	ld a,d
	ld (NumDivIdeal),a		; A Variavel contem o dividor ideal 
ret 

SortearNumero:	
	ld a,(NumDivIdeal)
	ld b,a 
	ld a,r 				; NUNCA CARREGUE VALORES EM R APENAS LEIA
	ld d,0 				; contem o resultado da divisao 
DivPorIdeal:
	sub a,b 
	inc d 
	jp nc,DivPorIdeal
	dec d
	ld a,d
GravarAleatorio: 
	ld (NumAleatorio),a
ret 

ValidarMenorN:
	ld a, (NumTamFrase)
	ld b,a
	ld a, (NumAleatorio)
	cp b
	jp c,ValidadoMenorN 		; A < NumTamFrase 
jp SortearDeNovo

ValidarJafoi:
	ld a, (NumTamFrase)
	ld hl, MatSorteados
AcharFimMat:
	cp 0
	jp z, AcheiFimMat 
	inc hl
	dec a 
	jp AcharFimMat
AcheiFimMat:
	ld a,(NumTamFrase)
	inc a
	ld c,a 				; 
	ld b,0	
	ld a,(NumAleatorio)
	cpdr
	jp z,SortearDeNovo
jp ValidadoJaFoi

GravarNaMatriz:
	ld hl,MatSorteados
	ld a,(NumSorteios)
	cp 0
	jp z,AcheiPosMat
AcharPosMat:
	inc hl
	dec a
	cp 0
	jp z,AcheiPosMat
	jp AcharPosMat
AcheiPosMat:
	ld a,(NumAleatorio)
	ld (hl),a
ret	

SomarUm:
	ld hl,MatSorteados
LoopSomarUm:
	ld a,(hl)
	cp 255
	jp z,FimSomarUm
	inc a
	ld (hl),a
	inc hl
	jp LoopSomarUm
FimSomarUm:
ret

ImprimirMatriz:
	ld hl,MatSorteados
LoopImprimirMatriz:
	ld a,(hl)
	cp 255
	jp z,FimImprimirMatriz
	call ConvNumChar 		; Converte o numero em digito 1-F
	call TXT_OUTPUT			; Imprime o caracter
	ld a,' '
	call TXT_OUTPUT
	inc hl
	jp LoopImprimirMatriz
FimImprimirMatriz:
ret

; ========================================================================================
; FIM PROGRAMA
; ========================================================================================	
read "Biblioteca.asm"
read "Strings.asm"
