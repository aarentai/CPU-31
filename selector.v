`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/11/23 19:47:14
// Design Name: 
// Module Name: selector
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


module selector(
    input [31:0] iData00,
    input [31:0] iData01,
    input [31:0] iData02,
    input [31:0] iData03,
    input [31:0] iData04,
    input [31:0] iData05,
    input [31:0] iData06,
    input [31:0] iData07,
    input [31:0] iData08,
    input [31:0] iData09,
    input [31:0] iData10,
    input [31:0] iData11,
    input [31:0] iData12,
    input [31:0] iData13,
    input [31:0] iData14,
    input [31:0] iData15,
    input [31:0] iData16,
    input [31:0] iData17,
    input [31:0] iData18,
    input [31:0] iData19,
    input [31:0] iData20,
    input [31:0] iData21,
    input [31:0] iData22,
    input [31:0] iData23,
    input [31:0] iData24,
    input [31:0] iData25,
    input [31:0] iData26,
    input [31:0] iData27,
    input [31:0] iData28,
    input [31:0] iData29,
    input [31:0] iData30,
    input [31:0] iData31,
    input [4:0] addr,
    input ena,
    output reg [31:0] oData
    );
    
    always@(*)
    begin
    if(ena)
    begin
        case(addr)
            5'b00000:oData<=iData00;
            5'b00001:oData<=iData01;
            5'b00010:oData<=iData02;
            5'b00011:oData<=iData03;
            5'b00100:oData<=iData04;
            5'b00101:oData<=iData05;
            5'b00110:oData<=iData06;
            5'b00111:oData<=iData07;
            5'b01000:oData<=iData08;
            5'b01001:oData<=iData09;
            5'b01010:oData<=iData10;
            5'b01011:oData<=iData11;
            5'b01100:oData<=iData12;
            5'b01101:oData<=iData13;
            5'b01110:oData<=iData14;
            5'b01111:oData<=iData15;
            5'b10000:oData<=iData16;
            5'b10001:oData<=iData17;
            5'b10010:oData<=iData18;
            5'b10011:oData<=iData19;
            5'b10100:oData<=iData20;
            5'b10101:oData<=iData21;
            5'b10110:oData<=iData22;
            5'b10111:oData<=iData23;
            5'b11000:oData<=iData24;
            5'b11001:oData<=iData25;
            5'b11010:oData<=iData26;
            5'b11011:oData<=iData27;
            5'b11100:oData<=iData28;
            5'b11101:oData<=iData29;
            5'b11110:oData<=iData30;
            5'b11111:oData<=iData31;
        endcase
    end
    else
        oData<=32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;     
    end
endmodule
