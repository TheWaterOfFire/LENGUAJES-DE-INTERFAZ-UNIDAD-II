; ROMAN LLANES OLIVER URIEL
; Programa: Ingreso de PIN con intentos decrementales
; Descripción: Pide un PIN y da 3 intentos. En cada error decrementa el
; contador de intentos con DEC; si llega a 0 bloquea el acceso, y si el PIN
; es correcto muestra "Acceso permitido".

INCLUDE Irvine32.inc

.data
    msgPIN       BYTE "Ingrese el PIN: ", 0
    msgIntentos  BYTE "Intentos restantes: ", 0
    msgError     BYTE "PIN incorrecto", 0
    msgAcceso    BYTE "Acceso permitido", 0
    msgBloqueado BYTE "Autodestruccion comenzada......", 0

    pinCorrecto = 1234                  ; constante con el PIN válido

.code
main PROC
    mov  ebx, 3                         ; EBX guarda el número de intentos disponibles

intentar:
    mov  edx, OFFSET msgPIN             ; EDX apunta al mensaje que pide el PIN
    call WriteString                    ; muestra el mensaje
    call ReadInt                        ; lee el PIN escrito y lo deja en EAX

    cmp  eax, pinCorrecto               ; compara el PIN capturado con el correcto
    je   acceso                         ; si son iguales, salta a "acceso"

    mov  edx, OFFSET msgError           ; PIN incorrecto: prepara el mensaje de error
    call WriteString                    ; muestra el error
    call Crlf                           ; salto de línea

    dec  ebx                            ; resta 1 a los intentos restantes

    jz   bloqueado                      ; si los intentos llegaron a 0 (ZF = 1), bloquea

    mov  edx, OFFSET msgIntentos        ; prepara el mensaje de intentos restantes
    call WriteString                    ; muestra el mensaje

    mov  eax, ebx                       ; copia los intentos a EAX para imprimirlos
    call WriteDec                       ; imprime los intentos restantes
    call Crlf                           ; salto de línea

    jmp  intentar                       ; regresa a pedir el PIN otra vez

acceso:
    mov  edx, OFFSET msgAcceso          ; mensaje de acceso permitido
    call WriteString                    ; lo muestra
    call Crlf                           ; salto de línea
    jmp  fin                            ; salta al final

bloqueado:
    mov  edx, OFFSET msgBloqueado       ; mensaje de bloqueo
    call WriteString                    ; lo muestra
    call Crlf                           ; salto de línea
    jmp  fin                            ; salta al final

fin:
    exit                                ; termina el programa
main ENDP
END main
