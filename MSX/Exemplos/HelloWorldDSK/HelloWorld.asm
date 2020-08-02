; =======================================================================
; Exemplo de um Disquete
; Manoel Neto 2020-08-02
; =======================================================================
org &810A

  include "BiosMSX.asm"

startCode:
  call LimparTela
  call ERAFNK
  ld hl, Message
  call PrintString
  call NovaLinha
loop:
  jp loop

  include "Library.asm"

Message:
  db "Ola Mundo!",13
