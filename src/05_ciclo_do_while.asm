; ROMAN LLANES OLIVER URIEL
; Horario: 10 - 11 A.M.
; Programa: Ciclo condicional con la condición al final (do-while)
; Descripción: Imprime los números del 1 al 100. El bloque se ejecuta primero
; y la condición se revisa al final de cada vuelta.

INCLUDE Irvine32.inc

.data

.code
main PROC
    mov  ebx, 1             ; valor inicial del contador

ciclo:
    mov  eax, ebx           ; copia el valor a EAX para imprimirlo
    call WriteDec           ; imprime el número actual
    call Crlf               ; salto de línea

    inc  ebx                ; incrementa el contador en 1

    cmp  ebx, 100           ; compara el contador con el límite
    jle  ciclo              ; si EBX es menor o igual que 100, repite el ciclo

    exit                    ; termina el programa cuando EBX supera 100
main ENDP
END main
