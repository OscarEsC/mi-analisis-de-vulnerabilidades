#!/bin/bash

#-------------------------
# Autor: Oscar Espinosa Curiel
#-------------------------

#-------------------------
#   Script que obtiene el shellcode de un binario
#   dado como argumento
#-------------------------

function printError (){
    #Funcion de mensaje de error y ejemplo de uso
    echo "ERROR"
    echo "El script solo recibe el binario ejecutable"
    echo "Ejemplo"
    echo "./get_shellcode.sh [-n|-u] <nombre_del_binario>"
    echo ""
    echo "    la salida por defecto es en formato comun (\x90\x90)"
    echo "    -n para salida solo numerica (9090)"
    echo "    -u para salida en formato unicode (\u9090\u9090)"
    echo ""
}
function get_numeric_shcode () {
    #funcion que obtiene solo los valores numericos del shellcode 
    if [ -r "$1" ]; then
        objdump -d -j .text $1 | grep -e '^ ' | tr '[[:space:]]' '\n' | egrep '^[[:alnum:]]{2}$' | xargs | sed 's/ //g' | sed -e 's/^//g'
    else
        echo "El archivo no existe o no tiene permisos de lectura"
    fi
}

function get_unicode_shcode () {
    #Funcion que obtiene el shellcode en modo unicode repitiendo los valores
    #numericos. Esto se hace usando -E para sed y \0 para repetir el match encontrado
    if [ -r "$1" ]; then
        objdump -d -j .text $1 | grep -e '^ ' | tr '[[:space:]]' '\n' | egrep '^[[:alnum:]]{2}$' | xargs | sed 's/ /\\u/g' | sed -e 's/^/\\u/g' | sed -E 's/[0-9a-f]{2}/\0\0/g'
    else
        echo "El archivo no existe o no tiene permisos de lectura"
        exit 1
    fi
}

function get_std_shcode () {
    #funcion que obtiene el shellcode en modo hexadecimal
    if [ -r "$1" ]; then
        objdump -d -j .text $1 | grep -e '^ ' | tr '[[:space:]]' '\n' | egrep '^[[:alnum:]]{2}$' | xargs | sed 's/ /\\x/g' | sed -e 's/^/\\x/g'
    else
        echo "El archivo no existe o no tiene permisos de lectura"
        exit 1
    fi
}

function get_shcode() {
    #funcion principal del script
    #El primer parametro que recibe es la bandera, en caso de existir
    #Cuando no se da una bandera, se obtiene en formato hexadecimal
    #Cuando se desea otro formato, la bandera debe ser el primer argumento
    #del script

    #Si no se dan parametros o se dan mas de 2
    if [ "$#" -le 0 ] || [ "$#" -gt 3 ]; then
        printError
        exit 1
    fi

    #Si no se da bandera, se asume que el unico argumento es el archivo binario
    #se obtiene el formato hexadecimal
    if [ "$#" -eq 1 ];then
        get_std_shcode $1

    #Si se dan dos argumentos, se valida primero la bandera
    #-n devuelve el formato numerico
    elif [ "$1" = "-n" ]; then
        get_numeric_shcode $2

    #-u devuelve el formato unicode
    elif [ "$1" = "-u" ]; then
        get_unicode_shcode $2


    else   
        printError
        exit 1
    fi
}

get_shcode $1 $2