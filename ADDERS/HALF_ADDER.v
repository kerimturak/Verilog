`timescale 1ns / 1ps
module HALF_ADDER_STRUCTURAL(
    input X,
    input Y,
    output SUM,
    output CARRY
    );

    xor (SUM, X, Y);
    and (CARRY, X, Y);
endmodule

module HALF_ADDER_DATA_FLOW(
    input X,
    input Y,
    output SUM,
    output CARRY
    );

    assign SUM   = X ^ Y;  
    assign CARRY = X & Y;
endmodule

module HALF_ADDER_BEHAVIORAL(
    input X,
    input Y,
    output SUM,
    output CARRY
    );

    assign {CARRY, SUM} = X + Y;
endmodule
