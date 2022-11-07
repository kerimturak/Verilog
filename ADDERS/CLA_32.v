`timescale 1ns / 1ps
module CLA_32(
    input [31:0] X,
    input [31:0] Y,
    input CARRY_IN,

    output G_OUT,
    output P_OUT,
    output [31:0] SUM
); 

wire [1:0] G, P; 
wire CARRY_OUT; 

CLA_16 a0 (X[15:0], Y[15:0], CARRY_IN, G[0], P[0], SUM[15:0]); 
CLA_16 a1 (X[31:16], Y[31:16], CARRY_OUT, G[1], P[1], SUM[31:16]); 

GP GP0 (G, P, CARRY_IN, G_OUT, P_OUT, CARRY_OUT); 
endmodule
