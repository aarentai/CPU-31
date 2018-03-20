`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/26 11:54:12
// Design Name: 
// Module Name: MUX3
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


module mux3(
    input [31:0] data1,
    input [31:0] data2,
    input [31:0] data3,
    input [31:0] data4,
    input [31:0] data5,
    input [31:0] data6,
    input [31:0] data7,
    input [31:0] data8,
    input [2:0] pos,
    output reg [31:0] data
    );
    always@(*)
    begin
        case(pos)
        3'b000: data <= data1;
        3'b001: data <= data2;
        3'b010: data <= data3;
        3'b011: data <= data4;
        3'b100: data <= data5;
        3'b101: data <= data6;
        3'b110: data <= data7;
        3'b111: data <= data8;
        endcase
    end
endmodule
