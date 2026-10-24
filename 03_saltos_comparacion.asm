; ROMAN LLANES OLIVER URIEL
; Programa: Comparación de dos números con saltos condicionales
; Descripción: Pide dos números enteros al usuario, los compara con CMP y
; usa JE y JG para indicar si son iguales, o cuál de los dos es mayor.

INCLUDE Irvine32.inc

.data
    prompt1    BYTE "Ingrese el primer numero: ", 0
    prompt2    BYTE "Ingrese el segundo numero: ", 0
    msgIguales BYTE "Los numeros son iguales", 0
    msgMayor   BYTE "El primer numero es mayor", 0
    msgMenor   BYTE "El primer numero es menor", 0

.code
main PROC
    mov  edx, OFFSET prompt1    ; EDX apunta al texto de la primera petición
    call WriteString            ; muestra la petición
    call ReadInt                ; lee un entero con signo y lo deja en EAX
    mov  ecx, eax               ; guarda el primer número en ECX

    mov  edx, OFFSET prompt2    ; EDX apunta al texto de la segunda petición
    call WriteString            ; muestra la petición
    call ReadInt                ; lee el segundo número en EAX
    mov  ebx, eax               ; guarda el segundo número en EBX

    mov  eax, ecx               ; regresa el primer número a EAX
    cmp  eax, ebx               ; compara el primero contra el segundo

    je   iguales                ; salta si son iguales (ZF = 1)
    jg   mayor                  ; salta si el primero es mayor (comparación con signo)

    mov  edx, OFFSET msgMenor   ; si no saltó, el primero es menor
    call WriteString            ; imprime el mensaje
    jmp  fin                    ; salta al final

iguales:
    mov  edx, OFFSET msgIguales ; mensaje de igualdad
    call WriteString            ; imprime el mensaje
    jmp  fin                    ; salta al final

mayor:
    mov  edx, OFFSET msgMayor   ; mensaje de que el primero es mayor
    call WriteString            ; imprime el mensaje

fin:
    call Crlf                   ; salto de línea
    exit                        ; termina el programa
main ENDP
END main
