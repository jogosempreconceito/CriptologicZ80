; ================================================================================================
; TMS9918.ASM
; ================================================================================================
; Manoel Neto 2021-03-26
; Biblioteca para uso do chip de video TMS9918
; ================================================================================================

; ================================================================================================
; Portas de comunicação com o Z80
; ================================================================================================
VDPDATA:              equ &98
VDPCONTROL:           equ &99

; ================================================================================================
; O VDP tem 16KB de memória
; ================================================================================================
; From	To	    Conteudo
; 0000	07FF	VRAM: Main Tile Patterns (1/3)
; 0800	0FFF	VRAM: Extra Tile Patterns (2/3)
; 1000	17FF	VRAM: Extra Tile Patterns (3/3)
; 1800	1AFF	VRAM: Tilemap
; 1B00	1B7F	VRAM: Sprite Attributes
; 1B80	1BAF	VRAM: Palette Table
; 2000	37FF	VRAM: Colormap
; 3800	3FFF	VRAM: Sprite Patterns
; ================================================================================================

; ================================================================================================
; Registrador de Status do VDP
; ================================================================================================
; 7  => Quadro (eh setado quando a ultima linha do quadro eh desenhada)
; 6  => Indicador 5s (eh setado quando temos mais de 4 sprites na mesma linha)
; 5  => Indicador de colisao (quando dois sprites tem pelo menos um pixel sobreposto seta)
; 4   3   2   1   0 => Numero do quinto sprite (de 0 a 31)
; ================================================================================================
readStatus: 
   ld	a,(0006h)	; Main-ROM must be selected on page 0000h-3FFFh
   inc	a
   ld	c,a	        ; C = CPU port #99h (VDP reading port#1)
   in	a,(c)	    ; read the value to the port#1
ret
; ================================================================================================