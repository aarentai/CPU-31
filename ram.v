`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/11/23 18:32:12
// Design Name: 
// Module Name: ram
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


module ram(
    input clk,
    input ena,
    input wena,
    input [31:0] addr,
    input [31:0] data_in,
    output reg [31:0] data_out,
    output reg [31:0] test_out
    );
    
    reg [31:0] memory [0:1023];
    
    always @ (posedge clk)
    begin
        if(ena)
            begin
                if(wena==1)
                    memory[addr-32'h10010000] <= data_in;
            end
    end
    
    always@(*)
    begin
        if(ena==1)
            data_out <= memory[addr-32'h10010000];
        else
            data_out <= 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
            
        test_out = memory[0];
    end
    
endmodule
