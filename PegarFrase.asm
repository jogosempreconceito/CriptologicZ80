; ========================================================================================
; Pegar uma frase de no minimo 2 caracteres e no maximo 14 caracteres
; ========================================================================================
; Receber a mensagem na area de memoria frase => (PegarMensagem)
; Validar o numero de caracteres durante a digitacao => (ValidaDuasLetras)
; Guardar o tamanho da frase digitada => (TamanhoFrase)
; Imprimir a mensagem vindo da memoria para teste => (ImprimirMensagem)
; ========================================================================================
read "Bios.asm"			; contem as funcoes do amstrad CPC 
read "Variaveis.asm" 		; read = include 

; ========================================================================================
; INICIO PROGRAMA
; ========================================================================================
org &8000
	call LimpaMem
	call PegarFrase 
	call ImprimirFrase 	
ret 
cls
PegarFrase:
	call SCR_MODE_CLEAR
	call Home 
	ld hl,MsgUsuario1
	call PrintString 
	ld hl,Frase
	call LimpaString
	ld hl,Frase
	ld b,0 				; inicia o contador de letras 
LoopFrase:
	call KM_WAIT_CHAR		; manda a letra digitada para o A
	ld (hl),a 
	call TXT_OUTPUT			; mostra pro usuario o que ele digitou 
	inc hl 
	inc b	
	cp 13 				; 13 = enter 
	jp z,ValidaDuasLetras 		
	ld a,b
	ld (TamanhoFrase),a 
	cp 14 
	ret z 
	jp LoopFrase 
ValidaDuasLetras:
	ld a,(TamanhoFrase)
	cp 2 
	ret nc 				; Se a >= 2 esta ok, retorna 
	call LimpaString
jp PegarFrase	


ImprimirFrase:
	call Novalinha 
	ld hl,MsgUsuario2
	call PrintString 
	ld hl,Frase 
	call PrintString 	
ret

; ========================================================================================
; FIM PROGRAMA
; ========================================================================================	
read "Biblioteca.asm"
read "Strings.asm"

