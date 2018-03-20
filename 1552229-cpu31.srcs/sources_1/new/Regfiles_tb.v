`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/11/30 16:23:31
// Design Name: 
// Module Name: Regfiles_tb
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


module Regfiles_tb;
reg clk; // 寄存器组时钟信号，下降沿写入数据
reg rst; //reset信号，高电平有效，异步reset
reg we; // 写有效信号， 高电平 时寄存器才能被写入，与clk异步！！！！
reg [4:0] raddr1; // 所需读取的寄存器地址
reg [4:0] raddr2; // 所需读取的寄存器地址
reg [4:0] waddr; // 写寄存器的地址
reg [31:0] wdata; // 写寄存器数据
wire [31:0] rdata1; //raddr1 所对应寄存器的 输出 数据，
// 只要有 raddr 1的输入即出相应数据
wire [31:0] rdata2; //raddr2 所对应寄存器的 输出 数据
always #50 clk<=~clk;
initial
begin
clk<='b0;
rst<='b0;
we<='b0;
#160 waddr<=5'b00110;wdata<=32'b00000000000000000001000100100010; raddr1<=5'b00110; raddr2<=5'b00011;we<='b1;
#100 waddr<=5'b00011;wdata<=32'b00000000000000001010101010111011;
#100 waddr<=5'b00110;wdata<=32'b00000000000000001111101010111100;rst<='b1;raddr1<=5'b00110;raddr2<=5'b00110;we<='b0;
#100 waddr<=5'b00101;wdata<=32'b00000000000000000000000000010001;raddr1<=5'b00101;raddr2<=5'b00100;
#100 waddr<=5'b00011;wdata<=32'b00000000000000000001001000110100;raddr1<=5'b00011;raddr2<=5'b00101;rst<='b0;
#100 waddr<=5'b00101;wdata<=32'b00000000000000001000100010001000;
#100 raddr1<=5'b00110;raddr2<=5'b00100;
#100 raddr1<=5'b00111;raddr2<=5'b00011;
end
Regfiles
Regfiles_inst(
.clk(clk),
.rst(rst),
.we(we),
.raddr1(raddr1),
.raddr2(raddr2),
.waddr(waddr),
.wdata(wdata),
.rdata1(rdata1),
.rdata2(rdata2)
);
endmodule
