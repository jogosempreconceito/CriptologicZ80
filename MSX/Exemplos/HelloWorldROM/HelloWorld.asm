; =======================================================================
; Teste de chamadas de funcoes gerais
; Manoel Neto 2019-0923
; =======================================================================
org &4000
  db "AB"
  dw ProgramStart
  db 00,00,00,00,00

include "BiosMSX.asm"

ProgramStart:
  call LimparTela
  ld hl, Message
  call PrintString
  call NovaLinha
  DI
  Halt

  include "Library.asm"

Message:
  db "Ola Mundo!",13

org &C000 ; PAD para 32K
