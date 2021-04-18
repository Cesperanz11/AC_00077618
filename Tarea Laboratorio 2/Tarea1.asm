	org	100h

	section	.text

	;Primero insertare las iniciales de mi nombre en las memorias asignadas;
	;Mi nombre es Cesar Eduardo Esperanza Ulloa

	mov	byte [200h], "C"
	mov	byte [201h], "E"
	mov	byte [202h], "E"
	mov	byte [203h], "U"

	int	20h