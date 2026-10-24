; ROMAN LLANES OLIVER URIEL
; Horario: 10 - 11 A.M.
; Practica 13 - Convertir un numero a texto hexadecimal
; Toma el valor 2AB34CD0h que esta en EAX y lo convierte a caracteres sacando
; cuatro bits a la vez (un digito hexadecimal), de derecha a izquierda, y los
; guarda en un buffer para imprimirlo con WriteString.

INCLUDE Irvine32.inc

.data
    bufferHex BYTE 8 DUP('0'), 0    ; aqui se va armando el texto (8 digitos y el nulo)

.code
main PROC
    mov eax, 0                  ; limpio los registros al inicio
    mov ebx, 0
    mov ecx, 0
    mov edx, 0

    mov eax, 2ab34cd0h          ; el numero que voy a convertir
    mov esi, 7                  ; esi es la posicion en el buffer, empiezo por el ultimo digito
    mov ecx, 8                  ; son 8 digitos hexadecimales, el loop da 8 vueltas

L1:

    mov ebx, eax                ; copio el numero a ebx para no perder eax
    and ebx, 0Fh              ; mascara, me quedo solo con los 4 bits de la derecha

    cmp ebx, 10                 ; es del 0 al 9 o de la A a la F?
    jl EsNumero                 ; si es menor que 10 va directo a convertirse
    add ebx, 7                ; si es 10 o mas le sumo 7 para saltar a las letras

EsNumero:
    add ebx, '0'                ; lo paso a caracter ASCII
    mov bufferHex[esi], bl      ; lo guardo en su posicion del buffer
    shr eax, 4                ; tiro los 4 bits que ya converti

    dec esi                     ; me muevo un lugar a la izquierda en el buffer
    loop L1                     ; repite hasta completar los 8 digitos

    mov edx, OFFSET bufferHex   ; edx apunta al texto que arme
    call WriteString            ; lo imprimo
    call Crlf

    call DumpRegs               ; muestro los registros al final

    exit

main ENDP

END main
