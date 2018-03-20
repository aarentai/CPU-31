`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/12 22:51:35
// Design Name: 
// Module Name: MUX1
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


module mux1(
    input [31:0] data1,
    input [31:0] data2,
    input pos,
    output reg [31:0] data
    );
    always@(*)
    begin
        if(pos)
            data <= data2;
        else
            data <= data1;
    end
endmodule
