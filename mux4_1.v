`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/12 22:53:05
// Design Name: 
// Module Name: MUX2
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


module mux2(
    input [31:0] data1,
    input [31:0] data2,
    input [31:0] data3,
    input [31:0] data4,
    input [1:0] pos,
    output reg [31:0] data
    );
    always@(*)
    begin
        case(pos)
        2'b00: data <= data1;
        2'b01: data <= data2;
        2'b10: data <= data3;
        2'b11: data <= data4;
        endcase
    end
endmodule
