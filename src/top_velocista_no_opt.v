// Versión: 0.1.0
// Descripción: Prueba básica de motores. El coche avanza solo mientras 
// el botón START se mantiene presionado. No hay lógica de sensores.
// Autor: Azael Pérez González
// Fecha: 28/05/26

module control_velocista (
    input clk,   
    input START, 
    // Los sensores se declaran pero no se usan aún
    input S1, S2, S3, S4, S5, 
    output PWMA, output AIN1, output AIN2,
    output PWMB, output BIN1, output BIN2
);

    // Activación directa de motores basada en el estado del botón (sin memoria)
    assign PWMA = ~START; // Suponiendo lógica negada en el botón temporalmente
    assign PWMB = ~START;

    // Configuración para avanzar hacia adelante
    assign AIN2 = ~START; 
    assign AIN1 = 1'b0;
    assign BIN2 = ~START; 
    assign BIN1 = 1'b0;

endmodule