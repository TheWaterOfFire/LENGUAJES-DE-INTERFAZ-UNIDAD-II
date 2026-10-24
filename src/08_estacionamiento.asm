; ROMAN LLANES OLIVER URIEL
; Horario: 10 - 11 A.M.
; Programa: Control de cupo de un estacionamiento
; Descripción: Lleva la cuenta de los carros dentro de un estacionamiento con
; capacidad de 20. El usuario escribe 1 para registrar una entrada, 2 para una
; salida y 0 para terminar. Avisa cuando está lleno o vacío.

INCLUDE Irvine32.inc

.data
    msgMenu   BYTE "1 = Entra carro, 2 = Sale carro, 0 = Terminar: ", 0
    msgMax    BYTE "Estacionamiento lleno", 0
    msgVacio  BYTE "El estacionamiento esta vacio", 0
    msgCarros BYTE "Carros en el estacionamiento: ", 0

.code
main PROC
    mov  ebx, 20                    ; EBX = límite de carros
    mov  ecx, 0                     ; ECX = carros actuales en el estacionamiento

menu:
    mov  edx, OFFSET msgMenu        ; EDX apunta al texto del menú
    call WriteString                ; muestra el menú
    call ReadInt                    ; lee la opción y la deja en EAX

    cmp  eax, 0                     ; ¿la opción es 0?
    je   fin                        ; sí: termina el programa
    cmp  eax, 1                     ; ¿la opción es 1?
    je   entro                      ; sí: entra un carro
    cmp  eax, 2                     ; ¿la opción es 2?
    je   salio                      ; sí: sale un carro
    jmp  menu                       ; opción inválida: vuelve a mostrar el menú

entro:
    cmp  ecx, ebx                   ; compara carros actuales contra el límite
    jae  maximo                     ; si ya está lleno (ECX >= EBX), salta a "maximo"
    inc  ecx                        ; si hay lugar, suma un carro
    jmp  mostrar                    ; muestra el total

salio:
    cmp  ecx, 0                     ; ¿hay carros dentro?
    je   vacio                      ; si no hay ninguno, salta a "vacio"
    dec  ecx                        ; si hay, resta un carro
    jmp  mostrar                    ; muestra el total

maximo:
    mov  edx, OFFSET msgMax         ; mensaje de estacionamiento lleno
    call WriteString                ; lo muestra
    call Crlf                       ; salto de línea
    jmp  menu                       ; regresa al menú

vacio:
    mov  edx, OFFSET msgVacio       ; mensaje de estacionamiento vacío
    call WriteString                ; lo muestra
    call Crlf                       ; salto de línea
    jmp  menu                       ; regresa al menú

mostrar:
    mov  edx, OFFSET msgCarros      ; texto del total de carros
    call WriteString                ; lo muestra
    mov  eax, ecx                   ; copia el total a EAX para imprimirlo
    call WriteDec                   ; imprime el total
    call Crlf                       ; salto de línea
    jmp  menu                       ; regresa al menú

fin:
    exit                            ; termina el programa
main ENDP
END main
