; ========================================================================================
; Pegar uma frase de no minimo 2 caracteres e no maximo 14 caracteres
; ========================================================================================
; Receber a mensagem na area de memoria frase => (PegarMensagem)
; Validar o numero de caracteres durante a digitacao => (ValidaDuasLetras)
; Guardar o tamanho da frase digitada => (TamanhoFrase)
; Imprimir a mensagem vindo da memoria para teste => (ImprimirMensagem)
; ========================================================================================
; ========================================================================================
; BIOS
; ========================================================================================
KM_WAIT_CHAR	equ &BB06	; Funcao => Aguarda uma entrada
TXT_OUTPUT	equ &BB5A	; Funcao => Imprime um caracter
SCR_MODE_CLEAR 	equ &BC14 	; Funcao => Limpa a tela 
TXT_SET_CURSOR 	equ &BB75	; Funcao => Posiciona o cursor
; ========================================================================================
; VARIAVEIS
; ========================================================================================
TamanhoFrase 	equ &9000
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
	
; =========================================================================================
; FUNCOES GERAIS
; =========================================================================================

; =========================================================================================
; Inicializar as variaveis com zero
; =========================================================================================
; Nao tem parametros
; =========================================================================================
; Altera => A,HL,(TamanhoFrase),(Frase)
; =========================================================================================
LimpaMem: 
	ld a,0 
	ld (TamanhoFrase),a
	ld hl,Frase
	call LimpaString
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
	call TXT_OUTPUT
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
		ld l, 1
		ld h, 1	
		call TXT_SET_CURSOR
	pop hl 
ret 

; ========================================================================================
; Imprime uma Nova linha
; ========================================================================================
; Nao usa parametros
; ========================================================================================
; Altera => Nada
; ========================================================================================
NovaLinha:
	push af 
		ld a, 13
		call TXT_OUTPUT
		ld a, 10 
		call TXT_OUTPUT
	pop af 
ret


;=========================================================================================
; STRINGS
;=========================================================================================
MsgUsuario1: 
	db "Entre a sua mensagem:",13 
MsgUsuario2: 
	db "Voce Digitou:",13 
Frase: 
	db 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,13 