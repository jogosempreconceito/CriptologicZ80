; ========================================================================================
; VARIAVEIS
; ========================================================================================
NumTamFrase 		equ ramArea	; Variavel => Tamanho da entrada Jog 1
NumAleatorio 		equ ramArea+1	; Variavel => Numero sorteado
NumSorteios 		equ ramArea+2	; Variavel => Numero de sorteios realizados
NumDivIdeal 		equ ramArea+3	; Variavel => Divisor ideal de acordo com a frase
NumContEmb		    equ ramArea+4	; Variavel => Contador de embaralhamento
NumPosSort		    equ ramArea+5	; Variavel => Numero da posicao sorteada
ChaLetraAtual		equ ramArea+7	; Variavel => Letra atual para escrever na frase
NumContTeste		equ ramArea+8	; Variavel => Contar a posicao sendo testada
NumContErros		equ ramArea+9	; Variavel => Contar o numero de erros
ChaTestar   	    equ ramArea+10  ; Variavel => Caracter para testar na frase
StrFrase            equ ramArea+26  ; Frase jogador 1  
StrFraseEmb         equ ramArea+42  ; Frase apos o embarahamento
MatSorteados        equ ramArea+58  ; Matriz de sorteio da frase 
Centenas	        equ ramArea+59  ; contador de centenas
Dezenas             equ ramArea+60  ; contador de dezenas
Unidades            equ ramArea+61  ; contador de unidades