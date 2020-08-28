;=========================================================================================
; Embaralhar Frase
;=========================================================================================
; Achar a posicao sorteada na matriz					=> AcharPosSort
; Achar a letra nessa posicao da matriz					=> AcharLetra
; Gravar a letra encontrada em sua posicao embaralhada	=> GravarLetra
; Imprimir a frase inicial 								=> StrFrase
; Imprimir a frase Embaralhada 							=> StrFraseEmb
;=========================================================================================
Embaralhar:
	xor a					; xor a = ld a,0
	ld (NumContEmb),a		; zerar o contador de embaralhamento			
GravarProxima:
	call AcharPosSort 		; achar a posicao sorteada nesse momento 
	call AcharLetra 		; achar a a letra dessa posicao 
	call GravarLetra 		; achar a a letra dessa posicao 
	ld a,(NumTamFrase)
	ld b,a 					; par BC controla os loops
	ld a,(NumContEmb)
	cp b
	jp z,GravouTudo
	inc a
	ld (NumContEmb),a 
	jp GravarProxima
GravouTudo:
	call NovaLinha			; pula linha
	ld hl,MsgUsuario3		; imprime mensagem para o usuario
	call PrintString		; print
	ld hl,StrFraseEmb		; imprime a frase embaralhada
	call PrintString		; print
	call NovaLinha	
ret 
	
AcharPosSort: 
	ld a,(NumContEmb)	
	ld hl,MatSorteados
LoopAcharPosSort:
	cp 0
	jp z,AchouPosSort
	inc hl 
	dec a 
	jp LoopAcharPosSort
AchouPosSort:
	ld a,(hl)
	ld (NumPosSort),a 
ret 

AcharLetra:
	ld a,(NumPosSort)
	dec a				; enderecos comecam com zero
	ld hl,StrFrase 
LoopAcharLetra:
	cp 0 
	jp z,AchouLetra
	dec a
	inc hl 
	jp LoopAcharLetra
AchouLetra:
	ld a,(hl) 
	ld (ChaLetraAtual),a 
ret 

GravarLetra:
	ld a,(NumContEmb)
	ld b,a 
	xor a
	ld hl,StrFraseEmb		; apontamos para escrever aqui 
LoopGravarLetra 
	cp b 
	jp z,AchouPosGravar
	inc hl
	inc a 
	jp LoopGravarLetra
AchouPosGravar:
	ld a,(ChaLetraAtual)
	ld (hl),a 
	inc hl 
	ld (hl),13 
ret 