;DIRECTIVAS
extern printf
extern malloc

section .text
global mostrar_abb


section .data
llave1 db "{",0
llave2 db "}",0
valor db " %d ",0


;TRABAJAMOS EN IA32, LOS PARAMETROS VAN POR PILA, VALOR DE DEVOLUCI�N DE LA FUNCI�N VA EN EAX!
;TAMA�OS DE LOS VALORES: PUNTERO 4 BYTES


mostrar_abb: 
;PROTOTIPO: void? ? mostrar_abb(nodo_abb? *a);

;void mostrar_abb(nodo_abb *a)
;	if(a!= NULL)
		;printf("\n{");
		;printf("%d - ", a->valor);
		;printf("}");
		;mostrar_abb1(a->izq);
		;mostrar_abb1(a->der);
	
;ARMO CONTEXTO
	PUSH EBP
	MOV EBP, ESP

	;AGARRO EL PUNTERO
	MOV ESI,[EBP+8]	  	;0 INICIO EBP + 4 BYTES DEL EIP + 4 BYTES DEL EBP = 8 BYTES
	
	;IMPRIMO LA LLAVE DE APERTURA 
	PUSH llave1
	CALL printf
	ADD ESP, 4			;LIMPIO LA PILA
	
	;ME FIJO SI EL NODO ES NULO, SI LO ES SALGO!
	CMP ESI, 0 ;
	JNE IMPRIMIR
	
	;IMPRIMO LA LLAVE DE CIERRE
	PUSH llave2
	CALL printf
	ADD ESP, 4			;LIMPIO LA PILA
	
	;SALGO
	MOV ESP, EBP
	POP EBP
	RET

IMPRIMIR:
	
	MOV EDI, [ESI]		;MANDO EL VALOR A IMPRIMIR A EDI
	PUSH EDI 		;PUSHEO EL VALOR A IMPRIMIR
	PUSH valor ;PUSHEO EL FORMATO
	CALL printf	;LLAMO A PRINTF
	ADD ESP, 8 ;LIMPIO LA PILA

			

	;HAGO LAS LLAMADAS RECURSIVAS!
	PUSH ESI	;PUSHEO EL PUNTERO ACTUAL
	MOV ECX, [ESI+4]
	PUSH ECX ;MANDO POR PARAMETRO AL PUNTERO AL NODO IZQUIERDO
	CALL mostrar_abb
	ADD ESP, 4
	POP ESI 	;RECUPERO EL PUNTERO ACTUAL

	
	PUSH ESI	;PUSHEO EL PUNTERO ACTUAL
	MOV ECX, [ESI+8]
	PUSH ECX ;MANDO POR PARAMETRO AL PUNTERO AL NODO DERECHO
	CALL mostrar_abb
	ADD ESP, 4
	POP ESI

	;IMPRIMO LA LLAVE DE CIERRE
	PUSH llave2
	CALL printf
	ADD ESP, 4			;LIMPIO LA PILA
	
	
	;SALGO
	MOV ESP, EBP
	POP EBP
	RET
	