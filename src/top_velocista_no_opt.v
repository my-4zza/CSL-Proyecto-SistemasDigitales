// Autor: Antonio Portilla
// Fecha: 31/05/26
// Versión: 0.2
// Descripción: Se implementa la lectura de los 3 sensores centrales para 
// navegación básica. START sigue requiriendo ser presionado continuamente.
// ============================================================================
module control_velocista (
    input clk,   
    input START, 
    input S1, S2, S3, S4, S5, 
    output PWMA, output AIN1, output AIN2,
    output PWMB, output BIN1, output BIN2
);

    wire run_enable = ~START;
    assign PWMA = run_enable;
    assign PWMB = run_enable;

    // Solo usamos los sensores centrales (negados por lógica del sensor)
    wire sens2 = ~S2; 
    wire sens3 = ~S3;
    wire sens4 = ~S4; 

    // Lógica simple: Si detecta la línea a la izquierda, apaga el motor izquierdo
    wire izq = sens2;
    wire der = sens4;

    assign AIN2 = run_enable & ~izq; // Motor izquierdo
    assign AIN1 = 1'b0;
    assign BIN2 = run_enable & ~der; // Motor derecho
    assign BIN1 = 1'b0;

endmodule
