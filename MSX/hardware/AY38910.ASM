; ================================================================================================
; AY38910.ASM
; ================================================================================================
; Manoel Neto 2019-10-04
; Biblioteca para uso do chip de som AY38910
; ================================================================================================
; Amplitude	        => Volume
; Envelope	        => Mudanças de volume em dado tempo
; Mixer	            => Liga e desliga os canais de som
; Noise	            => Sons com distorcao
; Tone	            => Tom emitido
; O PSG possui 3 canais de som (A,B e C) que tem seus periodos controlados pelos seguintes 
; registradores:
; 
; Canal A   => Registradores 0 e 1
; Canal B   => Registradores 2 e 3
; Canal C   => Registradores 4 e 5
; 
; O modelo desses registradores segue abaixo  
;
; R0 => 7   6   5   4   3   2   1   0  
;       BITS MENOS SIGNIFICATIVOS DO PERIODO DO CANAL A
;
; R1 => 7   6   5   4   3   2   1   0
;       x   x   x   x   BITS MAIS SIGNIFICATIVOS DO PERIODO DO CANAL A
;
; PODEMOS CARREGAR O PERIODO COM VALORES QUE VAO DE 1 ATÉ 4095 
; ================================================================================================

; ================================================================================================
; Apos carregarmos o periodo desejado nos registradores do canal,devemos informar ao nosso 
; envelope (R8, R9, R10) como queremos modular esse som (modo fixo ou modulado) e qual será o 
; volume (ou variacao do volume em caso de amplitude modulada) seguindo o sequinte modelo.
;
; R8 => 7   6   5   4       3   2   1   0
;       X   X   X   MODO    APLITUDE DO CANAL A
;
; R9 => 7   6   5   4       3   2   1   0
;       X   X   X   MODO    APLITUDE DO CANAL B
;
; R10 => 7   6   5   4       3   2   1   0
;        X   X   X   MODO    APLITUDE DO CANAL C
;
; MODO      => PODE SER 0=FIXO OU 1=MODULADO
; AMPLITUDE => PODE VARIAR DE 0 A 15  
; ================================================================================================

; ================================================================================================
; Para tocar o som efetivamente, informamos nosso MIXER (R7) que queremos ativar os canais de som 
; configurados acima. segue modelo do registrador 7 
;
; R7 => 7       6       5       4       3       2   1   0
;       DIRECAO DIRECAO RUIDO   RUIDO   RUIDO   SOM SOM SOM
;       PORTA B PORTA A C       B       A       C   B   A
;
; IMPORTANTE! => CARREGUE SEMPRE OS BITS 7 E 6 COM 1 E 0 OU VOCE PODE DANIFICAR O PSG DO SEU MSX!
; IMPORTANTE! => NESSE REGISTRADOR VC LIGA OS CANAIS COM 0 E DESLIGA COM 1. 
; ================================================================================================

; ================================================================================================
; Setar um registrador
; ================================================================================================
; A => Registrador no AY38910 que sera atualizado
; E => Dados a serem enviados ao registrador do AY38910
; ================================================================================================
; Altera => Nada
; ================================================================================================
SetRegister:
	call WRTPSG  
ret
; ===============================================================================================

; ================================================================================================
; PlayNote
; ================================================================================================
; A => Frequencia do som 
; ================================================================================================
; Altera => Nada
; ================================================================================================
PlayNote:
	cp 0
	jp z,Mudo					; se a frequencia eh zero, desligamos os canais
	ld e,a						; pegamos o periodo 
	ld a,0						; setamos no byte menos significativo
	call SetRegister			; setamos o periodo do canal A
	ld e,%00000000				; zeramos os bytes mais significativos do periodo
	ld a,1						; setamos o byte mais significativo
	call SetRegister			; setamos o periodo do canal A
	ld e,%00001111				; setamos modo fixo e volume 15 
	ld a,8						; setamos a amplitude
	call SetRegister
	ld e,%10111110				; liga o canal A
	ld a,7						; Mixer
	call SetRegister			; setamos o mixer
ret

Mudo:
	ld e,%10111111				; desliga todos os canais 
	ld a,7		               	; mixer 
	call SetRegister			; setamos o mixer
ret
; ================================================================================================