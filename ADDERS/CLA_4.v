`timescale 1ns / 1ps
module CLA_4(
    input [3:0] X,
    input [3:0] Y,
    input CARRY_IN,

    output G_OUT,
    output P_OUT,
    output [3:0] SUM
); 

wire [1:0] G, P; 
wire CARRY_OUT; 

CLA_2 a0 (X[1:0], Y[1:0], CARRY_IN, G[0], P[0], SUM[1:0]); 
CLA_2 a1 (X[3:2], Y[3:2], CARRY_OUT, G[1], P[1], SUM[3:2]); 

GP GP0 (G, P, CARRY_IN, G_OUT, P_OUT, CARRY_OUT); 
endmodule
