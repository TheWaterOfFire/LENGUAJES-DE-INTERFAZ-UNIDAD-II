; Materia: Lenguajes de Interfaz
; Alumno: Román Llanes Oliver Uriel
; Horario: 10 - 11 A.M.
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 0 - Hola mundo
; Descripción: Muestra el mensaje "Hola mundo" en pantalla para comprobar que
; todo quedó bien configurado.

INCLUDE Irvine32.inc

.data
    mensaje BYTE "Hola mundo", 0    ; el texto que se va a mostrar, termina en 0

.code
main PROC
    mov edx, OFFSET mensaje         ; edx apunta al inicio del texto
    call WriteString              ; imprime el texto que esta en esa direccion
    call Crlf                       ; salto de linea

    call WaitMsg                  ; deja la consola abierta hasta presionar una tecla
    exit                            ; termina el programa
main ENDP

END main
