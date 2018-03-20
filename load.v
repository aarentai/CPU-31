`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/26 17:10:59
// Design Name: 
// Module Name: forLoad
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


module forLoad(
    input [31:0] data,
    input lb,
    input lbu,
    input lh,
    input lhu,
    output reg [31:0] result
    );
    always@(*)
    begin
        if(lb == 1)
        begin
            result = { {24 {data[7]}},data[7:0]};
        end
        else
        begin
            if(lbu == 1)
            begin
                result = { 24'b000000000000000000000000,data[7:0]};
            end
            else
            begin
                if(lh == 1)
                begin
                    result = {{16{data[15]}},data[15:0]};
                end
                else
                begin
                    if(lhu == 1)
                    begin
                        result = {16'h0000000000000000,data[15:0]};
                    end
                    else
                        result = data;
                end
            end
        end
    end
endmodule
