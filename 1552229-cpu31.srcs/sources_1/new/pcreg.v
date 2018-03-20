`timescale 1ns / 1ps
module pcreg(
input clk, //下降沿时为寄存器赋值
input rst, //高电平时清零
input ena, //1 位输入,有效信号高电平时PC 寄存器读入data_in
//的值，否则保持原有输出
input [31:0] wdata, //32 位输入，输入数据将被存入寄存器内部
output reg [31:0] data_out //32 位输出，工作时始终输出 PC
//寄存器内部存储的值
    );
    always @(posedge clk or posedge rst)
    begin
    if(rst)data_out=32'b00000000000000000000000000000000;
    else
    begin
    if(ena)data_out[31:0]=wdata[31:0];
    else data_out[31:0]=data_out[31:0];
    end
    end
endmodule

