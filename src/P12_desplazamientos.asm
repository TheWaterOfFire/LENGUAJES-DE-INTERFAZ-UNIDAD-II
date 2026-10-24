; ROMAN LLANES OLIVER URIEL
; Practica 12 - Desplazamientos y rotaciones
; En este programa pruebo SHL, SHR, SAR y las rotaciones (ROL, ROR, RCL, RCR)
; sobre el registro AL, y despues imprimo el resultado en binario y con DumpRegs.

INCLUDE Irvine32.inc

.data

.code
main PROC
    mov eax, 0                  ; dejo todos los registros en 0 para empezar
    mov ebx, 0
    mov ecx, 0
    mov edx, 0

    ; 1 - SHL, mover un bit a la izquierda
    mov al, 10000000b           ; el bit de la izquierda sale y se va a CF
    shl al, 1                   ; al queda en 0 y CF = 1

    call DumpRegs
    call WriteBin

    ; 2 - SHR, mover un bit a la derecha
    mov al, 00001101b           ; 13 en binario
    shr al, 1                 ; entra un 0 por la izquierda, al = 00000110b (6)

    call DumpRegs
    call WriteBin

    ; 3 - SAR, conserva el signo
    mov al, -8                  ; -8 en complemento a 2
    sar al, 1                   ; copia el bit de signo, al = -4

    call DumpRegs
    call WriteBin

    ; 4 - SAR con un numero impar (no es division exacta)
    mov al, -9
    sar al, 1                 ; da -5, redondea hacia abajo

    call DumpRegs
    call WriteBin

    ; 5 - mover 2 bits a la izquierda
    mov al, 00001111b
    shl al, 2                   ; al = 00111100b, es como multiplicar por 4

    call WriteBin
    call DumpRegs

    ; 6 - mover 2 bits a la derecha usando CL
    mov al, 00001111b
    mov cl, 2                   ; cl guarda cuantas posiciones se mueve
    shr al, cl                ; al = 00000011b

    call WriteBin
    call DumpRegs

    ; 7 - rotaciones: ROL, ROR, RCL, RCR
    mov al, 10010001b
    rol al, 1                   ; el bit que sale vuelve a entrar por la derecha
    call DumpRegs

    ror al, 1                 ; lo regresa a como estaba
    call DumpRegs

    clc                         ; apago CF antes de las rotaciones con acarreo
    rcl al, 1                   ; rota a la izquierda pasando por CF
    call DumpRegs

    rcr al, 1                 ; rota a la derecha pasando por CF
    call DumpRegs

    exit

main ENDP

END main
