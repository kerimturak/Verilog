`timescale 1ns / 1ps
module RIPPLE_ADDER(
    input [3:0] X,
    input [3:0] Y,
    input CARRY_IN,

    output [3:0] SUM,
    output CARRY_OUT
    );

    wire [3:0] CARRY_I;
    assign CARRY_IN [0] = CARRY_IN;
    genvar i;
    generate
        for (i=0; i<4; i = i+1)begin
            FULL_ADDER_DATA_FLOW FA(X[i], Y[i], CARRY_IN[i], SUM[i], CARRY_OUT[i]);
        end
    endgenerate
endmodule
