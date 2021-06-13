org	100h


	;Aqui va todo el codigo principal
	section	.text

	;Funcion main
	xor	AX, AX
	xor	BX, BX
	xor	CX, CX
	xor	DX, DX
	xor	SI, SI

	

	MOV	SI, 0
	MOV	DI, 0d

	;Escribiendo primer nombre

	call modotexto
	call movercursor1
	call escribirsegundoapellido

	MOV	SI, 0
	MOV	DI, 0d

	;Escribiendo segundo nombre

	call modotexto
	call movercursor2
	call escribirsegundonombre

	MOV	SI, 0
	MOV	DI, 0d

	;Escribiendo primer apellido

	call modotexto
	call movercursor1
	call escribirprimerapellido

	;Terminando el programa
	call esperartecla
	call exit

	;Aqui van todas las declaraciones de variables
	section	.data

	primernombre DB "Cesar$"
	segundonombre DB "Eduardo$"
	primerapellido DB "Esperanza$"
	segundoapellido DB "Ulloa$"


	;Aqui van todas las funciones

modotexto: 
        MOV AH, 0h ; activa modo texto
        MOV AL, 03h ; modo gráfico deseado, 03h denota un tamaño de 80x25 (80 columnas, 25 filas)
        INT 10h
        RET

movercursor1:
        MOV AH, 02h ; posiciona el cursor en pantalla.
	MOV DH, 10 ;fila en la que se mostrará el cursor
        MOV DL, 20 ;columna en la que se mostrará el cursor
        MOV BH, 0h ; número de página
        INT 10h
        RET

movercursor2:
        MOV AH, 02h ; posiciona el cursor en pantalla.
	MOV DH, 12 ;fila en la que se mostrará el cursor
        MOV DL, 22 ;columna en la que se mostrará el cursor
        MOV BH, 1h ; número de página
        INT 10h
        RET

movercursor3:
        MOV AH, 02h ; posiciona el cursor en pantalla.
	MOV DH, 14 ;fila en la que se mostrará el cursor
        MOV DL, 24 ;columna en la que se mostrará el cursor
        MOV BH, 2h ; número de página
        INT 10h
        RET

escribirprimernombre: ;utilizando interrupcion DOS
        MOV AH, 09h ; escribe cadena en pantalla según posición del cursor
        MOV DX, primernombre ; cadena que vamos a imprimir, debe ir sin corchetes
        INT 21h
        RET

escribirsegundonombre: ;utilizando interrupcion DOS
        MOV AH, 09h ; escribe cadena en pantalla según posición del cursor
        MOV DX, segundonombre ; cadena que vamos a imprimir, debe ir sin corchetes
        INT 21h
        RET

escribirprimerapellido: ;utilizando interrupcion DOS
        MOV AH, 09h ; escribe cadena en pantalla según posición del cursor
        MOV DX, primerapellido ; cadena que vamos a imprimir, debe ir sin corchetes
        INT 21h
        RET

escribirsegundoapellido: ;utilizando interrupcion DOS
        MOV AH, 09h ; escribe cadena en pantalla según posición del cursor
        MOV DX, segundoapellido ; cadena que vamos a imprimir, debe ir sin corchetes
        INT 21h
        RET

esperartecla:
        MOV AH, 00h ; espera buffer del teclado para avanzar en la siguiente instrucción
        INT 16h

        ret
exit:
        int 20h
