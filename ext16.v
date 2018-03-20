`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/14 11:22:31
// Design Name: 
// Module Name: Ext16
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


module Ext16(
    input [15:0] data,
    input andi,
    input ori,
    input xori,
    output [31:0] result
    );
    assign result = (andi | ori | xori) ? { {16{1'b0}} , data}:{ {16{data[15]}},data};
endmodule
