; ========================================================================================
; Pegar uma letra e testar se e a letra da posicao verificada
; ========================================================================================
; pegar o chute 							=> PegarEntrada
; testar se essa letra e a posicao atual	=> TestarCorreto
; imprimir se esta certo ou errado.   		=> ImprimeErros
; ========================================================================================
PegarChutes: 
	xor a						; LD a,0
	ld (NumContTeste),a			; contador a posicao da str
	ld (NumContErros),a 		; contador de erros
loopPegarChar:
	call PegarEntrada
	jp TestarCorreto
EstaCorreto: 
	ld hl,MsgUsuario5
	call PrintString
	call NovaLinha
	call SomAcerto
	ld a,(NumTamFrase)
	dec a
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
	ld hl,MsgUsuario4
	call PrintString
	call CHGET	
	ld (ChaTestar),a
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
	ld a,(ChaTestar)
	cp b
	jp z,EstaCorreto
	ld a,(NumContErros)
	inc a 
	ld (NumContErros),a 
	ld hl,MsgUsuario6
	call PrintString
	call NovaLinha
	call SomErro
	jp loopPegarChar

ImprimeErros:
	ld hl,MsgUsuario7
	call PrintString
	call NovaLinha
	ld hl,MsgUsuario8
	call PrintString
	ld a,(NumContErros)
	call PrintNumber
	call NovaLinha
ret 