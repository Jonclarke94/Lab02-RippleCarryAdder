//=========================================================================
// Name & Email must be EXACTLY as in Gradescope roster!
// Name: Jonathan Clarke   
// Email: jclar084@ucr.edu
// 
// Assignment name: Lab 2
// Lab section: 021
// TA: 
// 
// I hereby certify that I have not received assistance on this assignment,
// or used code, from ANY outside source other than the instruction team
// (apart from what was provided in the starter file).
//
//=========================================================================

`timescale 1ns / 1ps

module ripple_carry_adder_tb;
    parameter NUMBITS = 8;

    // Inputs
    reg clk;
    reg reset;
    reg [NUMBITS-1:0] A;
    reg [NUMBITS-1:0] B;
    
    // Outputs
    wire [NUMBITS-1:0] result;
    reg [NUMBITS-1:0] expected_result;
    wire carryout;
    

    // -------------------------------------------------------
    // Setup output file for possible debugging uses
    // -------------------------------------------------------
    initial
    begin
        $dumpfile("lab02.vcd");
        $dumpvars(0);
    end

    // -------------------------------------------------------
    // Instantiate the Unit Under Test (UUT)
    // -------------------------------------------------------
        ripple_carry_adder #(.NUMBITS(NUMBITS)) uut (
        .A(A),
        .B(B),
        .carryin(1'b0),
        .result(result),
        .carryout(carryout)
    );
    // -------------------------------------------------------
    // Instantiate the 16-bit Unit Under Test (UUT)
    // -------------------------------------------------------
    // 
    // .
    // .
    // .
    //
    // -------------------------------------------------------
    // Instantiate the N-bit Unit Under Test (UUT)
    // -------------------------------------------------------
    
    initial begin 
    
        clk = 0; reset = 1; #50; 
        clk = 1; reset = 1; #50; 
        clk = 0; reset = 0; #50; 
        clk = 1; reset = 0; #50; 
         
        forever begin 
            clk = ~clk; #50; 
        end 
    end 
    
    integer totalTests = 0;
    integer failedTests = 0;
    
    initial begin // Test suite
        // Reset
        @(negedge reset); // Wait for reset to be released (from another initial block)
        @(posedge clk);   // Wait for first clock out of reset 
        #10; // Wait 10 cycles 

        // ---------------------------------------------
        // Test Group for Addition Behavior Verification 
        // --------------------------------------------- 
        $write("Test Group 1: Addition Behavior Verification ... \n");

        // Code necessary for each test case 
        totalTests = totalTests + 1;
        $write("\tTest Case 1.1:   0+  0 =   0, c_out = 0 ... ");
        A = 8'h00;
        B = 8'h00;
        expected_result = 8'h00;

        #100; // Wait 
        if (expected_result !== result || carryout !== 1'b0) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 
        

        
        // ----------------------------------------
        // Add more test cases here 
        // ----------------------------------------
             totalTests = totalTests + 1;
$write("\tTest Case 1.2:   127 + 1 = 128, c_out = 0 ... ");
A = 8'h7F;
B = 8'h01;
expected_result = 8'h80;

#100; // Wait 
if (expected_result !== result || carryout !== 1'b0) begin
    $write("failed\n");
    failedTests = failedTests + 1;
end else begin
    $write("passed\n");
end
#10; // Wait    

        // ----------------------------------------
        // Tests group for Increasing Number of Bits 
        // ----------------------------------------
        $write("Test Group 2: Increasing Number of Bits ...\n");
        
        // ----------------------------------------
        // Add test cases here 
        // ----------------------------------------
        totalTests = totalTests + 1;
    $write("\tTest Case 2.1:   5+  7 =  12, c_out = 0 ... ");
    A = 16'h0005;
    B = 16'h0007;
    expected_result = 16'h000C;
    #100; // Wait 
    if (expected_result !== result || carryout !== 1'b0) begin
        $write("failed\n");
        failedTests = failedTests + 1;
    end else begin
        $write("passed\n");
    end
    #10; // Wait 

    totalTests = totalTests + 1;
    $write("\tTest Case 2.3: 0x1234 + 0x5678 = 0x68AC, c_out = 0 ... ");
    A = 16'h1234;
    B = 16'h5678;
    expected_result = 16'h68AC;

    #100; // Wait 
    if (expected_result !== result || carryout !== 1'b0) begin
        $write("failed\n");
        failedTests = failedTests + 1;
    end else begin
        $write("passed\n");
    end
    #10; // Wait 
    totalTests = totalTests + 1;
    $write("\tTest Case 2.2: 0x12345678 + 0x87654321 = 0x9999999A, c_out = 0 ... ");
    A = 32'h12345678;
    B = 32'h87654321;
    expected_result = 32'h9999999A;

    #100; // Wait 
    if (expected_result !== result || carryout !== 1'b0) begin
        $write("failed\n");
        failedTests = failedTests + 1;
    end else begin
        $write("passed\n");
    end
    #10; // Wait 
        // -------------------------------------------------------
        // End testing
        // -------------------------------------------------------
        $write("\n-------------------------------------------------------");
        $write("\nTesting complete\nPassed %0d / %0d tests", totalTests-failedTests,totalTests);
        $write("\n-------------------------------------------------------\n");
        $finish;
    end
endmodule