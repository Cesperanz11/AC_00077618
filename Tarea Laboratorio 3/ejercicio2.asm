	org	100h

	section	.text

	xor	AX, AX ; Limpio AX de cualquier valor que haya quedado almacenado ahi
	xor	CX, CX ; Limpio CX de cualquier valor que haya quedado almacenado ahi
	mov	CL, 5d ; Inicializamos nuestro contador en CL
	mov	AL, 1d ; Con esto nos aseguramos de que AL (donde se guardan las multiplicaciones, tenga un colchon
	; ya que si tuviese un 0, todo numero que mandasemos a multiplicar se haria 0)
	call	factorial ; Mandamos a llamar a la funcion que tiene el codigo necesario

	; Aqui en esta instancia ya tenemos AL con casi todo el resultado de (n)! pero le falta 0!, que vale 1
	; Es algo tribial pero no deja de ser necesario matematicamente
	mov	CH, 1d ; Ocupo CH para marcar la diferencia de que es un numero distinto a los utilizados antes
	mul	CH

	mov	[20Bh], AL ; Mandamos el resultado de n! ya completo a la celda de memoria 20Bh (da 120d equivalente a 78h)

	jmp	exit ; Nos vamos a un apartado especial en el cual solo se encuentra el codigo que finaliza el programa

factorial:
	mul	CL ; Multiplicamos el valor actual almacenado en CL con el que ya se encuentra en AL (ambos son de 8 bits)
	sub	CL, 1d ; Se le resta uno al contador, este nos hace ver que pasamos de n! a (n-1)!
	cmp	CL, 0d 
	JNZ	factorial ; Aqui usamos Jump Not Zero para iterar otra vez en caso de que CL no sea 0 aun
	; Comparamos el valor actual de Cl con 0, si es 0 se regresa al 'main' para ser tratado especialmente
	; Si Cl aun no es 0, entonces se seguira iterando
	ret ; Si ya no se ejecuto JNZ, entonces retornamos al 'main'

exit:
	int	20h ; Finaliza el programa
