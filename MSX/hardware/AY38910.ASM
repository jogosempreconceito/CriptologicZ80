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
; Tabela de conversao de notas em frequencias
; ================================================================================================
A0  EQU 27
B0  EQU 31
C1  EQU 33 
D1  EQU 37
E1  EQU 41
F1  EQU 43
G1  EQU 49
A1  EQU 55
B1  EQU 62
C2  EQU 65
D2  EQU 73
E2  EQU 82
F2  EQU 87
G2  EQU 98
A2  EQU 110
B2  EQU 123
C3  EQU 130
D3  EQU 146
E3  EQU 164
F3  EQU 174
G3  EQU 196
A3  EQU 220
B3  EQU 246
C4  EQU 261
D4  EQU 293
E4  EQU 329 
F4  EQU 349
G4  EQU 392
A4  EQU 440
B4  EQU 493
C5  EQU 523
D5  EQU 587
E5  EQU 659
F5  EQU 698
G5  EQU 783
A5  EQU 880
B5  EQU 987
C6  EQU 1046
D6  EQU 1174
E6  EQU 1318
F6  EQU 1396
G6  EQU 1568
A6  EQU 1760
B6  EQU 1975
C7  EQU 2093
D7  EQU 2349
E7  EQU 2693
F7  EQU 2793
G7  EQU 3136
A7  EQU 3520
B7  EQU 3951
C8  EQU 4186
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
; Play Note
; ================================================================================================
; B => Nota a ser tocada (LSB)
; C => Nota a ser tocada (MSB)
; ================================================================================================
; Altera => Nada
; ================================================================================================
PlayNote:
    ; ========================
    ; FREQUENCIA LSB
    ; ========================
    ld a,0                      ; CARREGA BITS MENOS SIGNIFICATIVOS DA FREQUENCIA
    ld e,b                      ; CARREGA VALOR
    call SetRegister            ; CARREGA REGISTRADOR R0
    ; ========================
    ; FREQUENCIA MSB 
    ; ========================
    ld a,1                      ; CARREGA BITS MAIS SIGNIFICATIVOS DA FREQUENCIA 
    ld e,c                      ; CARREGA FREQUENCIA 
    call SetRegister            ; CARREGA REGISTRADOR R1
    ; ========================
    ; AMPLITUDE
    ; ========================
    ld a,8                      ; CARREGA O ENVELOPE COM MODO FIXO E AMPLITUDE ALTA
    ld e,%00001111              ; CARREGA VALOR 
    call SetRegister            ; CARREGA REGISTRADOR R8
    ; ========================
    ; MIXER
    ; ========================    
    ld a,7                      ; CARREGA MIXER LIGANDO CANAL A
    ld e, %10111110             ; CARREGA VALOR
    call SetRegister            ; CARREGA REGISTRADOR R7
    ; ========================
    ; TOCA A NOTA PELO PERIODO
    ; ========================    
    ld de,12000                 ; carrego um valor de 16 bits 
    loopNote:         
      nop                       ; nao faco nada
      dec de                    ; decremento o loop 
      ld a,d                    ; ajusto os bits para a comparacao 
      or e                      ; ajusto os bits para a comparacao 
      jp nz,loopNote            ; se nao for zero, volto ao loop 
    ; ========================
    ; SILENCIO
    ; ========================    
    ld a,7                      ; CARREGA MIXER LIGANDO CANAL A
    ld e, %10111111             ; CARREGA VALOR
    call SetRegister            ; CARREGA REGISTRADOR R7    
  ret
; ===============================================================================================
