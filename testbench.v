`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/31 20:50:31
// Design Name: 
// Module Name: top_tb
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


module testbench;
    reg clk;
    reg rst;
initial
begin
rst=1;
clk=1;
#20 rst=0;
end
always #20 clk=~clk;

        top top_module(
                    .clk_in(clk),
                    .rst(rst)
                    );
endmodule
