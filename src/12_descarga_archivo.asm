; ROMAN LLANES OLIVER URIEL
; Programa: Cálculo del avance de descarga de un archivo
; Descripción: Con el tamaño del archivo (100000 bytes) y los bloques ya
; descargados (125 de 512 bytes), calcula bytes descargados, bytes pendientes,
; porcentaje de avance, grupos completos de 1024 bytes y su residuo. Incluye
; el procedimiento convertirDecimal, que convierte un número a texto para
; mostrarlo con WriteString.

INCLUDE Irvine32.inc

.data
    tamArchivo  DWORD 100000        ; tamaño total del archivo en bytes
    bloques     DWORD 125           ; bloques descargados
    tamBloque   DWORD 512           ; tamaño de cada bloque en bytes

    descargados DWORD ?             ; resultado: bytes descargados
    pendientes  DWORD ?             ; resultado: bytes pendientes
    porcentaje  DWORD ?             ; resultado: porcentaje de avance
    grupos      DWORD ?             ; resultado: grupos completos de 1024
    residuo     DWORD ?             ; resultado: residuo del agrupamiento

    msg1  BYTE "Bytes descargados: ", 0
    msg2  BYTE "Bytes pendientes: ", 0
    msg3  BYTE "Porcentaje de avance: ", 0
    msg4  BYTE "Grupos completos de 1024: ", 0
    msg5  BYTE "Residuo del agrupamiento: ", 0
    salto BYTE 13, 10, 0            ; retorno de carro y salto de línea

    buffer BYTE 11 DUP(0)           ; espacio para el número convertido a texto

.code

; Procedimiento: convertirDecimal
; Entrada: EAX = número a convertir, ESI = dirección del buffer
; Salida: el texto del número queda al inicio del buffer
convertirDecimal PROC
    push eax                        ; respalda los registros que se van a usar
    push ebx
    push ecx
    push edx
    push edi

    mov  edi, esi                   ; EDI apunta al buffer
    add  edi, 10                    ; EDI se mueve al final del buffer
    mov  BYTE PTR [edi], 00h        ; coloca el nulo que termina la cadena

    mov  ebx, 10                    ; divisor para obtener dígitos decimales

    cmp  eax, 0                     ; ¿el número es 0?
    jne  convertir                  ; si no es 0, convierte normalmente

    dec  edi                        ; retrocede una posición
    mov  BYTE PTR [edi], '0'        ; escribe el carácter '0'
    jmp  terminado                  ; salta a acomodar el texto

convertir:
    xor  edx, edx                   ; limpia EDX antes de dividir
    div  ebx                        ; EAX = EAX / 10, EDX = último dígito
    add  dl, '0'                    ; convierte el dígito a carácter ASCII
    dec  edi                        ; retrocede una posición en el buffer
    mov  [edi], dl                  ; guarda el carácter
    cmp  eax, 0                     ; ¿ya no quedan dígitos?
    jne  convertir                  ; si quedan, repite

terminado:
    mov  esi, edi                   ; ESI apunta al primer dígito obtenido
    mov  ecx, 0                     ; ECX cuenta los caracteres

contar:
    cmp  BYTE PTR [esi+ecx], 0      ; ¿llegó al nulo final?
    je   copiarInicio               ; sí: termina de contar
    inc  ecx                        ; no: cuenta un carácter más
    jmp  contar                     ; sigue contando

copiarInicio:
    mov  edi, OFFSET buffer         ; destino: inicio del buffer
    inc  ecx                        ; incluye el nulo en la copia
    cld                             ; copia hacia adelante
    rep  movsb                      ; copia ECX bytes de ESI a EDI

    pop  edi                        ; restaura los registros
    pop  edx
    pop  ecx
    pop  ebx
    pop  eax
    ret                             ; regresa al programa principal
convertirDecimal ENDP

main PROC
    ; 1. Bytes descargados = bloques * tamaño de bloque
    mov  eax, bloques               ; EAX = 125
    mul  tamBloque                  ; EAX = 125 * 512
    mov  descargados, eax           ; guarda el resultado

    ; 2. Bytes pendientes = tamaño total - descargados
    mov  eax, tamArchivo            ; EAX = 100000
    sub  eax, descargados           ; resta lo descargado
    mov  pendientes, eax            ; guarda el resultado

    ; 3. Porcentaje entero = descargados * 100 / tamaño total
    mov  eax, descargados           ; EAX = bytes descargados
    mov  ebx, 100                   ; multiplicador
    mul  ebx                        ; EAX = descargados * 100
    mov  ebx, tamArchivo            ; divisor = tamaño total
    div  ebx                        ; EAX = porcentaje entero
    mov  porcentaje, eax            ; guarda el resultado

    ; 4. Grupos completos de 1024 bytes y residuo
    mov  eax, descargados           ; dividendo
    xor  edx, edx                   ; limpia EDX antes de dividir
    mov  ebx, 1024                  ; divisor
    div  ebx                        ; EAX = grupos, EDX = residuo
    mov  grupos, eax                ; guarda los grupos
    mov  residuo, edx               ; guarda el residuo

    ; Mostrar bytes descargados
    mov  edx, OFFSET msg1           ; EDX apunta al texto
    call WriteString                ; imprime el texto
    mov  eax, descargados           ; EAX = número a mostrar
    mov  esi, OFFSET buffer         ; ESI = buffer de conversión
    call convertirDecimal           ; convierte el número a texto
    mov  edx, OFFSET buffer         ; EDX apunta al texto convertido
    call WriteString                ; imprime el número
    call Crlf                       ; salto de línea

    ; Mostrar bytes pendientes
    mov  edx, OFFSET msg2
    call WriteString
    mov  eax, pendientes
    mov  esi, OFFSET buffer
    call convertirDecimal
    mov  edx, OFFSET buffer
    call WriteString
    call Crlf

    ; Mostrar porcentaje
    mov  edx, OFFSET msg3
    call WriteString
    mov  eax, porcentaje
    mov  esi, OFFSET buffer
    call convertirDecimal
    mov  edx, OFFSET buffer
    call WriteString
    mov  edx, OFFSET salto          ; salto de línea con la cadena 13,10
    call WriteString

    ; Mostrar grupos completos
    mov  edx, OFFSET msg4
    call WriteString
    mov  eax, grupos
    mov  esi, OFFSET buffer
    call convertirDecimal
    mov  edx, OFFSET buffer
    call WriteString
    call Crlf

    ; Mostrar residuo
    mov  edx, OFFSET msg5
    call WriteString
    mov  eax, residuo
    mov  esi, OFFSET buffer
    call convertirDecimal
    mov  edx, OFFSET buffer
    call WriteString
    call Crlf

    exit                            ; termina el programa
main ENDP
END main
