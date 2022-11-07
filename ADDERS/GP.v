module GP (
    input [1:0] G,
    input [1:0] P,
    input CARRY_IN,
    output G_OUT,
    output P_OUT,
    output CARRY_OUT
    ); 

    assign G_OUT = G[1] | P[1] & G[0]; 
    assign P_OUT = P[1] & P[0]; 
    assign CARRY_OUT = G[0] | P[0] & CARRY_IN; 
endmodule