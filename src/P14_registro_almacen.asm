; ROMAN LLANES OLIVER URIEL
; Practica 14 - Registro en almacen
; Pide cuantas piezas llegaron (de 1 a 99) como texto, revisa que solo sean
; digitos, lo convierte a numero, lo suma a la existencia inicial (25) y muestra
; la existencia actual. Si la captura esta mal, vuelve a pedirla.

INCLUDE Irvine32.inc

.data
    promptMsg         BYTE "Ingrese la cantidad recibida (1-99): ", 0
    errorMsg          BYTE "Error de entrada. Intente nuevamente.", 0
    msgExistencia     BYTE "Existencia actual: ", 0

    buffer            BYTE 10 DUP(0)    ; aqui se guarda lo que escribe el usuario
    cantidadRecibida  DWORD ?
    existenciaInicial DWORD 25          ; lo que ya hay en el almacen
    existenciaActual  DWORD ?
    outBuffer         BYTE 10 DUP(0)    ; texto del resultado para imprimirlo

.code
main PROC
PedirDatos:
    mov edx, OFFSET promptMsg       ; mensaje para pedir la cantidad
    call WriteString

    mov edx, OFFSET buffer          ; edx = donde se guarda el texto
    mov ecx, SIZEOF buffer - 1      ; maximo de caracteres (dejo lugar para el nulo)
    call ReadString                 ; eax = cuantos caracteres se leyeron

    cmp eax, 0                      ; si no escribio nada es error
    je ErrorEntrada
    cmp eax, 2                    ; mas de 2 caracteres tambien es error
    ja ErrorEntrada

    mov esi, OFFSET buffer          ; esi recorre el texto
    mov ecx, eax                    ; reviso exactamente los caracteres que se leyeron
ValidarCaracteres:
    mov al, [esi]                   ; tomo un caracter
    cmp al, '0'                     ; si es menor que '0' no es digito
    jb ErrorEntrada
    cmp al, '9'                   ; si es mayor que '9' tampoco
    ja ErrorEntrada
    inc esi                         ; paso al siguiente
    loop ValidarCaracteres

    mov esi, OFFSET buffer          ; ahora lo convierto de texto a numero
    mov eax, 0                      ; aqui voy acumulando el numero
    mov ebx, 10
    mov ecx, 2                      ; maximo 2 digitos
ConvertLoop:
    movzx edx, BYTE PTR [esi]       ; edx = caracter actual
    cmp dl, 0                       ; si es el nulo ya termino
    je FinConversion
    cmp dl, 0Dh                   ; por si quedo un retorno de carro
    je FinConversion
    cmp dl, 0Ah                     ; o un salto de linea
    je FinConversion
    sub dl, '0'                     ; de caracter a su valor (0-9)
    imul eax, ebx                 ; eax * 10 (uso imul porque mul me borraba edx)
    add eax, edx                    ; le sumo el digito nuevo
    inc esi
    loop ConvertLoop

FinConversion:
    cmp eax, 1                      ; el numero tiene que estar entre 1 y 99
    jb ErrorEntrada
    cmp eax, 99
    ja ErrorEntrada

    mov cantidadRecibida, eax       ; guardo lo que llego
    mov ebx, existenciaInicial
    add eax, ebx                    ; existencia actual = lo que llego + lo que habia
    mov existenciaActual, eax

    mov edx, OFFSET msgExistencia
    call WriteString

    mov eax, existenciaActual       ; el numero que voy a convertir a texto
    mov edi, OFFSET outBuffer       ; edi = donde queda el texto
    call ConvDwordToString

    mov edx, OFFSET outBuffer
    call WriteString                ; imprimo el resultado
    call Crlf
    jmp FinProg

ErrorEntrada:
    call Crlf
    mov edx, OFFSET errorMsg        ; aviso que la captura estuvo mal
    call WriteString
    call Crlf
    jmp PedirDatos                  ; y vuelvo a pedir el dato

FinProg:
    exit
main ENDP

; convierte el numero de EAX a texto y lo deja en la direccion de EDI
ConvDwordToString PROC
    pushad                          ; guardo todos los registros
    mov ecx, 0                      ; ecx cuenta los digitos
    mov ebx, 10
DivLoop:
    mov edx, 0
    div ebx                         ; eax = eax / 10, edx = ultimo digito
    add dl, '0'                   ; lo paso a caracter
    push edx                        ; lo guardo en la pila (salen al reves)
    inc ecx
    cmp eax, 0
    jne DivLoop                     ; sigue hasta que eax llegue a 0
PopLoop:
    pop edx                         ; los saco en el orden correcto
    mov [edi], dl                   ; los voy escribiendo en el buffer
    inc edi
    loop PopLoop
    mov BYTE PTR [edi], 0           ; nulo al final
    popad                           ; regreso los registros como estaban
    ret
ConvDwordToString ENDP

END main
