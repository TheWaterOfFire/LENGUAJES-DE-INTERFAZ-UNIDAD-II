; ROMAN LLANES OLIVER URIEL
; Programa: Ciclo que lee números hasta capturar un cero
; Descripción: Pide números enteros al usuario una y otra vez. El ciclo
; termina cuando el usuario escribe 0.

INCLUDE Irvine32.inc

.data
    msgPedir BYTE "Ingrese un numero (0 para terminar): ", 0
    msgFin   BYTE "Programa finalizado", 0

.code
main PROC

ciclo:
    mov  edx, OFFSET msgPedir   ; EDX apunta al mensaje de petición
    call WriteString            ; muestra el mensaje
    call ReadInt                ; lee un entero y lo deja en EAX
    call Crlf                   ; salto de línea

    cmp  eax, 0                 ; compara el número capturado contra 0
    jne  ciclo                  ; si es distinto de 0, vuelve a pedir otro número

    mov  edx, OFFSET msgFin     ; EDX apunta al mensaje final
    call WriteString            ; muestra el mensaje
    call Crlf                   ; salto de línea
    exit                        ; termina el programa
main ENDP
END main
