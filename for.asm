;---------------------------
;	Autor: Oscar Espinosa
;---------------------------

;	ciclo for


section .text
global _start
;ciclo FOR decremental, comienza desde el valor asignado
;a la variable count
_start:
	mov EAX, [count]		; se copia el valor de count a EAX
ciclo_for:
	dec EAX					; se decrementa el valor de EAX
	cmp EAX, 0x00			; termina cuando EAX es igual a 0
	je fin					; termina cuando EAX=0
	jmp ciclo_for			; continua el ciclo en caso contrario

fin:
	mov EAX, 1				; termina la ejecucion
	int 0x80

section .data
	count: db 0x0A			; variable de cuenta para el ciclo