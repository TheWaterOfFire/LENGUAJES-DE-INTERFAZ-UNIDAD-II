; ROMAN LLANES OLIVER URIEL
; Horario: 10 - 11 A.M.
; Programa: Ciclo condicional con la condición al inicio (while)
; Descripción: Imprime los números del 1 al 10. La condición de salida se
; revisa antes de cada vuelta, como en un ciclo while.

INCLUDE Irvine32.inc

.data

.code
main PROC
    mov  ebx, 1             ; valor inicial del contador

ciclo:
    cmp  ebx, 10            ; compara el contador con el límite (condición de salida)
    jg   fin                ; si EBX es mayor que 10, sale del ciclo

    mov  eax, ebx           ; copia el valor a EAX para imprimirlo
    call WriteDec           ; imprime el número actual
    call Crlf               ; salto de línea

    inc  ebx                ; incrementa el contador en 1

    jmp  ciclo              ; salto incondicional: regresa a revisar la condición

fin:
    exit                    ; termina el programa
main ENDP
END main
