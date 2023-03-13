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

//`include "full_adder.v"
`timescale 1ns / 1ps

//  Constant definitions 

module ripple_carry_adder # ( parameter NUMBITS = 32 ) (
    input  wire[NUMBITS-1:0] A, 
    input  wire[NUMBITS-1:0] B, 
    input wire carryin, 
    output reg [NUMBITS-1:0] result,  
    output reg carryout); 

    // ------------------------------
    // Insert your solution below
    // ------------------------------ 

    wire [NUMBITS:0] carry_temp;
    wire [NUMBITS-1:0] result_temp;

    assign carry_temp[0] = 0;

    genvar i;
    generate 
        for (i = 0; i < NUMBITS; i = i+1)
            begin
                full_adder FA1 (
                    .a(A[i]), 
                    .b(B[i]),
                    .c_in(carry_temp[i]),
                    .s(result_temp[i]),
                    .c_out(carry_temp[i+1])
                );
            end
    endgenerate

always @(*) begin
    result <= {carry_temp[NUMBITS], result_temp};
    carryout <= {carry_temp[NUMBITS]};
end

endmodule

