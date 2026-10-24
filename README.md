# Lenguajes de Interfaz — Unidad 2

## Datos generales

| | |
|---|---|
| **Materia** | Lenguajes de Interfaz |
| **Unidad** | Unidad 2 |
| **Alumno** | Oliver Uriel Roman Llanes |
| **Horario** | 10:00 - 11:00 |
| **Docente** | Dr. José Luis Medina Jiménez |

## Índice de prácticas

| No. | Práctica | Descripción |
|---|---|---|
| 0 | [Hola mundo](src/00_hola_mundo.asm) | Imprime "Hola mundo" en pantalla para confirmar que el entorno quedó bien instalado. |
| 1 | [Ciclos numéricos](src/01_ciclos_numericos.asm) | Ejecuta un bloque de código 5 veces con LOOP e imprime el valor del contador en cada vuelta. |
| 2 | [Captura y despliegue de mensaje](src/02_captura_despliegue_mensaje.asm) | Lee un nombre desde el teclado y responde con un saludo. |
| 3 | [Comparación y prueba](src/03_comparacion_prueba.asm) | Usa CMP para comparar números y TEST para revisar bits, y así decidir si un número es par o impar. |
| 4 | [Mayor, menor o igual con entrada del usuario](src/04_mayor_menor_igual.asm) | Recibe dos números y avisa si el primero es mayor, menor o igual que el segundo. |
| 5 | [Repetir hasta que el usuario ingrese cero](src/05_repetir_hasta_cero.asm) | Sigue pidiendo números hasta que el usuario captura un 0. |
| 6 | [Control de ocupación de un estacionamiento](src/06_control_estacionamiento.asm) | Lleva la cuenta de los autos de un estacionamiento de 20 lugares, sumando o restando con INC y DEC. |
| 7 | [Validación de formato](src/07_validacion_formato.asm) | Comprueba que el texto capturado siga el formato AAA-999, es decir, 3 letras mayúsculas, un guion y 3 dígitos. |
| 8 | [Operaciones aritméticas](src/08_operaciones_aritmeticas.asm) | Prueba la suma, la resta, la multiplicación y la división, y muestra cómo se activan las banderas CF y OF. |
| 9 | [PUSH y POP](src/09_push_pop.asm) | Explica cómo trabaja la pila al guardar y recuperar valores con PUSH y POP, y cómo CALL y RET la usan. |
| 10 | [Obtención de una cadena decimal](src/10_cadena_decimal.asm) | Pasa un número a texto dividiendo entre 10 y sumando el código ASCII de cada dígito, sin recurrir a WriteDec. |
| 11 | [Operaciones lógicas](src/11_operaciones_logicas.asm) | Consulta y modifica bits de un byte de estado con AND, OR, XOR, NOT y TEST. |
| 12 | [Desplazamiento y rotación](src/12_desplazamiento_rotacion.asm) | Recorre los bits de un valor hacia la izquierda o la derecha con SHL, SHR, SAR, ROL, ROR, RCL y RCR. |
| 13 | [Obtención de una cadena hexadecimal](src/13_cadena_hexadecimal.asm) | Transforma un número en texto hexadecimal de 8 caracteres, tomando sus bits en grupos de 4. |
| 14 | [Captura y almacenamiento de datos numéricos](src/14_captura_almacenamiento_numerico.asm) | Lee la cantidad que llega a un almacén (de 1 a 99), la valida y la suma a la existencia inicial de 25. |
| 15 | [Manipulación de archivo](src/15_manipulacion_archivo.asm) | Crea un archivo de texto, escribe en él, lo cierra, lo vuelve a abrir y muestra su contenido. |

## Cómo ejecutar

1. Abrir Visual Studio 2022 con un proyecto MASM configurado con la librería **Irvine32**.
2. Agregar el archivo `.asm` de la práctica deseada al proyecto (solo uno a la vez como punto de entrada).
3. Compilar y ejecutar (`Ctrl + F5`).

## Estructura

```
.
├── README.md
└── src/
    ├── 00_hola_mundo.asm
    ├── 01_ciclos_numericos.asm
    └── ...
```
