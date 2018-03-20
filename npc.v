`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/12 18:55:29
// Design Name: 
// Module Name: Add
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Add(
    input rst,
    input signed [31:0] a,
    input signed [31:0] b,
    output reg signed [31:0] result
    );
    always@(*)
    begin
        if(rst)
            result <= 32'h00000000;
        else
            result <= a + b;
    end
endmodule
