; ROMAN LLANES OLIVER URIEL
; Programa: Ciclo numérico con LOOP
; Descripción: Imprime en consola los números del 5 al 1 usando el registro
; ECX como contador y la instrucción LOOP para repetir el bloque.

INCLUDE Irvine32.inc

.data

.code
main PROC
    mov  ecx, 5             ; ECX es el contador: el ciclo se repite 5 veces

ciclo:
    mov  eax, ecx           ; copia el contador a EAX para poder imprimirlo
    call WriteDec           ; imprime en consola el valor de EAX
    call Crlf               ; salto de línea

    loop ciclo              ; resta 1 a ECX y salta a "ciclo" mientras ECX sea distinto de 0

    exit                    ; termina el programa
main ENDP
END main
