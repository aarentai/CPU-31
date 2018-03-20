`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/15 21:16:49
// Design Name: 
// Module Name: iram
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


module iram(
    input clk,
    input ena,
    input [31:0] addr,
    input [31:0] data_in,
    output reg [31:0] data_out
    );
    
    reg [31:0] memory [0:1023];
    
    initial
    begin
        $readmemh("C:/test.txt",memory); 
    end
    
    always@(*)
    begin
        if(ena==1)
            data_out <= memory[{2'b00,addr[31:2]}];
        else
            data_out <= 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
    end
endmodule
