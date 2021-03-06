# TP-SOFTCORE-CONTADOR-UART

## Alcance
El trabajo práctico final de la materia consiste en la implementación de un bloque de hardware
digital que deberá ser descripto en lenguaje VHDL (IP Core), simulado e implementado en un kit
de FPGA. Dicho bloque deberá formar parte de un sistema base de procesamiento que incluya
el micro Cortex A9. Se deberá implementar la conectividad entre el PS y la PL. El core
recibirá/enviará datos desde/hacia el procesador. Dicho funcionamiento deberá ser
implementado a través de un código C.
El bloque será elegido por el alumno y deberá ser alguna parte constitutiva de su trabajo práctico
final de carrera. En el caso en que este último requerimiento sea de difícil concreción la cátedr a
indicará el bloque a implementar o se aceptarán sugerencias de parte del alumno.


## Simulación
https://github.com/jonathancagua/test_ghdl/tree/main/contador

## Propósito
El presente trabajo es para realizar un componente de hardware para un contador ascendente y descendente controlado por uart.
La velocidad que se va controlar es a 9600 bps y sin control de flujo.
Se va enviar un carácter por puerto serial, cuando se envía el carácter “A” el contador va ser ascendente y cuando se envía la tecla “B” es un contador descendente.
Se debe presentar el valor en los leds de la placa de desarrollo.
Creación de un archivo bitstream.
Montaje de un convertidor usb-serial.

## Introducción teórica 
Un contador ascendente/descendente (up/down) es aquel capaz de procesar en cualquier dirección a lo largo de una cierta secuencia. Un contador ascendente/descendente, algunas veces también denominado contador bidireccional, puede tener cualquier secuencia de estados especificada. Un contador binario de 3 bits que avanza en modo ascendente a través de la secuencia (0,1,2,3,4,5,6,7) y que luego pueda invertirse para recorrer la secuencia en sentido contrario (7,6,5,4,3,2,1,0) es un ejemplo de un modo de operación secuencial ascendente/descendente.
