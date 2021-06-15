org	100h


	;Aqui va todo el codigo principal
	section	.text

	;Funcion main
	xor	AX, AX	; aqui limpiamos nuestro registro AX
	xor	BX, BX	; aqui limpiamos nuestro registro BX
	xor	CX, CX	; aqui limpiamos nuestro registro CX
	xor	DX, DX	; aqui limpiamos nuestro registro DX
	xor	SI, SI	; aqui limpiamos nuestro puntero SI

	;Aqui llamaremos al modo texto con las especificaciones deseadas
	call modotexto ; solo debemos de llamarlo una vez, sino se borrara/limpiara toda la pantalla

	;ESCRIBIENDO PRIMER NOMBRE

	;Seteando los contadores en 0
	MOV	SI, 0
	MOV	DI, 0d

	call movercursor1	; esta funcion se encarga de mover el cursor a la posicion en que se escribira el primer nombre
	call escribirprimer_nombre	; esta funcion se encarga de escribir todo el primer nombre de una sola vez, no va caracter por caracter

	;ESCRIBIENDO SEGUNDO NOMBRE

	;Seteando los contadores en 0
	MOV	SI, 0
	MOV	DI, 0d

	call movercursor2	; esta funcion se encarga de mover el cursor a la posicion en que se escribira el segundo nombre
	call escribirsegundo_nombre	; esta funcion se encarga de escribir todo el segundo nombre de una sola vez, no va caracter por caracter

	;ESCRIBIENDO PRIMER APELLIDO

	;Seteando los contadores en 0
	MOV	SI, 0
	MOV	DI, 0d

	call movercursor3	; esta funcion se encarga de mover el cursor a la posicion en que se escribira el primer apellido
	call escribirprimer_apellido	; esta funcion se encarga de escribir todo el primer apellido de una sola vez, no va caracter por caracter

	;ESCRIBIENDO SEGUNDO APELLIDO

	;Seteando los contadores en 0
	MOV	SI, 0
	MOV	DI, 0d

	call movercursor4	; esta funcion se encarga de mover el cursor a la posicion en que se escribira el segundo apellido
	call escribirsegundo_apellido	; esta funcion se encarga de escribir todo el segundo apellido de una sola vez, no va caracter por caracter



	;Terminando el programa
	call esperartecla	; esta funcion es nuestra señal para terminar el programa
	call exit	; con esta funcion se termina el programa

	;Aqui van todas las declaraciones de variables
	section	.data

	primer_nombre DB "Cesar$"
	segundo_nombre DB "Eduardo$"
	primer_apellido DB "Esperanza$"
	segundo_apellido DB "Ulloa$"


	;Aqui van todas las funciones

modotexto: 
        MOV AH, 0h ; activa el modo video/texto
        MOV AL, 03h ; modo gráfico deseado, 03h denota un tamaño de pantalla de 80x25 (80 columnas, 25 filas)
        INT 10h	; interrupcion del BIOS
        RET

movercursor1:
        MOV AH, 02h ; esto establece que queremos posicionar el cursor en pantalla.
	MOV DH, 10 ; fila en la que se mostrará el cursor
        MOV DL, 20 ; columna en la que se mostrará el cursor
        MOV BH, 0h ; número de página del cursor
        INT 10h	; interrupcion del BIOS
        RET

movercursor2:
        MOV AH, 02h ; esto establece que queremos posicionar el cursor en pantalla.
	MOV DH, 12 ; fila en la que se mostrará el cursor
        MOV DL, 20 ; columna en la que se mostrará el cursor
        MOV BH, 0h ; número de página del cursor
        INT 10h	; interrupcion del BIOS
        RET

movercursor3:
        MOV AH, 02h ; esto establece que queremos posicionar el cursor en pantalla.
	MOV DH, 14 ; fila en la que se mostrará el cursor
        MOV DL, 20 ; columna en la que se mostrará el cursor
        MOV BH, 0h ; número de página del cursor
        INT 10h	; interrupcion del BIOS
        RET

movercursor4:
        MOV AH, 02h ; esto establece que queremos posicionar el cursor en pantalla.
	MOV DH, 16 ; fila en la que se mostrará el cursor
        MOV DL, 20 ; columna en la que se mostrará el cursor
        MOV BH, 0h ; número de página del cursor
        INT 10h	; interrupcion del BIOS
        RET


escribirprimer_nombre: ;utilizando interrupcion DOS
        MOV AH, 09h ; esto establece que queremos que se escriba una cadena en pantalla según posición del cursor
        MOV DX, primer_nombre ; cadena que vamos a imprimir, debe ir sin corchetes
        INT 21h	; interrupcion del DOS
        RET

escribirsegundo_nombre: ;utilizando interrupcion DOS
        MOV AH, 09h ; esto establece que queremos que se escriba una cadena en pantalla según posición del cursor
        MOV DX, segundo_nombre ; cadena que vamos a imprimir, debe ir sin corchetes
        INT 21h	; interrupcion del DOS
        RET

escribirprimer_apellido: ;utilizando interrupcion DOS
        MOV AH, 09h ; esto establece que queremos que se escriba una cadena en pantalla según posición del cursor
        MOV DX, primer_apellido ; cadena que vamos a imprimir, debe ir sin corchetes
        INT 21h	; interrupcion del DOS
        RET

escribirsegundo_apellido: ;utilizando interrupcion DOS
        MOV AH, 09h ; esto establece que queremos que se escriba una cadena en pantalla según posición del cursor
        MOV DX, segundo_apellido ; cadena que vamos a imprimir, debe ir sin corchetes
        INT 21h	; interrupcion del DOS
        RET

esperartecla:
        MOV AH, 00h ; esto establece que se espera buffer del teclado para avanzar en la siguiente instrucción
        INT 16h

        ret
exit:
        int 20h
