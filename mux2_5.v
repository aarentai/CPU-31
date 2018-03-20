`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/14 10:37:22
// Design Name: 
// Module Name: MUX2_5
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


module mux2_5(
    input [4:0] data1,
    input [4:0] data2,
    input [4:0] data3,
    input [4:0] data4,
    input [1:0] pos,
    output reg [4:0] data
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
