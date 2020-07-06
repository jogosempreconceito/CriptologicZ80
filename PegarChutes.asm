<<<<<<< HEAD
; ========================================================================================
; Pegar uma letra e testar se e a letra da posicao verificada
; ========================================================================================
; pegar o chute 				=> PegarEntrada
; testar se essa letra e a posicao atual	=> TestarCorreto
; imprimir se esta certo ou errado.   		=> ImprimeErros
; ========================================================================================
PegarChutes: 
	xor a			; LD a,0
	ld (NumContTeste),a	; contador a posicao da str
	ld (NumContErros),a 	; contador de erros
loopPegarChar:
	call PegarEntrada
	jp TestarCorreto
EstaCorreto: 
	ld hl,MsgUsuario4
=======
; =========================================================================================
; PegarChutes.asm
; =========================================================================================
; Pegar os chutes do jogador 2
; Pegar chute e gravar 			     	=>(PegarEntrada)
; Testar se o caracter esta na posicao atual 	=>(TestarCorreto)
; Imprimir os erros ao final 			=>(ImprimirErros)
; =========================================================================================
PegarChutes:
	xor a
	ld (NumContTeste),a
	ld (NumContErros),a
LoopPegaChar:
	call PegarEntrada
	jp TestarCorreto
EstaCorreto:
	ld hl,MsgUsuario5
>>>>>>> 0394ac494c8c076107ae2e62aeece518161a3c72
	call PrintString
	call NovaLinha
	ld a,(NumTamFrase)
	dec a
<<<<<<< HEAD
	ld b,a	
	ld a,(NumContTeste)
	cp b 
	jp z,Acertou
	inc a
	ld (NumContTeste),a 
	jp loopPegarChar
Acertou:
	call ImprimeErros
ret 

PegarEntrada:
	ld hl,MsgUsuario5
	call PrintString
	call KM_WAIT_CHAR
	ld (ChaTeste),a
	call NovaLinha
ret 

TestarCorreto:
	ld hl,StrFrase
	ld a,(NumContTeste)
AcharPosicaoTeste:
	cp 0 
	jp z,AchouTeste
	inc hl 	
	dec a 
	jp AcharPosicaoTeste
AchouTeste:
	ld a,(hl)
	ld b,a 
	ld a,(ChaTeste)
	cp b
	jp z,EstaCorreto
	ld a,(NumContErros)
	inc a 
	ld (NumContErros),a 
	ld hl,MsgUsuario6
	call PrintString
	call NovaLinha
	jp loopPegarChar

ImprimeErros:
	ld hl,MsgUsuario7
	call PrintString
	call NovaLinha
=======
	ld b,a
	ld a,(NumContTeste)
	cp b
	jp z,Acertou
	inc a
	ld (NumContTeste),a
	jp LoopPegaChar
Acertou:
	call ImprimirErros
ret

PegarEntrada:
	ld hl,MsgUsuario4
	call PrintString
	call KM_WAIT_CHAR
	ld (ChaTestar),a
	call NovaLinha
ret

TestarCorreto:
	ld hl,StrFrase
	ld a,(NumContTeste)			; Conta o teste
AcharPosicaoTeste:
	cp 0
	jp z,AchouTeste
	inc hl
	dec a					; proximo teste
	jp AcharPosicaoTeste
AchouTeste:
	ld a,(hl)
	ld b,a
	ld a,(ChaTestar)
	cp b
	jp z,EstaCorreto
	ld a,(NumContErros)
	inc a
	ld (NumContErros),a
	ld hl,MsgUsuario6
	call PrintString
	call Novalinha
	jp LoopPegaChar
ImprimirErros:
	ld hl,MsgUsuario7
	call PrintString
	call Novalinha
>>>>>>> 0394ac494c8c076107ae2e62aeece518161a3c72
	ld hl,MsgUsuario8
	call PrintString
	ld a,(NumContErros)
	call PrintNumber
<<<<<<< HEAD
	call NovaLinha
ret 



=======
	call Novalinha
ret
>>>>>>> 0394ac494c8c076107ae2e62aeece518161a3c72
