`timescale 1ns / 1ps
module regfile(
input clk, // 寄存器组时钟信号，下降沿写入数据
input rst, //reset信号，高电平有效，异步reset
input we, // 写有效信号， 高电平 时寄存器才能被写入，与clk异步！！！！低电平时允许寄存器读出数据
input [4:0] raddr1, // 所需读取的寄存器地址
input [4:0] raddr2, // 所需读取的寄存器地址
input [4:0] waddr, // 写寄存器的地址
input [31:0] wdata, // 写寄存器数据
output [31:0] rdata1, //raddr1 所对应寄存器的 输出 数据，
// 只要有 raddr 1的输入即出相应数据
output [31:0] rdata2, //raddr2 所对应寄存器的 输出 数据
// 只要有 raddr2
output flag,
output [15:0] reg28//28号寄存器的低16位是最后的输出
    );
    assign flag = (rdata1 == rdata2)?1'b1:1'b0;
reg [31:0] register [0:31]; //$1-$31
    initial register[0]=0;
    assign rdata1=(raddr1==0)?0:register[raddr1];    
    assign rdata2=(raddr2==0)?0:register[raddr2];
    assign reg28= register[28][15:0];////28号寄存器是最后的输出
    always@(negedge clk or posedge rst )
    begin
       if(rst==1)
         begin
         register[1]=0;
         register[2]=0;
         register[3]=0;
         register[4]=0;
         register[5]=0;
         register[6]=0;
         register[7]=0;
         register[8]=0;
         register[9]=0;
         register[10]=0;
         register[11]=0;
         register[12]=0;
         register[13]=0;
         register[14]=0;
         register[15]=0;
         register[16]=0;
         register[17]=0;
         register[18]=0;
         register[19]=0;
         register[20]=0;
         register[21]=0;
         register[22]=0;
         register[23]=0;
         register[24]=0;
         register[25]=0;
         register[26]=0;
         register[27]=0;
         register[28]=0;
         register[29]=0;
         register[30]=0;
         register[31]=0;
         end
       else
         begin
         if((waddr!=0)&&(we==1))
           register[waddr]=wdata;
         end
    end
    endmodule


