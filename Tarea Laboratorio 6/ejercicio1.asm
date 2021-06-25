; LEER UNA CADENA DE TEXTO DESDE TECLADO Y ESCRIBIRLA EN LA CONSOLA DE MS-DOS
; MAIN
	org 	100h

	section	.text

	MOV	CX,5
	call 	LeerCadena
	call 	EsperarTecla

	int 	20h

	section	.data

	passw	db	"cesar"
	bueno	db	"BIENVENIDO$"
	malo	db	"INCORRECTO$"

; FUNCIONES

; Permite leer un carácter de la entrada estándar
; Parámetros:   AH: 07h         
; Salida:       AL: caracter ASCII leído
EsperarTecla:
        mov     AH, 07h         
        int     21h
        ret


; Leer cadena de texto desde el teclado
; Salida:       SI: longitud de la cadena
LeerCadena:
        xor     SI, SI          ; SI = 0
while:  
        call    EsperarTecla    ; retorna un caracter en AL
        cmp     AL, 0x0D        ; comparar AL con caracter EnterKey
        je      VerificarCadena           ; si AL == EnterKey, saltar a exit
        mov     [300h+SI], AL   ; guardar caracter en memoria
        inc     SI              ; SI++
        jmp     while           ; saltar a while


VerificarCadena:
	;mov 	byte [300h+SI], "$"	; agregar $ al final de la cadena
	xor     SI, SI          ; SI = 0
	xor     DI, DI          ; DI = 0
	jmp 	for
for:	
	MOV AL, [passw+DI]
	cmp AL, [300h+SI]
	jne	EscribirCadenaMala
	INC SI
	INC DI
	loop for

        call EscribirCadenaBuena;
	jmp exit



; Permite escribir en la salida estándar una cadena de caracteres o string, este
; debe tener como terminación el carácter “$”
; Parámetros:	AH: 09h 	DX: dirección de la celda de memoria inicial de la cadena
EscribirCadenaBuena:
	mov 	AH, 09h
	mov 	DX, bueno	; dirección inicial de nuestra cadena
	int 	21h
	ret


EscribirCadenaMala:
	mov 	AH, 09h
	mov 	DX, malo	; dirección inicial de nuestra cadena
	int 	21h
	ret

exit:
	int 20h;