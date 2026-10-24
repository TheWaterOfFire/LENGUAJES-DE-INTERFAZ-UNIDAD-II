; ROMAN LLANES OLIVER URIEL
; Programa: Salto condicional por igualdad (JE)
; Descripción: Compara dos valores con CMP y, según la bandera Zero Flag,
; muestra un mensaje indicando si los valores son iguales o diferentes.

INCLUDE Irvine32.inc

.data
    msgDiferentes BYTE "Los valores son diferentes", 0   ; mensaje si no son iguales
    msgIguales    BYTE "Los valores son iguales", 0      ; mensaje si son iguales

.code
main PROC
    mov  eax, 10                    ; primer valor a comparar
    mov  ebx, 10                    ; segundo valor a comparar

    cmp  eax, ebx                   ; compara EAX con EBX y actualiza las banderas

    je   iguales                    ; salta a "iguales" si ZF = 1 (los valores son iguales)

    mov  edx, OFFSET msgDiferentes  ; EDX apunta al mensaje de diferentes
    call WriteString                ; imprime el mensaje

    jmp  fin                        ; salta al final para no ejecutar el bloque "iguales"

iguales:
    mov  edx, OFFSET msgIguales     ; EDX apunta al mensaje de iguales
    call WriteString                ; imprime el mensaje

fin:
    call Crlf                       ; salto de línea
    exit                            ; termina el programa
main ENDP
END main
