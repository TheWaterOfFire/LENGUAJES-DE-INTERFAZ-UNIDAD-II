; ROMAN LLANES OLIVER URIEL
; Practica 11 - Operaciones logicas
; Aqui uso AND y OR para trabajar con bits sueltos de un registro, como si fuera
; el estado de un aparato (bit 0 = encendido, bit 1 = alarma, bit 2 = conectada).

INCLUDE Irvine32.inc

.data

.code
main PROC

    ; el estado inicial es 00000101b (encendido y conectada)

    mov eax, 0                  ; limpio eax y ebx para que no tengan basura
    mov ebx, 0
    mov al, 00000101b           ; estado inicial del aparato
    mov bl, al                  ; copio el estado a bl para no perder el original
    and bl, 00000001b         ; AND con la mascara, solo deja el bit 0 (encendido)

    call dumpRegs               ; muestro los registros para ver como quedo bl
    nop                         ; pausa para el debugger

    ; ahora prendo la alarma

    mov al, 00000101b           ; vuelvo a poner el estado inicial
    or al, 00000010b          ; OR prende el bit 1 (alarma) y no toca los demas

    call dumpRegs               ; al deberia quedar en 00000111b
    nop
    exit

main ENDP

END main
