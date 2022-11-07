`timescale 1ns / 1ps
module CLA_64(
    input [63:0] X,
    input [63:0] Y,
    input CARRY_IN,

    output G_OUT,
    output P_OUT,
    output [63:0] SUM
); 

wire [1:0] G, P; 
wire CARRY_OUT; 

CLA_4 a0 (X[31:0], Y[31:0], CARRY_IN, G[0], P[0], SUM[31:0]); 
CLA_4 a1 (X[63:32], Y[63:32], CARRY_OUT, G[1], P[1], SUM[63:32]); 

GP GP0 (G, P, CARRY_IN, G_OUT, P_OUT, CARRY_OUT); 
endmodule
