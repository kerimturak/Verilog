`timescale 1ns / 1ps
module CLA_16(
    input [15:0] X,
    input [15:0] Y,
    input CARRY_IN,

    output G_OUT,
    output P_OUT,
    output [15:0] SUM
); 

wire [1:0] G, P; 
wire CARRY_OUT; 

CLA_8 a0 (X[7:0], Y[7:0], CARRY_IN, G[0], P[0], SUM[7:0]); 
CLA_8 a1 (X[15:8], Y[15:8], CARRY_OUT, G[1], P[1], SUM[15:8]); 

GP GP0 (G, P, CARRY_IN, G_OUT, P_OUT, CARRY_OUT); 
endmodule
