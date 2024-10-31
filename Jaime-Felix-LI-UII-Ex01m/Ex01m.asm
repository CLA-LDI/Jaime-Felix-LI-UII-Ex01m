					TITLE	Examen Unidad II Tipo m
					PAGE	60, 132

; Incluir las macros
Include Macros.inc

; Prototipos de llamadas al sistema operativo
GetStdHandle	PROTO	:QWORD
ReadConsoleW	PROTO	:QWORD,	:QWORD, :QWORD, :QWORD, :QWORD
WriteConsoleW	PROTO	:QWORD,	:QWORD, :QWORD, :QWORD, :QWORD
ExitProcess		PROTO	CodigoSalida:QWORD

				.DATA
; Definir las variables N y sumaas� como los mensajes de entrada correspondientes y el mensaje de salida
N				QWORD	0
suma			QWORD	0
MenEnt01		WORD	'P', 'r', 'o', 'p', 'o', 'r', 'c', 'i', 'o', 'n', 'e', ' ', 'e', 'l', ' ', 'v', 'a', 'l', 'o', 'r', ' ', 'd', 'e', ' ', 'N', ':', ' '
MenSal01		WORD	'L', 'a', ' ', 's', 'u', 'm', 'a', ' ', 'e', 's', ':', ' '

; Variables utilizadas por las llamadas al sistema
ManejadorE		QWORD	?
ManejadorS		QWORD	?
Caracteres		QWORD	?
Texto			WORD	13 DUP ( ? )				; Variable temporal para conversi�n Entero - Cadena, Cadena - Entero
SaltoLinea		WORD	13, 10
STD_INPUT		EQU		-10
STD_OUTPUT		EQU		-11

				.CODE
Principal		PROC

				; Alinear espacio en la pila
				SUB		RSP, 40

				; Obtener manejador est�ndar del teclado
				MOV		RCX, STD_INPUT
				CALL	GetStdHandle
				MOV		ManejadorE, RAX

				; Obtener manejador est�ndar de la consola
				MOV		RCX, STD_OUTPUT
				CALL	GetStdHandle
				MOV		ManejadorS, RAX

				; Solicitar la variable N
				MOV		RCX, ManejadorS				; Manejador de la consola donde se escribe
				LEA		RDX, MenEnt01				; Direcci�n de la cadena a escribir
				MOV		R8, LENGTHOF MenEnt01		; N�mero de caracteres a escribir
				LEA		R9, Caracteres				; Direcci�n de la variable donde se guarda el total de caracteres escrito
				MOV		R10, 0						; Reservado para uso futuro
				CALL	WriteConsoleW

				MOV		RCX, ManejadorE				; Manejador del teclado donde se lee la cadena
				LEA		RDX, Texto					; Direcci�n de la cadena a leer
				MOV		R8, LENGTHOF Texto			; N�mero de caracteres m�ximo a leer
				LEA		R9, Caracteres				; Direcci�n de la variable donde se guarda el total de caracteres le�dos
				MOV		R10, 0						; Reservado para uso futuro
				CALL	ReadConsoleW
				MacroCadenaAEntero	Texto, N

				; Calcular la suma de los n�meros de 1 a N
				; suma = 1 + 2 + ... + (N - 1) + N

				; Mostrar el mensaje de salida
				MOV		RCX, ManejadorS				; Manejador de la consola donde se escribe
				LEA		RDX, MenSal01				; Direcci�n de la cadena a escribir
				MOV		R8, LENGTHOF MenSal01		; N�mero de caracteres a escribir
				LEA		R9, Caracteres				; Direcci�n de la variable donde se guarda el total de caracteres escrito
				MOV		R10, 0						; Reservado para uso futuro
				CALL	WriteConsoleW

				; Mostrar el valor de suma

				; Salto de l�nea
				MOV		RCX, ManejadorS				; Manejador de la consola donde se escribe
				LEA		RDX, SaltoLinea				; Direcci�n de la cadena a escribir
				MOV		R8, LENGTHOF SaltoLinea		; N�mero de caracteres a escribir
				LEA		R9, Caracteres				; Direcci�n de la variable donde se guarda el total de caracteres escrito
				MOV		R10, 0						; Reservado para uso futuro
				CALL	WriteConsoleW

				; Salir al sistema operativo
				MOV		RCX, 0
				CALL	ExitProcess

Principal		ENDP
				END