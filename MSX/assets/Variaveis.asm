; ========================================================================================
; VARIAVEIS
; ========================================================================================
NumTamFrase 		equ ramArea	    ; Variavel => Tamanho da entrada Jog 1
NumAleatorio 		equ ramArea+1  ; Variavel => Numero sorteado
NumSorteios 		equ ramArea+2	; Variavel => Numero de sorteios realizados
NumDivIdeal 		equ ramArea+3	; Variavel => Divisor ideal de acordo com a frase
NumContEmb		    equ ramArea+4	; Variavel => Contador de embaralhamento
NumPosSort		    equ ramArea+5	; Variavel => Numero da posicao sorteada
ChaLetraAtual		equ ramArea+6	; Variavel => Letra atual para escrever na frase
NumContTeste		equ ramArea+7	; Variavel => Contar a posicao sendo testada
NumContErros		equ ramArea+8	; Variavel => Contar o numero de erros
ChaTestar		    equ ramArea+9	; Variavel => Caracter para testar na frase
StrFrase            equ ramArea+10  ; Variavel => Recebe a frase do jogador 1 
StrFraseEmb         equ ramArea+26  ; Variavel => Recebe a frase embaralhada	 
MatSorteados        equ ramArea+42  ; Variavel => Recebe a Matriz de numeros sorteados	
Centenas            equ ramArea+43  ; Variavel => Usada para imprimir numeros
Dezenas             equ ramArea+45  ; Variavel => Usada para imprimir numeros
Unidades            equ ramArea+47  ; Variavel => Usada para imprimir numeros 