	org	100h


; FUNCION MAIN
	section	.text

	xor	AX, AX	; Esto limpia nuestro registro AX
	xor	CX, CX	; Esto limpia nuestro registro CX
	xor	BX, BX	; Esto limpia nuestro puntero BX
	xor	DX,DX	; Eso limpia nuestro registro DX
	xor	SI, SI	; Esto limpia nuestro puntero SI
	xor	BP, BP	; Esto limpia nuestro puntero BP
	xor	DI, DI	; Esto limpia nuestro puntero DI

	mov	BP, array	; En este puntero vamos a guardar el valor original que tiene el array

	mov	BL, divisor	; Aqui mandamos al registro BL el valor de nuestro divisor
	mov	SI, 0		; Aqui inicializamos el contador que nos dira en cual iteracion vamos
	mov	DI, 0		; Aqui inicializamos el valor auxiliar que nos ayudara a subir el indice de posicion de los pares e impares

	call	Iterador	; LLamamos a la funcion Iterador con Call, para que haga el algoritmo necesario y luego retorne a este punto

	;Justo a esta parte del codigo main es que el RET nos estaria retornando

	int	20h	; Aqui termina el codigo



; DATOS
	section	.data

array	db	10,09,08   ;,07,06,05,04,03,02,01 ; Este es el arreglo de numeros de 1 bits que hemos creado
divisor	equ	2 ; Este es un valor constante que nos indica cual es el valor de nuestro divisor


; FUNCIONES


;Esta es la subrutina principal
Iterador:

	cmp	SI, 3  ;10	; Aqui comparamos nuestro registro contador para ver si ya llegamos a nuestro limite de datos a iterar
	JE	return_function	; Aqui vamos a decir, de que en caso de que el contador sea igual al valor que hemos dicho, hara un RET y regresara al Main
			; De no ser igual, va a continuar su curso


	mov	AX, 0		; Aqui nos aseguramos que AX sea igual a 0 para que no tenga ningun valor innecesario que acarree
	mov	AL, [BP+SI]	; Aqui vamos a tomar el contador y se lo sumaremos a la posicion original del array, para luego mandar a AL el numero que se encuentre en esa posicion del array
	mov	BH, AL		; Guardamos ese valor del array en el registro BH para poder guardarlo despues en la celda de memoria que corresponda
	div	BL		; El registro AL es el dividendo y BL es el divisor, esto nos dara su resultado en AL y el residuo en AH
	inc	SI		; Ahora incrementamos el contador para saber que ya pasamos del primer valor del array

	cmp	AH, 0		; Compara el residuo guardado en AH con 0
	JE	par		; Si son iguales saltara a "par", ya que el residuo es 0
	JNE	impar		; Si no son iguales, saltara a "impar", ya que el residuo no es 0




;Esta es la subrutina que se encarga de cargar en la celda de memoria 300h el valor par
par:
	mov	DI, CX		; EN CX vamos a guardar el contador de posicion de los pares. lo copiamos a DI
	mov	[300h+DI], BH	; Ahora movemos el valor en BH (el cual es el numero actualmente evaluado) hacia la posicion de memoria que indique el contador de posicion

	inc	DI		; Incrementamos en 1 a DI para saber que ahora avanzamos en la posicion de los pares
	mov	CX, DI		; Volvemos a guardar el contador de posicion (ya actualizado) de los pares en CX

	jmp	Iterador	; Se regresa a la funcion de iteracion

;Esta es la subrutina que se encarga de cargar en la celda de memoria 320h el valor impar
impar:

	mov	DI, DX		; EN DX vamos a guardar el contador de posicion de los impares. lo copiamos a DI
	mov	[320h+DI], BH	; Ahora movemos el valor en BH (el cual es el numero actualmente evaluado) hacia la posicion de memoria que indique el contador de posicion


	inc	DI		; Incrementamos en 1 a DI para saber que ahora avanzamos en la posicion de los impares
	mov	DX, DI		; Volvemos a guardar el contador de posicion (ya actualizado) de los impares en CX

	jmp	Iterador	; Se regresa a la funcion de iteracion
	
;Esta funcion nos retornara al main
return_function:

	ret 		; Ponemos aqui el RET debido a que el RET no se puede colocar como argumento de un Salto

