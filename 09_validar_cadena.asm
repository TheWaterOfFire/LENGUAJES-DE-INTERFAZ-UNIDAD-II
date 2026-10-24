; ROMAN LLANES OLIVER URIEL
; Programa: Captura de cadena con formato
; Descripción: Lee una cadena con ReadString y valida que tenga el formato
; AAA-999: exactamente 7 caracteres, 3 letras mayúsculas, un guion y
; 3 dígitos. Muestra si la cadena cumple o no con las reglas.

INCLUDE Irvine32.inc

.data
    msgPedir    BYTE "Ingrese el codigo (formato AAA-999): ", 0
    msgValido   BYTE "LA CADENA CUMPLE CON LAS REGLAS", 0
    msgNoValido BYTE "NO CUMPLE CON LAS REGLAS", 0
    cadena      BYTE 21 DUP(0)              ; buffer en memoria para la cadena (20 + nulo)

.code
main PROC
    mov  edx, OFFSET msgPedir               ; EDX apunta al mensaje de petición
    call WriteString                        ; muestra el mensaje

    mov  edx, OFFSET cadena                 ; EDX = dirección donde se guardará el texto
    mov  ecx, SIZEOF cadena - 1             ; ECX = máximo de caracteres a leer
    call ReadString                         ; lee la cadena; EAX = cantidad de caracteres
    call Crlf                               ; salto de línea

    cmp  eax, 7                             ; la cadena debe medir exactamente 7
    jne  invalido                           ; si no mide 7, no es válida

    mov  esi, OFFSET cadena                 ; ESI recorre la cadena desde el primer carácter
    mov  ecx, 3                             ; se revisarán 3 letras

validarLetras:
    mov  al, [esi]                          ; AL = carácter actual
    cmp  al, 'A'                            ; ¿es menor que 'A'?
    jb   invalido                           ; sí: no es letra mayúscula
    cmp  al, 'Z'                            ; ¿es mayor que 'Z'?
    ja   invalido                           ; sí: no es letra mayúscula
    inc  esi                                ; avanza al siguiente carácter
    loop validarLetras                      ; repite hasta revisar las 3 letras

    mov  al, [esi]                          ; AL = cuarto carácter
    cmp  al, '-'                            ; debe ser un guion
    jne  invalido                           ; si no lo es, no es válida
    inc  esi                                ; avanza al siguiente carácter

    mov  ecx, 3                             ; se revisarán 3 dígitos

validarDigitos:
    mov  al, [esi]                          ; AL = carácter actual
    cmp  al, '0'                            ; ¿es menor que '0'?
    jb   invalido                           ; sí: no es dígito
    cmp  al, '9'                            ; ¿es mayor que '9'?
    ja   invalido                           ; sí: no es dígito
    inc  esi                                ; avanza al siguiente carácter
    loop validarDigitos                     ; repite hasta revisar los 3 dígitos

esValido:
    mov  edx, OFFSET msgValido              ; mensaje de cadena válida
    call WriteString                        ; lo muestra
    jmp  fin                                ; salta al final

invalido:
    mov  edx, OFFSET msgNoValido            ; mensaje de cadena no válida
    call WriteString                        ; lo muestra

fin:
    call Crlf                               ; salto de línea
    exit                                    ; termina el programa
main ENDP
END main
