#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <string.h>


typedef struct nodo_abb{

		int valor;

		struct nodo_abb *izq;

		struct nodo_abb *der;

		}nodo_abb;


void ingresarNumeros();
void recorrerDFS(nodo_abb *a);
nodo_abb *agregar_abb(struct nodo_abb *arbol, int val);
void borrar_abb(struct nodo_abb *a);
void mostrar_abb(nodo_abb *a);


int main(){

	printf("AGREGA LOS NÚMEROS:");
	//ingresarNumeros();
	printf("=========TESTEANDO EL PROGRAMA========\n");
	printf("=========INICIO========\n");
	printf("AGREGANDO EL 8\n");
	nodo_abb *a = agregar_abb(NULL, 8);
	recorrerDFS(a);
	printf("\nAGREGANDO EL 1\n");
	nodo_abb *x = agregar_abb(a, 1);
	recorrerDFS(a);
	printf("\nAGREGANDO EL 1 OTRA VEZ\n");	
	nodo_abb *o = agregar_abb(a, 1);
	recorrerDFS(a);
	printf("\nAGREGANDO EL 10\n");
	nodo_abb *f = agregar_abb(a, 10);
	recorrerDFS(a);
	printf("\nAGREGANDO EL 4\n");
	nodo_abb *m = agregar_abb(a, 4);
	recorrerDFS(a);
	nodo_abb *q = agregar_abb(a, 24);
	printf("\nAGREGANDO EL 24\n");
	recorrerDFS(a);
	printf("\nAGREGANDO EL 50\n");
	nodo_abb *t = agregar_abb(a, 50);

	//printf("\nINICIO BORRAR\n");

	borrar_abb(a);

	mostrar_abb(a);

	recorrerDFS(a);

	//printf("\n RECORRO F\n");

	//recorrerDFS(f);

	//printf("MUESTRO ARBOL COMPLETO");

	//mostrar_abb(a);

	//printf("%d", a->der->valor);

	//printf("%d", a->valor);

	//printf("\nBORRO EL ARBOL");

	//printf("%p", a);

	//mostrar_abb(a);

	//recorrerDFS(a);

	

	//nodo_abb *d = agregar_abb(a, 3);

	//nodo_abb *g = agregar_abb(a, 1);

	

	//mostrar_abb(a);

	//	

	}



	

	

	//nodo_abb *d = agregar_abb(a, 7);

	//nodo_abb *e = agregar_abb(a, 30);

	//mostrar_abb(c);

	//mostrar_abb(c);

	//mostrar_abb(b);

	//mostrar_abb(c);

	//mostrar_abb(d);

	//recorrerDFS(a);



//RECORDAR: "->" VALOR DEL PUNTERO!

void recorrerDFS(nodo_abb *a){

	if(a!= NULL)

	{

		recorrerDFS(a->izq);

		printf("%d - ", a->valor);

		recorrerDFS(a->der);

	}

}



void mostrar_abb1(nodo_abb *a)

{

	if(a!= NULL)

	{

		printf("\n{");

		printf("%d - ", a->valor);

		printf("}");

		mostrar_abb1(a->izq);

		mostrar_abb1(a->der);

	}

}



void borrar_abb1(struct nodo_abb *a)

{

	if(a!=NULL)

	{

		borrar_abb(a->izq);

		borrar_abb(a->der);

		free(a);

	}

}



void ingresarNumeros()

{

	nodo_abb *a;

	int e;

	int g=1;

	while(g!=0)

	{

		g = scanf("%d", &e);

		//int val = atoi(arreglo);

		if(a==NULL){

			nodo_abb *a= agregar_abb(NULL, e);

			recorrerDFS(a);

		}

		else{

			agregar_abb(a, e);

			recorrerDFS(a);

	mostrar_abb(a);}

	}

}







