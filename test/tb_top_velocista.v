//Autor: José Santiago Alegría Ponce
// Versión: 0.1.0
// Descripción: Lógica principal con retardo de seguridad, PWM 
// y control diferencial mediante arreglo de 5 sensores.

module velocista #(
    parameter MAX_DELAY = 25'd27_000_000 // Permite sobreescribir el tiempo en simulaciones
)(
    input clk,
    input START,
    input S1, S2, S3, S4, S5,
    output reg PWMA,
    output reg AIN1,
    output reg AIN2,
    output reg PWMB,
    output reg BIN1,
    output reg BIN2
);

    //Lógica de Arranque 
    reg running = 1'b0;
    reg start_sync_1 = 1'b0;
    reg start_sync_2 = 1'b0;
    
    reg [24:0] delay_counter = 0;
    reg armed = 1'b0;

    always @(posedge clk) begin
        if (!armed) begin
            delay_counter <= delay_counter + 1;
            if (delay_counter == MAX_DELAY) begin
                armed <= 1'b1;
            end
            start_sync_1 <= START;
            start_sync_2 <= START;
        end else begin
            start_sync_1 <= START;
            start_sync_2 <= start_sync_1;
            
            // Disparo oficial con el flash de luz 
            if (start_sync_1 && !start_sync_2) begin
                running <= 1'b1;
            end
        end
    end

    // Generador de PWM
    reg [9:0] pwm_counter = 0;
    always @(posedge clk) begin
        pwm_counter <= pwm_counter + 1;
    end

    reg [9:0] speed_A; 
    reg [9:0] speed_B; 

    always @(posedge clk) begin
        PWMA <= (pwm_counter < speed_A) ? 1'b1 : 1'b0;
        PWMB <= (pwm_counter < speed_B) ? 1'b1 : 1'b0;
    end

    // Lógica de Navegación y Control Diferencial
    always @(posedge clk) begin
        if (!running) begin
            speed_A <= 0; speed_B <= 0;
            AIN1 <= 0; AIN2 <= 0;
            BIN1 <= 0; BIN2 <= 0;
        end else begin
            AIN1 <= 1'b0; AIN2 <= 1'b1; // Adelante Izquierdo
            BIN1 <= 1'b0; BIN2 <= 1'b1; // Adelante Derecho

            casex ({S1, S2, S3, S4, S5})
                // --- AVANCE PERFECTO ---
                5'bxx1xx: begin 
                    speed_A <= 10'd1023; 
                    speed_B <= 10'd1023; 
                end
                
                // --- CORRECCIONES LIGERAS ---
                5'bx10xx: begin 
                    speed_A <= 10'd400; 
                    speed_B <= 10'd1023; 
                end
                5'bxxx1x: begin 
                    speed_A <= 10'd1023; 
                    speed_B <= 10'd400; 
                end

                // --- GIROS BRUSCOS ---
                5'b1xxxx: begin 
                    AIN1 <= 1'b1; AIN2 <= 1'b0; // REVERSA Izquierda
                    speed_A <= 10'd800; 
                    speed_B <= 10'd1023; 
                end
                5'bxxxx1: begin 
                    BIN1 <= 1'b1; BIN2 <= 1'b0; // REVERSA Derecha
                    speed_A <= 10'd1023; 
                    speed_B <= 10'd800; 
                end
                
                // --- PERDIÓ LA LÍNEA ---
                default: begin
                    speed_A <= 10'd500; 
                    speed_B <= 10'd500;
                end
            endcase
        end
    end
endmodule
