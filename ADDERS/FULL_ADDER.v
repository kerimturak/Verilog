`timescale 1ns / 1ps
module FULL_ADDER_STRUCTURAL(
    input X,
    input Y,
    input CARRY_IN,

    output SUM,
    output CARRY_OUT
    );

    wire S0, S1, S2;

    xor (SUM, X, Y,  CARRY_IN);
    
    and (S0,  X,  Y);
    and (S1,  X,  CARRY_IN);
    and (S2,  Y,  CARRY_IN);
    or  (CARRY_OUT, S0, S1, S2);
endmodule

module FULL_ADDER_DATA_FLOW(
    input X,
    input Y,
    input CARRY_IN,

    output SUM,
    output CARRY_OUT
    );

    assign SUM = X ^ Y ^ CARRY_IN;
    assign CARRY_OUT = (X & Y) | (X & CARRY_IN) | (Y & CARRY_IN);
endmodule

module FULL_ADDER_BEHAVIORAL(
    input X,
    input Y,
    input CARRY_IN,

    output SUM,
    output CARRY_OUT
    );

    assign {CARRY_OUT, SUM} = X + Y + CARRY_IN;
endmodule
