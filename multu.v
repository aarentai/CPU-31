`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/03/08 18:51:03
// Design Name: 
// Module Name: MULTU
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


module MULTU(
       input reset,
       input [31:0] a,
       input [31:0] b,
       output reg [63:0] z 
    );
    reg [63:0] result;
    reg [63:0] mult1;
    reg [31:0] mult2;
    integer i;
    
    always@(*)
    begin
        if(reset)
        begin
            z <= 0;
        end
        
        else
        begin
            result = 0;
            mult1 = {32'h00000000,a};
            mult2 = b;
            
            for(i = 0;i < 32;i = i + 1)
            begin
                if(mult2[0])
                begin
                    result = result + mult1;
                end
                
                mult1 = mult1 << 1;
                mult2 = mult2 >> 1;
            end
            z = result;
        end
    end
endmodule
