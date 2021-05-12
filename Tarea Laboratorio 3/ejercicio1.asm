	org	100h

	section	.text

	xor	AX, AX	; limpio AX para que sin valor de otras operaciones
	xor	CX, CX	; limpio CX para que sin valor de otras operaciones
	mov	CX, 8d   ; Inicializo CX como mi contador que ira disminuyendo hasta llegar a 0
	; Mi carnet es 00077618
	; La sumatoria total es 29d y su equivalente es 1Dh  
	; Ire mandando mi carnet, un digito a la vez, a unas celdas de memoria, de la 200h a la 207h
	mov	byte [200h], 0d 
	mov	byte [201h], 0d
	mov	byte [202h], 0d
	mov	byte [203h], 7d
	mov	byte [204h], 7d
	mov	byte [205h], 6d
	mov	byte [206h], 1d
	mov	byte [207h], 8d

	mov	BX, 200h ;Le mando a BX el valor donde estara el primer digito de mi carnet

	jmp	sumatoria ;Aqui mando a llamar al pedazo de codigo donde tengo la logica a trabajar

sumatoria:

	add	AL, [BX] ; Sumo a AL el valor que esta almacenado en la direccion de memoria que se guarda en BX (de 200h a 207h)
	add	BX, 1h ; Le sumo 1 a el valor dentro de BX para asi ir avanzando posiciones de memoria (de 200 a 207)
	loop	sumatoria ; Hago un loop hasta que CX se haga 0, esto pasa debido a que le resto 1 por cada iteracion hecha
	; La iteracion solo se hara 8 veces, debido a que es la cantidad de numero en mi carnet (que utilice como mi contador decreciente)

;Aqui ya se salio del loop y de la funcion "sumatoria", se sigue la logica del codigo restante

	mov	CL, 8d ;Poner en CL el numero de la cantidad de datos que ocuparemos como divisor (numero de digitos de mi carnet)
	div	CL ; Mando a CL (vale 8d y tiene un size de 8 bits) a dividir AX (que tiene 16 bits)
	; La division de 29 entre 8 (numero de digitos en mi carnet) da como cociente 3 y 5 de residuo
	mov	byte [20Ah], AL ; Mando a la celda de memoria 20Ah el cociente de la division almacenado en AL
	int	20h ; Finaliza el programa


