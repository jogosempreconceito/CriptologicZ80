; =============================================================================
; FUNCOES GERAIS
; =============================================================================

; =============================================================================
; Limpar a tela
; =============================================================================
; Nao tem parametros
; =============================================================================
; Altera => Nada
; =============================================================================
LimparTela:
	push af
		xor a
		call CLS
	pop af
ret

; =============================================================================
; Imprime uma Nova linha
; =============================================================================
; Nao usa parametros
; =============================================================================
; Altera => Nada
; =============================================================================
NovaLinha:
	push af
		ld a, 13
		call CHPUT
		ld a, 10
		call CHPUT
	pop af
ret

; =========================================================================================
; Inicializar as variaveis com zero
; =========================================================================================
; Nao tem parametros
; =========================================================================================
; Altera => A,HL,(TamanhoFrase),(Frase)
; =========================================================================================
LimpaMem: 
	; ================== Zerar Numericos ====================
	xor a 
	ld (NumTamFrase),a
	ld (NumAleatorio),a
	ld (NumSorteios),a
	ld (NumDivIdeal),a
	ld (NumContEmb),a
	ld (NumPosSort),a
	ld (NumContTeste),a
	ld (NumContErros),a
	; ================== Zerar Caracteres ====================
	ld a,' '
	ld (ChaLetraAtual),a
	ld (ChaTestar),a
	; ================== Zerar String ====================
	ld hl,StrFrase
	ld a,16
	call CleanString
	ld hl,StrFraseEmb
	ld a,16
	call CleanString
	; ================== Zerar Matrizes ====================
	ld hl,MatSorteados
	ld a,16
	call CleanMat 
ret 

; ========================================================================================
; Limpa uma string terminada em ENTER(13)
; ========================================================================================
; HL => Endereco da string
; ========================================================================================
; Altera => A, HL
; ========================================================================================
LimpaString:
	ld a,(hl)
	cp 13 
	jp z, LimpouString
	ld a,' '
	ld (hl),a
	inc hl 
	jp LimpaString
LimpouString:
ret

; ========================================================================================
; Imprime uma string terminada em ENTER(13)
; ========================================================================================
; HL => Endereco da string
; ========================================================================================
; Altera => A,HL
; ========================================================================================
PrintString:
	ld a,(hl)
	cp 13
	jp z,EndString
	call CHPUT
	inc hl
	jp PrintString	
EndString:
ret

; =========================================================================================
; Colocar o cursor na posicao inicial.
; =========================================================================================
; Nao tem parametros
; =========================================================================================
; Altera => Nada
; =========================================================================================
Home:
	push hl 
		ld l, 1				; COORDENADA X 
		ld h, 1				; COORDENADA Y 
		call POSIT
	pop hl 
ret 

; ========================================================================================
; Zerar uma Matriz terminada em 255
; ========================================================================================
; HL => Endereco da Matriz
; ========================================================================================
; ALTERA => A,HL
; ========================================================================================
ZerarMatriz:
	ld a,(hl)
	cp 255
	jp z,ZerouMatriz
	ld a,255
	ld (hl),a
	inc hl
	jp ZerarMatriz
ZerouMatriz:
ret

; ========================================================================================
; Converter um numero de 0 a 15 em seu digito hexadecimal
; ========================================================================================
; A => Numero a ser convertido
; ========================================================================================
; ALTERA => A
; ========================================================================================
ConvNumChar:
	cp 0
	jp z,Zero
	cp 1
	jp z,Um
	cp 2
	jp z,Dois
	cp 3
	jp z,Tres
	cp 4
	jp z,Quatro
	cp 5
	jp z,Cinco
	cp 6
	jp z,Seis
	cp 7
	jp z,Sete
	cp 8
	jp z,Oito
	cp 9
	jp z,Nove
	cp 10
	jp z,DezA
	cp 11
	jp z,OnzeB
	cp 12
	jp z,Dozec
	cp 13
	jp z,TrezeD
	cp 14
	jp z,QuatorzeE
	cp 15
	jp z,QuinzeF
	ret
Zero:
	ld a,'0'
ret

Um:
	ld a,'1'
ret

Dois:
	ld a,'2'
ret

Tres:
	ld a,'3'
ret

Quatro:
	ld a,'4'
ret

Cinco:
	ld a,'5'
ret

Seis:
	ld a,'6'
ret

Sete:
	ld a,'7'
ret

Oito:
	ld a,'8'
ret

Nove:
	ld a,'9'
ret

DezA:
	ld a,'A'
ret

OnzeB:
	ld a,'B'
ret

Dozec:
	ld a,'C'
ret

TrezeD:
	ld a,'D'
ret

QuatorzeE:
	ld a,'E'
ret

QuinzeF:
	ld a,'F'
ret

; ========================================================================================
; Imprime um Numero
; ========================================================================================
; A => Numero a ser impresso (8 bits,255)
; ========================================================================================
; Altera => A,HL,D
; ========================================================================================
PrintNumber:
	ld hl,Centenas
	ld (hl),&00
	ld hl,Dezenas
	ld (hl),&00
	ld hl,Unidades
	ld (hl),&00
ContaCentenas:
	ld d,&64
	ld hl,Centenas
ProximaCentena:
	sub d
	jr c,ContarDezenas
	inc (hl)
jr ProximaCentena

ContarDezenas:
	add a,d
	ld d,&0a
	ld hl,Dezenas
ProximaDezena:
	sub d
	jr c,ContaUnidades
	inc (hl)
jr ProximaDezena

ContaUnidades:
	add a,d
	ld (Unidades),a
	ld d,0

ImprimeCentenas:
	ld a,(Centenas)
	cp &00
	jr z,ImprimeDezenas
	add a,&30		
	call CHPUT
	ld d,1
ImprimeDezenas:
	ld a,(Dezenas)
	add a,d
	cp &00
	jr z,ImprimeUnidades
	sub d
	ld d,1
	add a,&30		
	call CHPUT
ImprimeUnidades:
	ld a,(Unidades)
	add a,&30		
	call CHPUT
ret
; =============================================================================

; =============================================================================
; Limpar um espaco de memoria com CHR(13)
; =============================================================================
; HL => Inicio da memoria
; A  => bytes a limpar
; =============================================================================
; Altera => A, Todos os bytes a partir de HL ate HL+A
; =============================================================================
CleanString:
	ld (hl),13
	cp 0
	jr z,CleanedString
	inc hl
	dec a
	jp CleanString
CleanedString:
ret
; =============================================================================

; =============================================================================
; Limpar um espaco de memoria com CHR(255)
; =============================================================================
; HL => Inicio da memoria
; A	 => bytes a limpar
; =============================================================================
; Altera => A, Todos os bytes a partir de HL ate HL+A
; =============================================================================
CleanMat:
	ld (hl),255
	cp 0
	jr z,CleanedMat
	inc hl
	dec a
	jp CleanMat
CleanedMat:
ret
; =============================================================================

; =============================================================================
; Toca o som de embaralhamento
; =============================================================================
; Parametros => Nenhum
; =============================================================================
; Altera => nada
; =============================================================================
SomEmbaralhar:
	push bc
  		ld bc,C1
  		call PlayNote
  		ld bc,D2
  		call PlayNote
  		ld bc,E3
  		call PlayNote
  		ld bc,F4
  		call PlayNote
  		ld bc,G5
  		call PlayNote 
  		ld bc,A6
  		call PlayNote 
  		ld bc,B7
  		call PlayNote
	pop bc 
ret 
; ==============================================================================