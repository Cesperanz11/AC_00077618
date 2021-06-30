; Ejercicio de leer una cadena de texto desde el teclado y compararla con una cadena ya establecida con MS-DOS

	org 	100h



; SECCION DE CODIGO
	section	.text

	MOV	CX,5			; Mandamos a CX el valor de 5, esto nos servira como nuestro contador (usamos 5 ya que nuestra passwrd debe ser de 5 letras)
	call 	LeerCadena		; Mandamos a llamar a la funcion que leera la cadena y hara toda la logica de comparacion
	
	; Aqui finaliza el programa	; No mandamos a llamar a int 20h ya que cada escenario posible ya maneja su funcion exit


; SECCION DE DATOS

	section	.data

	passw	db	"cesar"		; Este string funcionara como nuestra passwrd
	bueno	db	"BIENVENIDO$"	; Este string sera el mensaje que vamos a retornar si la cadena es igual a la passwd
	malo	db	"INCORRECTO$"	; Este string sera el mensaje que vamos a retornar si la cadena no es igual a la passwd



; FUNCIONES


; Permite leer un carácter desde el teclado
EsperarTecla:
        mov     AH, 07h         ; Mandamos a AH el valor de 07h para hacerle saber a la cpu que queremos hacer
        int     21h		; Mandamos a llamar a la int 21 del DOS

        ret			; Regresamos a donde nos mandaron a llamar


; Permite leer una cadena de texto desde el teclado hasta darle "Enter"
LeerCadena:
        xor     SI, SI          ; Limpiamos el puntero SI y lo seteamos en 0

while:  
        call    EsperarTecla    ; Mandamos a llamar a EsperarTecla, retornara la tecla y la guardara en AL
        cmp     AL, 0x0D        ; Comparamos AL (letra ingresada) con el codigo del caracter "Enter"
        je      VerificarCadena ; Si AL y "Enter" son iguales, entendemos que la cadena ya fue ingresada y saltamos a VerificarCadena
        mov     [300h+SI], AL   ; Si AL y "Enter" no son iguales, mandamos a guardar el caracter en memoria 
        inc     SI              ; Incrementamos SI en 1
        jmp     while           ; Saltamos a while otra vez


; Permite verificar la cadena ingresada con la passwd que tenemos
VerificarCadena:
	
	xor     SI, SI          ; Limpiamos el puntero SI y lo seteamos en 0
	xor     DI, DI  	; Limpiamos el puntero DI y lo seteamos en 0
	

	jmp 	for		; Saltamos hacia for
	
for:	
	MOV 	AL, [passw+DI]		; Guardamos el AL el caracter de la passwd que corresponda en esta iteracion
	cmp 	AL, [300h+SI]		; Comparamos AL (caracter de passwd actual) con la letra actual de la cadena que ingresamos
	jne	EscribirCadenaMala	; Si AL y la letra actual no son iguales, saltamos a EscribirCadenaMala
	; Si AL y la letra actual son iguales, se sigue el proceso ya que no hay diferencias entre la cadena y la passwd hasta ahorita
	INC 	SI			; Incrementamos SI en 1
	INC 	DI			; Incrementamos DI en 1
	loop 	for			; Hacemos uso del loop hacia for

	;Si se completo la validacion sin errores, es porque la cadena ingresada y la passwd son iguales
	call 	EscribirCadenaBuena	; Mandamos a llamar a EscribirCadenaBuena
	call	EsperarTecla		; Mandamos a llamar a EsperarTecla para que el usuario confirme que esta listo para seguir
	jmp 	exit			; Mandamos a llamar a la funcion que terminara el programa



; Permite escribir un mensaje en pantalla en caso de que la cadena ingresada sea correcta
EscribirCadenaBuena:
	mov 	AH, 09h		; Mandamos a AH el valor de 09h para hacerle saber a la cpu que queremos hacer
	mov 	DX, bueno	; Indicamos cual es el nombre del string a escribir
	int 	21h		; Mandamos a llamar a la int 21 del DOS

	ret			; Regresamos a donde nos mandaron a llamar


; Permite escribir un mensaje en pantalla en caso de que la cadena ingresada no sea correcta
EscribirCadenaMala:
	mov 	AH, 09h		; Mandamos a AH el valor de 09h para hacerle saber a la cpu que queremos hacer
	mov 	DX, malo	; Indicamos cual es el nombre del string a escribir
	int 	21h		; Mandamos a llamar a la int 21 del DOS
	
	call	EsperarTecla	; Mandamos a llamar a EsperarTecla para que el usuario confirme que esta listo para seguir
	jmp 	exit		; Mandamos a llamar a la funcion que terminara el programa


exit:
	int 20h			; Finaliza el programa