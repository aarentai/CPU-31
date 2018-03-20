`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/03/08 19:39:51
// Design Name: 
// Module Name: MULT
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


module MULT(
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
            z <= 0;
            
        else
        begin
            mult1 = a[31] ? (~({ {33{a[31]}} , a[30:0]}) + 1) : {32'h00000000,a};
            mult2 = b[31] ? (~b + 1) : b;
            result = 0;
            
            for(i = 0;i < 32;i = i + 1)
            begin
                if(mult2[0])
                begin
                    result = result + mult1;
                end
                
                mult1 = mult1 << 1;
                mult2 = mult2 >> 1;
            end
            
            result[63] = 0;
            
            if((a[31]==1&&b[31]==1)||(a[31]==0&&b[31]==0))
            begin
                z = result;
            end
            else
            begin
               z = ~result + 1; 
            end
        end
    end 
endmodule
