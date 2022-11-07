module CLA_2 (
    input [1:0] X,
    input [1:0] Y,
    input CARRY_IN,

    output G_OUT,
    output P_OUT,
    output [1:0] SUM
);

wire [1:0] G, P; 
wire CARRY_OUT; 

ADD a0 (X[0], Y[0], CARRY_IN,  G[0], P[0], SUM[0]); 
ADD a1 (X[1], Y[1], CARRY_OUT, G[1], P[1], SUM[1]); 

GP GP0 (G, P, CARRY_IN, G_OUT, P_OUT, CARRY_OUT);

endmodule