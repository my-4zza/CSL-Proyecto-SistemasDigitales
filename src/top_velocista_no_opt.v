// Autor: Azael (Aza) / Antonio de Jesús
// Fecha: 03/06/26
// Versión: 1.0
// Descripción: Implementación de navegación avanzada mediante la lectura de 
// 5 sensores. Se añade lógica de enclavamiento (latch) para el sensor START 
// (Flash LDR), por lo que ya no requiere activación continua. Incluye generador 
// PWM a ~10 kHz, control de velocidad configurado al 50% y lógica de giros 
// tipo tanque (inversión de giro en una rueda) para tomar curvas cerradas.
// ============================================================================
module line_follower_min_speed (
    input wire clk,      // Reloj de 27 MHz
    input wire S1,       // Extremo Izquierdo
    input wire S2,       // Medio Izquierdo
    input wire S3,       // Centro
    input wire S4,       // Medio Derecho
    input wire S5,       // Extremo Derecho
    input wire START,    // LDR Sensor (Flash)
    
    // Pines Motor A (Izquierdo)
    output reg PWMA,
    output reg AIN1,
    output reg AIN2,
    
    // Pines Motor B (Derecho)
    output reg PWMB,
    output reg BIN1,
    output reg BIN2
);

    // ==========================================
    // PARÁMETROS CONFIGURABLES
    // ==========================================
    parameter LINE_VAL = 1'b1;  
    parameter FLASH_VAL = 1'b0; 

    // ==========================================
    // AJUSTE DE VELOCIDAD (Configurado al 50%)
    // ==========================================
    parameter SPD_MAX  = 12'd1350;   // 50% de 2700 - Velocidad para avanzar recto
    
    // Ligeramente ajustado para mantener proporción en curvas suaves
    parameter SPD_SLOW = 12'd250;    
    
    // 50% de potencia a la rueda en reversa para curvas bruscas
    parameter SPD_TURN = 12'd1350;   
    
    parameter SPD_STOP = 12'd0;      // Parada total

    // ==========================================
    // LÓGICA DE ACTIVACIÓN (FLASH LDR)
    // ==========================================
    reg running = 1'b0;
    always @(posedge clk) begin
        if (START == FLASH_VAL) begin
            running <= 1'b1;
        end
    end

    // ==========================================
    // NORMALIZACIÓN DE SENSORES
    // ==========================================
    wire s1_act = (S1 == LINE_VAL);
    wire s2_act = (S2 == LINE_VAL);
    wire s3_act = (S3 == LINE_VAL);
    wire s4_act = (S4 == LINE_VAL);
    wire s5_act = (S5 == LINE_VAL);
    
    wire [4:0] current_sensors = {s1_act, s2_act, s3_act, s4_act, s5_act};

    // ==========================================
    // MÁQUINA DE ESTADOS / DIRECCIÓN Y VELOCIDAD
    // ==========================================
    reg [11:0] duty_A = 0; 
    reg [11:0] duty_B = 0; 

    always @(posedge clk) begin
        if (!running) begin
            duty_A <= SPD_STOP; duty_B <= SPD_STOP;
            AIN1 <= 0; AIN2 <= 0; BIN1 <= 0; BIN2 <= 0;
        end else begin
            
            case (current_sensors)
                // --- TODO BLANCO: PARARSE ---
                5'b00000: begin 
                    AIN1 <= 1'b0; AIN2 <= 1'b0; duty_A <= SPD_STOP; 
                    BIN1 <= 1'b0; BIN2 <= 1'b0; duty_B <= SPD_STOP; 
                end

                // --- CENTRADO PERFECTO ---
                5'b00100: begin 
                    AIN1 <= 1'b0; AIN2 <= 1'b1; duty_A <= SPD_MAX; 
                    BIN1 <= 1'b0; BIN2 <= 1'b1; duty_B <= SPD_MAX; 
                end
                
                // --- DESVÍO LEVE A LA IZQUIERDA ---
                5'b01100, 5'b01000: begin 
                    AIN1 <= 1'b0; AIN2 <= 1'b1; duty_A <= SPD_SLOW; 
                    BIN1 <= 1'b0; BIN2 <= 1'b1; duty_B <= SPD_MAX;  
                end
                
                // --- CURVA CERRADA A LA IZQUIERDA (Giro Tanque Fuerte) ---
                5'b11000, 5'b10000, 5'b11100: begin 
                    AIN1 <= 1'b1; AIN2 <= 1'b0; duty_A <= SPD_TURN; // Reversa izquierda
                    BIN1 <= 1'b0; BIN2 <= 1'b1; duty_B <= SPD_MAX;  // Adelante derecha
                end
                
                // --- DESVÍO LEVE A LA DERECHA ---
                5'b00110, 5'b00010: begin 
                    AIN1 <= 1'b0; AIN2 <= 1'b1; duty_A <= SPD_MAX;  
                    BIN1 <= 1'b0; BIN2 <= 1'b1; duty_B <= SPD_SLOW; 
                end
                
                // --- CURVA CERRADA A LA DERECHA (Giro Tanque Fuerte) ---
                5'b00011, 5'b00001, 5'b00111: begin 
                    AIN1 <= 1'b0; AIN2 <= 1'b1; duty_A <= SPD_MAX;  // Adelante izquierda
                    BIN1 <= 1'b1; BIN2 <= 1'b0; duty_B <= SPD_TURN; // Reversa derecha
                end
                
                // --- INTERSECCIÓN O LÍNEA COMPLETA ---
                5'b11111: begin 
                    AIN1 <= 1'b0; AIN2 <= 1'b1; duty_A <= SPD_MAX;
                    BIN1 <= 1'b0; BIN2 <= 1'b1; duty_B <= SPD_MAX;
                end
                
                default: begin
                    AIN1 <= 1'b0; AIN2 <= 1'b1; duty_A <= SPD_MAX;
                    BIN1 <= 1'b0; BIN2 <= 1'b1; duty_B <= SPD_MAX;
                end
            endcase
        end
    end

    // ==========================================
    // GENERADOR PWM (Frecuencia ~ 10 kHz)
    // ==========================================
    reg [11:0] pwm_counter = 0;
    always @(posedge clk) begin
        if (pwm_counter < 12'd2699)
            pwm_counter <= pwm_counter + 1;
        else
            pwm_counter <= 0;
    end

    always @(posedge clk) begin
        PWMA <= (pwm_counter < duty_A) ? 1'b1 : 1'b0;
        PWMB <= (pwm_counter < duty_B) ? 1'b1 : 1'b0;
    end

endmodule
