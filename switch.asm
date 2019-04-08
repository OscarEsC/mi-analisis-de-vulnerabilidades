;---------------------------
;	Autor: Oscar Espinosa
;---------------------------

;	seleccion SWITCH


section .text
global _start

_start:
	mov EAX, 0x0		; el valor que se compara
	cmp EAX, 0x0 		; si es cero, hace opcion0
	je opcion0
	cmp EAX, 0x1
	je opcion1
	cmp EAX, 0x2
	je opcion2
	cmp EAX, 0x3
	je opcion3
	jmp my_default		; si no es ninguna opcion anterior
						; brinca a my_default

opcion0:
	mov edx, 0x8
	mov ecx, cad0		; imprime la cad0
	jmp fin				; brinca a fin

opcion1:
	mov edx, 0x7
	mov ecx, cad1
	jmp fin

opcion2:
	mov edx, 0x7
	mov ecx, cad2
	jmp fin

opcion3:
	mov edx, 0x8
	mov ecx,cad3
	jmp fin

my_default:
	mov edx, 0x7
	mov ecx, cadD

fin:						; muestra la cadena y termina
							; la ejecucion
	mov ebx, 1				; descriptor de archivo stdout
	mov EAX, 4				; llamada a write
	int 0x80
	mov eax, 1				; termina la ejecucion
	int 0x80

section .data
	my_var: db 0x1			; variable que entra al SWITCH
	cad0: db 'es cero', 0xa	; variables usadas para mostrar
	cad1: db 'es uno', 0xa	; el mesanje de salida
	cad2: db 'es dos', 0xa
	cad3: db 'es tres', 0xa
	cadD: db 'error', 0xa