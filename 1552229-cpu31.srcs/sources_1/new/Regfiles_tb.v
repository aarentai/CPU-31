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
reg clk; // �Ĵ�����ʱ���źţ��½���д������
reg rst; //reset�źţ��ߵ�ƽ��Ч���첽reset
reg we; // д��Ч�źţ� �ߵ�ƽ ʱ�Ĵ������ܱ�д�룬��clk�첽��������
reg [4:0] raddr1; // �����ȡ�ļĴ�����ַ
reg [4:0] raddr2; // �����ȡ�ļĴ�����ַ
reg [4:0] waddr; // д�Ĵ����ĵ�ַ
reg [31:0] wdata; // д�Ĵ�������
wire [31:0] rdata1; //raddr1 ����Ӧ�Ĵ����� ��� ���ݣ�
// ֻҪ�� raddr 1�����뼴����Ӧ����
wire [31:0] rdata2; //raddr2 ����Ӧ�Ĵ����� ��� ����
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
