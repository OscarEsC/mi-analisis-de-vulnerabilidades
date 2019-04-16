#!/bin/python

"""
	Autor: Oscar Espinosa

	Script que calcula un serial valido para shell_mod2
	con un serial de inicio
"""

#Serial de inicio
mi_serial="OSCAR-ESPIN-OSA"
#Condiciones de shell_mod2
condicion_suma = 2272
condicion_long = 29

suma = 0

#Suma de los valores del serial inicial
for x in mi_serial:
	suma += ord(x)

#Variables para el control de los caracteres anadidos al serial
#variable que almacena el valor que falta para completar la condicion de
#la suma de los caracteres ASCII
tmps = condicion_suma - suma
#variable que almacena la cantidad de caracteres faltantes para cumplir
#la condicion de longitud
tmpl = condicion_long - len(mi_serial)
#variable que tiene el promedio de valor ASCII por caracter
tmpp = tmps/tmpl

#Ciclo para completar el serial, se hace mientras falten caracteres
while tmpl > 0:
	#Cada 5 caracteres se agrega el guion medio, tercera condicion del serial
	if (len(mi_serial) + 1) % 6 == 0:
		mi_serial += '-'
		#Se actualiza la suma del valor ASCII del serial
		suma += ord('-')
	else:
		#se agrega el caracter correspondiente al valor ASCII del promedio calculado
		mi_serial += chr(tmpp)
		#se actualiza la suma del valor ASCII del serial
		suma += tmpp

	tmps = condicion_suma - suma
	tmpl = condicion_long - len(mi_serial)
	#evita error de ejecucion
	if tmpl > 0:
		tmpp = tmps/tmpl

print tmpp
print len(mi_serial)
print suma
#Aqui se imprime el serial valido
print mi_serial
