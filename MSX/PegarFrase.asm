; ========================================================================================
; Pegar uma frase de no minimo 2 caracteres e no maximo 14 caracteres
; ========================================================================================
; Receber a mensagem na area de memoria frase => (PegarMensagem)
; Validar o numero de caracteres durante a digitacao => (ValidaDuasLetras)
; Guardar o tamanho da frase digitada => (TamanhoFrase)
; Imprimir a mensagem vindo da memoria para teste => (ImprimirMensagem)
; ========================================================================================
PegarFrase:
	call Home 
	ld hl,MsgUsuario1
	call PrintString 
	ld hl,StrFrase
	call LimpaString
	ld hl,StrFrase
	ld b,0 					; inicia o contador de letras 
LoopFrase:
	call CHGET				; manda a letra digitada para o A
	ld (hl),a 
	call CHPUT				; mostra pro usuario o que ele digitou 
	inc hl 
	inc b	
	cp 13 					; 13 = enter 
	jp z,ValidaDuasLetras 		
	ld a,b
	ld (NumTamFrase),a 
	cp 14 
	ret z 
	jp LoopFrase 
ValidaDuasLetras:
	ld a,(NumTamFrase)
	cp 2 
	ret nc 					; Se a >= 2 esta ok, retorna 
	call LimpaString
jp PegarFrase	

ImprimirFrase:
	call NovaLinha 
	ld hl,MsgUsuario2
	call PrintString 
	ld hl,StrFrase 
	call PrintString 	
ret