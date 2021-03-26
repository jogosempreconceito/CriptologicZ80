; ================================================================================================
; Emitir  tons nos canais de audio do PSG
; ================================================================================================
; Manoel Neto 2020-09-01
; ================================================================================================
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
; Como esses registradores estao no chip de audio AY3-8910 o Z80 se comunica com ele usando 
; instruções OUT com 3 portas de E/S definidas 
; ================================================================================================
PORTA_ENDERECO: EQU &A0               ; apenas para referencia
PORTA_ESCRITA:  EQU &A1
PORTA_LEITURA:  EQU &A2
; ================================================================================================
org &4000
  db "AB"
  dw ProgramStart
  db 00,00,00,00,00

include "BiosMSX.asm"
include "TabelaNotasFrequencias.asm"
ProgramStart:
  xor a
  call CLS  
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
ret

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
    ld de,12000                  ; carrego um valor de 16 bits 
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

; ================================================================================================
; PADDING 
; ================================================================================================
org &C000 