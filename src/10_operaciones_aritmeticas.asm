; ROMAN LLANES OLIVER URIEL
; Horario: 10 - 11 A.M.
; Programa: Práctica 8 - Operaciones aritméticas
; Descripción: Muestra el uso de ADD, SUB, MUL, IMUL, DIV e IDIV, y cómo se
; activan las banderas CF (acarreo sin signo) y OF (desbordamiento con signo).
; No imprime nada: se revisa paso a paso con el depurador (F10) y la ventana
; de registros. Cada NOP sirve como punto de pausa para ver el resultado.

INCLUDE Irvine32.inc

.data

.code
main PROC
    ; 1. ADD y SUB
    mov  eax, 50            ; EAX = 50
    mov  ebx, 20            ; EBX = 20
    add  eax, ebx           ; EAX = EAX + EBX = 70
    sub  eax, 15            ; EAX = EAX - 15 = 55
    nop                     ; pausa para ver el resultado

    ; 2. CF: acarreo en suma sin signo
    mov  eax, 0             ; limpia EAX
    mov  al, 255            ; AL = 255, el máximo de 8 bits sin signo
    add  al, 1              ; AL pasa a 0 y se activa CF = 1
    nop                     ; pausa para ver CF

    ; 3. OF: desbordamiento en suma con signo
    mov  eax, 0             ; limpia EAX
    mov  al, 127            ; AL = 127, el máximo de 8 bits con signo
    add  al, 1              ; AL pasa a -128 y se activa OF = 1
    nop                     ; pausa para ver OF

    ; 4. MUL: producto dentro de 32 bits
    mov  eax, 25            ; multiplicando
    mov  ebx, 3             ; multiplicador
    mul  ebx                ; EDX:EAX = EAX * EBX = 75 (EDX queda en 0)
    nop                     ; pausa para ver el resultado

    ; 5. MUL: producto que necesita más de 32 bits
    mov  eax, 65537         ; multiplicando
    mov  ebx, 65537         ; multiplicador
    mul  ebx                ; el resultado ocupa 33 bits: EDX = 1 y EAX = 00020001h
    nop                     ; pausa para ver EDX y EAX

    ; 6. IMUL: multiplicación con signo
    mov  eax, -5            ; EAX = -5
    imul eax, eax, 3        ; EAX = -5 * 3 = -15
    nop                     ; pausa para ver el resultado

    ; 7. DIV: división sin signo
    mov  eax, 125           ; dividendo
    mov  edx, 0             ; limpia EDX (parte alta del dividendo)
    mov  ebx, 12            ; divisor
    div  ebx                ; EAX = cociente (10), EDX = residuo (5)
    nop                     ; pausa para ver cociente y residuo

    ; 8. IDIV: división con signo
    mov  eax, -125          ; dividendo negativo
    cdq                     ; extiende el signo de EAX hacia EDX
    mov  ebx, 12            ; divisor
    idiv ebx                ; EAX = cociente (-10), EDX = residuo (-5)
    nop                     ; pausa para ver cociente y residuo

    exit                    ; termina el programa
main ENDP
END main
