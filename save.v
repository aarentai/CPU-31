`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/27 15:13:40
// Design Name: 
// Module Name: forSave
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


module forSave(
    input [31:0] data,
    input sb,
    input sh,
    output reg [31:0] result
    );
    always@(*)
        begin
        if(sb == 1)
        begin
            result = { {24 {data[7]}},data[7:0]};
        end
        else
        begin
            if(sh == 1)
            begin
                result = {{16{data[15]}},data[15:0]};
            end
            else
            begin
                result = data;
            end
        end
    end
endmodule
