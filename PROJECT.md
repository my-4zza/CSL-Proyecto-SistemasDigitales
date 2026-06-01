# Proyecto: Carrito Seguidor de Línea (CSL)

## Objetivos
* Diseñar e implementar la lógica de control de un robot seguidor de línea utilizando un enfoque de descripción de hardware.
* Sintetizar el diseño en una FPGA Tang Nano 9K.
* Lograr la lectura eficiente de un arreglo de 5 sensores TCRT5000 para el control diferencial de motores DC.

## Producto Mínimo Viable (MVP)
El robot debe ser capaz de avanzar en línea recta, detectar desviaciones de la línea de contraste mediante el arreglo de sensores y corregir su trayectoria ajustando la velocidad (PWM) y sentido de giro de los motores reductores N20 a través del puente H TB6612FNG.

## Esquema de Hardware (Resumen)
* **Procesamiento:** FPGA Tang Nano 9K (Gowin).
* **Alimentación:** Batería LiPo Nano Tech 300mAh 2s (7.4V) regulada a voltajes lógicos mediante un conversor Buck MP1584.
* **Actuadores:** Puente H TB6612FNG controlando 2x Motorreductor GA12-N20.
* **Sensores:** Módulo 5 Sensores de línea TCRT5000 BFD-1000 + Sensor de Luz LDR Educabot.
