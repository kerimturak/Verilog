`timescale 1ns / 1ps
module ADD(
    input X,
    input Y,
    input CARRY_IN,

    output CARRY_GENERATOR,
    output CARRY_PROPAGATOR,
    output SUM
    );
    assign SUM = X ^ Y ^ CARRY_IN;
    assign CARRY_GENERATOR  = X & Y;
    assign CARRY_PROPAGATOR = X | Y;
endmodule
