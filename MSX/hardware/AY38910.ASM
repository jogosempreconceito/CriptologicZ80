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
; ================================================================================================
; REGISTRADORES
; ================================================================================================
; 00	Tone Pitch L - Channel A		LLLLLLLL Lower value = Higher pitch
; 01	Tone Pitch H - Channel A		----HHHH Lower value = Higher pitch
; 02	Tone Pitch L - Channel B		LLLLLLLL Lower value = Higher pitch
; 03	Tone Pitch H - Channel B		----HHHH Lower value = Higher pitch
; 04	Tone Pitch L - Channel C		LLLLLLLL Lower value = Higher pitch
; 05	Tone Pitch H - Channel C		----HHHH Lower value = Higher pitch
; 06	Noise Generator	          		---NNNNN Higher = Faster noise
; 07	Mixer 	       					--NNNTTT N=Noise T=Tone (Channel CBACBA 1=mute 0=normal)
; 08	Amplitude - Channel A			---EVVVV E=Envelope (1=Enabled) VVVV=Volume
; 09	Amplitude - Channel B			---EVVVV E=Envelope (1=Enabled) VVVV=Volume
; 10	Amplitude - Channel C			---EVVVV E=Envelope (1=Enabled) VVVV=Volume
; 11	Envelope L (Volume over time) 	LLLLLLLL Lower=Faster Envelope
; 12	Envelope H (Volume over time) 	HHHHHHHH Lower=Faster Envelope
; 13	Envelope Selection				----EEEH E=Envelope number E (See PDF) H=Hold
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
	jp z,Mudo
	ld e,a
	ld a,0
	call SetRegister
	ld e,%00000000
	ld a,1
	call SetRegister
	ld e,%00111110
ret

Mudo:
	ld e,%10111111				; desliga todos os canais 
	ld a,7		               	; Mixer  --NNNTTT (1=off) 
	call SetRegister
ret
; ================================================================================================