`timescale 1ns / 1ps
module CLA32_tb();
    reg [31:0] X;
    reg [31:0] Y;
    reg CARRY_IN;

    wire [31:0] SUM;

    CLA32 uut(X, Y, CARRY_IN, SUM);

    initial begin
        X = 0;
        Y = 0;
        CARRY_IN = 0;
        #10;

        X = 1;
        Y = 5;
        CARRY_IN = 0;
        #10;

        X = 5;
        Y = 5;
        CARRY_IN = 0;
        #10;

        X = 122;
        Y = 688;
        CARRY_IN = 0;
        #10;

        X = -100;
        Y = -455;
        CARRY_IN = 0;
        #10;

        X = -100;
        Y = 200;
        CARRY_IN = 0;
        #10;

        X = -200;
        Y = 100;
        CARRY_IN = 0;
        #10;

        X = 155;
        Y = 354;
        CARRY_IN = 0;
        #10;
    end
    
endmodule
