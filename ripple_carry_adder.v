//=========================================================================
// Name & Email must be EXACTLY as in Gradescope roster!
// Name: Jonathan Clarke
// Email: jclar084@ucr.edu
// 
// Assignment name: Lab02
// Lab section: 021
// TA: 
// 
// I hereby certify that I have not received assistance on this assignment,
// or used code, from ANY outside source other than the instruction team
// (apart from what was provided in the starter file).
//
//=========================================================================

`timescale 1ns / 1ps

//  Constant definitions 

module ripple_carry_adder # ( parameter NUMBITS = 16 ) (
    input  wire[NUMBITS-1:0] A, 
    input  wire[NUMBITS-1:0] B, 
    input wire carryin, 
    output reg [NUMBITS-1:0] result,  
    output reg carryout); 

    module full_adder (
        input  wire a,
        input  wire b,
        input  wire carryin,
        output wire sum,
        output wire carryout
    );
        assign sum = a ^ b ^ carryin;
        assign carryout = (a & b) | (carryin & (a ^ b));
    endmodule

    reg carry;
    wire[NUMBITS-1:0] sum;

    full_adder adder_0 (
        .a(A[0]),
        .b(B[0]),
        .carryin(carryin),
        .sum(sum[0]),
        .carryout(carry)
    );

    for (int i = 1; i < NUMBITS; i = i + 1) begin
        full_adder adder (
            .a(A[i]),
            .b(B[i]),
            .carryin(carry),
            .sum(sum[i]),
            .carryout(carry)
        );
    end

    assign result = sum;
    assign carryout = carry;

endmodule
