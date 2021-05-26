	org	100h

	section	.text

	xor	AX, AX	; Esto limpia nuestro registro AX
	xor	CX, CX	; Esto limpia nuestro registro CX
	xor	SI, SI	; Esto limpia nuestro puntero SI
	xor	DI, DI	; Esto limpia nuestro puntero DI
	xor	BX, BX ; Esto limpia nuestro puntero BI

	mov	CL, cst 
	mov	SI, 0d;
	mov	DI, 0d;
	mov	BL, 02d;

	call	iterador

	int	20h	; Aqui termina el codigo



	;int	20h	; Aqui termina el codigo


;Esta es la subrutina principal
iterador:

	cmp	CL, 0
	JE	ret

	mov	AL, [array+[aux]]
	div	BL

	cmp	AH, 0d	; Compara el residuo guardado en AH con 0
	JE	par	; Si son iguales, "par", ya que el residuo es 0
	JNE	impar	; Si no son iguales, saltara a "impar", ya que el residuo no es 0

	;loop	iterador ; Mientras CX no sea 0, esto va a seguir llamando al iterador	



;Esta es la subrutina que se encarga de subir y redirigir el valor par a donde corresponde
par:
	mov	[0300h+SI], [array+[aux]]

	inc	SI
	dec	CL
	add	[aux], 1d

	jmp	iterador	; Se regresa a la iteracion

;Esta es la subrutina que se encarga de subir y redirigir el valor impar a donde corresponde
impar:

	mov	[0320h+DI], [array+[aux]]

	inc	DI
	dec	CL
	add	[aux], 1d

	jmp	iterador	; Se regresa a la iteracion

	section	.data

array	db	10,09,08,07,05  ; Este es el arreglo de numeros de 1 bits que hemos creado
cst	equ	5 ; Este es un valor constante que nos indica cuantos numeros hay en el arreglo
aux	db	0 ; Esta variable nos ayudara a llevar un control de por cual posicion vamos