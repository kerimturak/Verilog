`timescale 1ns / 1ps
module CLA_8(
    input [7:0] X,
    input [7:0] Y,
    input CARRY_IN,

    output G_OUT,
    output P_OUT,
    output [7:0] SUM
); 

wire [1:0] G, P; 
wire CARRY_OUT; 

CLA_4 a0 (X[3:0], Y[3:0], CARRY_IN, G[0], P[0], SUM[3:0]); 
CLA_4 a1 (X[7:4], Y[7:4], CARRY_OUT, G[1], P[1], SUM[7:4]); 

GP GP0 (G, P, CARRY_IN, G_OUT, P_OUT, CARRY_OUT); 
endmodule
