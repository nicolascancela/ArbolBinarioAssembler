extern printf
extern malloc

global agregar_abb
CMAIN:

section .data

section .text
;TRABAJAMOS EN IA32, LOS PARAMETROS VAN POR PILA, VALOR DE DEVOLUCI�N DE LA FUNCI�N VA EN EAX!
;TAMA�OS DE LOS VALORES: PUNTEROS 4 BYTES, VALOR ENTERO DEL NODO 4 BYTES: TOTAL --> 12 BYTES

agregar_abb: 
;PROTOTIPO: struct nodo_abb agregar_abb(struct nodo_abb *arbol, int val);
	PUSH EBP			;ARMO CONTEXTO
	MOV EBP, ESP

	;AGARRO LOS PARAMETROS
	MOV ESI, [EBP+8]	  	;PUNTERO *ARBOL 32 BITS/8 --> 4 BYTES. POSICI�N: 0 INICIO EBP + 4 BYTES DEL EIP + 4 BYTES DEL EBP = 8 BYTES
	MOV EDI, [EBP+12] 		;VALOR A AGREGAR ENVIADO POR PARAMETRO

;CHEQUEO SI EL PUNTERO QUE SE MANDO POR PARAMETRO ES NULO
	CMP ESI, 0
	JNE COMPARAR 			;SINO ES NULO COMPARO LOS VALORES	
	
;SI ES NULO AGREGO EL NODO!
	PUSH 12				;PUSHEO EL TAMA�O DEL NODO
	CALL malloc			;LLAMO A MALLOC
	ADD ESP, 4 			;LIMPIO LA PILA DEL PARAMETRO ENVIADO
	
	CMP EAX, 0 			;ME FIJO SI NO SE PUDO RESERVAR MEMORIA
	JE SALIRCREARNODO		;SINO SE RESERVO SALGO, SINO ARMO EL NODO

;ARMO EL NODO CON LA POSICI�N DE MEMORIA DE EAX DEVUELTA POR MALLOC
	MOV [EAX], EDI   		;PONGO EL VALOR EN EL PUNTERO DE MEMORIA RESERVADO
	MOV DWORD[EAX+4],0 		;PONGO EL PUNTERO IZQUIERDO EN NULO, PORQUE ES HOJA
	MOV DWORD[EAX+8],0 		;PONGO EL PUNTERO DERECHO EN NULO, PORQUE ES HOJA
	
SALIRCREARNODO:	
	;EN EAX QUED� LA DIRECCI�N DE RETORNO DE MALLOC!
	;MOV ESP, EBP
	POP EBP
	RET

COMPARAR:
	CMP [ESI], EDI 			;ME FIJO SI EL VALOR DEL NODO ACTUAL ES MAYOR O MENOR AL VALOR QUE SE INGRES�.
	JE IGUALES
	JG IZQUIERDA
	JL DERECHA
	
IGUALES:
	MOV EAX, ESI 			;PONGO EN RETORNO EL PUNTERO ACTUAL, PORQUE ESE VALOR COINCIDE CON EL NODO
	MOV ESP, EBP			;SALGO
	POP EBP
	RET

IZQUIERDA:
	PUSH ESI
	PUSH EDI 		;MANDO EL VALOR A AGREGAR
	PUSH DWORD[ESI+4]	;MANDO EL PUNTERO AL NODO IZQUIERDO
	CALL agregar_abb	;LLAMADA RECURSIVA
	
	ADD ESP, 4		;LIMPIO LA PILA, NO NECESITO NINGUN VALOR!
	POP EDI			;RECUPERO EL VALOR A AGREGAR
	POP ESI

	MOV [ESI+4], EAX	;ENGANCHO EL PUNTERO IZQUIERDO AL NODO CREADO POR MALLOC!
	
	MOV ESP, EBP		;SALGO	
	POP EBP
	RET

DERECHA:
	PUSH ESI
	PUSH EDI 		;PUSHEO EL VALOR A AGREGAR
	PUSH DWORD[ESI+8] 	;PUSHEO EL PUNTERO AL NODO DERECHO
	CALL agregar_abb	;AGREGAR_ABB ME DEBER�A VOLVER LA POSICI�N DE MEMORIA EN EAX, AHORA DEBERIA VINCULARLA!O LA VINCULO CUANDO CREO EL NODO?
	
	ADD ESP, 4		;LIMPIO LA PILA, NO NECESITO NINGUN VALOR!
	POP EDI
	POP ESI

	MOV [ESI+8], EAX	;ENGANCHO EL PUNTERO DERECHO AL NODO CREADO POR MALLOC!
			
	MOV ESP, EBP		;SALGO
	POP EBP
	RET