	org	100h

	section	.text

	;Primero insertare las iniciales de mi nombre en las memorias asignadas;
	;Mi nombre es Cesar Eduardo Esperanza Ulloa

	mov	byte [200h], "C"
	mov	byte [201h], "E"
	mov	byte [202h], "E"
	mov	byte [203h], "U"

	;Haciendo direccionamiento directo o absoluto (de una celda de memoria a un registro o viceversa)
	;Mandar info de 200h a AX

	mov	AX, [200h]

	;Haciendo direccionamiento indirecto por registro 
	;(de una celda de memoria[BX] a un registro o viceversa, ocupando BX como el lugar que tiene guardada la direccion de memoria a ocupar)
	;Mandar info de 201h a CX

	mov	BX, [201h]	;Preparamos el registro base con la info necesitada

	mov	CX, [BX]

	;Haciendo direccionamiento indirecto base + indice	
	;(de una celda de memoria[BX+DI/SI] a un registro o viceversa, 
	; ocupando BX como el lugar que tiene guardada unaa direccion de memoria al igual que DI/SI, y sumadas dan la direccion de memoria a ocupar)
	;Mandar info de 202h a DX
	mov	SI, 1h  ;Teniendo que BX tiene a 201h, le daremos 1h a DI para que sumen 202h

	mov	DX, [BX + SI]

	;Haciendo direccionamiento relativo por registro
	;(de una celda de memoria[BX+ memoria] a un registro o viceversa, 
	; ocupando BX como el lugar que tiene guardada unaa direccion de memoria, y sumadas con la direccion de memoria adicional, resultan en la direccion de memoria a ocupar)
	;Mandar info de 203h a DI

	mov	DI, [BX + 2h]

	int	20h