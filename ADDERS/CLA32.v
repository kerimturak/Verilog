`timescale 1ns / 1ps
module CLA32(
    input [31:0] X,
    input [31:0] Y,
    input CARRY_IN,

    output [31:0] SUM
    );
    wire G_OUT, P_OUT;
    CLA_32 cla (X, Y, CARRY_IN, G_OUT, P_OUT, SUM); 
endmodule
