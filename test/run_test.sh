##Script para ejecutar pruebas 

`timescale 1ns/1ps

module tb_sensores();
    reg clk;
    reg START;
    reg S1, S2, S3, S4, S5;
    wire PWMA, AIN1, AIN2, PWMB, BIN1, BIN2;

    ( .MAX_DELAY(25'd100) ) uut (
        .clk(clk), .START(START),
        .S1(S1), .S2(S2), .S3(S3), .S4(S4), .S5(S5),
        .PWMA(PWMA), .AIN1(AIN1), .AIN2(AIN2),
        .PWMB(PWMB), .BIN1(BIN1), .BIN2(BIN2)
    );

    always #5 clk = ~clk; // Generador de reloj

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_sensores);

        // 1. ESTADO INICIAL
        clk = 0; START = 0;
        {S1, S2, S3, S4, S5} = 5'b00000;
        
        // Esperamos a que pase el retardo de seguridad (100 ciclos = 1000ns)
        #1500;

        // 2. DISPARO DEL CARRITO (Flash de luz simulado)
        $display("Arrancando el carrito...");
        START = 1; #50; 
        START = 0; #50;

        // 3. SECUENCIA DE SENSORES
        $display("Prueba: Avance Recto");
        {S1, S2, S3, S4, S5} = 5'b00100; #5000;

        $display("Prueba: Curva Ligera a la Izquierda");
        {S1, S2, S3, S4, S5} = 5'b01000; #5000;

        $display("Prueba: Curva Cerrada (Brusca) a la Izquierda");
        {S1, S2, S3, S4, S5} = 5'b10000; #5000;

        $display("Prueba: Perdida de linea");
        {S1, S2, S3, S4, S5} = 5'b00000; #5000;

        $finish;
    end
endmodule
