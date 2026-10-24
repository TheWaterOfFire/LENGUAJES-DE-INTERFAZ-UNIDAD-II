; ROMAN LLANES OLIVER URIEL
; Programa: Práctica 9 - PUSH, POP, CALL y RET
; Descripción: Demuestra el funcionamiento de la pila: guardar y recuperar
; valores con PUSH y POP, el orden LIFO, conservar registros y el uso de la
; pila por CALL y RET. Se revisa con el depurador (F10) y la ventana de
; registros; cada NOP es un punto de pausa.

INCLUDE Irvine32.inc

.data

.code
main PROC
    ; Bloque 1: PUSH y POP básicos
    mov  eax, 500           ; EAX = 500
    push eax                ; guarda EAX en la pila (ESP baja 4 bytes)
    nop                     ; pausa para ver la pila

    mov  ebx, 0             ; EBX = 0
    pop  ebx                ; saca el valor de la pila y lo copia a EBX (EBX = 500)
    nop                     ; pausa para ver EBX

    ; Bloque 2: orden LIFO (el último en entrar es el primero en salir)
    mov  eax, 10            ; EAX = 10
    push eax                ; mete 10 a la pila
    mov  eax, 20            ; EAX = 20
    push eax                ; mete 20 a la pila
    mov  eax, 30            ; EAX = 30
    push eax                ; mete 30 a la pila
    nop                     ; pausa para ver la pila con 3 valores

    pop  eax                ; EAX = 30 (el último que entró)
    pop  ebx                ; EBX = 20
    pop  ecx                ; ECX = 10 (el primero que entró)
    nop                     ; pausa para ver el orden invertido

    ; Bloque 3: conservar registros
    mov  eax, 100           ; EAX = 100
    mov  ebx, 200           ; EBX = 200

    push eax                ; respalda EAX en la pila
    push ebx                ; respalda EBX en la pila

    mov  eax, 999           ; se modifican los registros
    mov  ebx, 888           ; se modifican los registros

    pop  ebx                ; recupera EBX (200), se saca en orden inverso
    pop  eax                ; recupera EAX (100)
    nop                     ; pausa para ver los valores restaurados

    ; Bloque 4: CALL y RET
    mov  eax, 50            ; EAX = 50
    mov  ebx, 666           ; EBX = 666

    call aumentarDiez       ; guarda la dirección de retorno en la pila y salta al procedimiento
    nop                     ; pausa: EAX = 60 y EBX sigue valiendo 666

    exit                    ; termina el programa
main ENDP

aumentarDiez PROC
    nop                     ; pausa al entrar al procedimiento
    push ebx                ; respalda EBX para no perder su valor original

    nop                     ; pausa para ver la pila

    mov  ebx, 10            ; usa EBX temporalmente con el valor 10
    add  eax, ebx           ; EAX = EAX + 10

    nop                     ; pausa para ver el resultado

    pop  ebx                ; restaura el valor original de EBX

    nop                     ; pausa para ver EBX restaurado

    ret                     ; recupera la dirección de retorno y regresa a main
aumentarDiez ENDP
END main
