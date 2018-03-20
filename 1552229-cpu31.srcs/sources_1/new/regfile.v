`timescale 1ns / 1ps
module regfile(
input clk,
input rst,
input we,
input [4:0] raddr1,
input [4:0] raddr2,
input [4:0] waddr,
input [31:0] wdata,
output [31:0] rdata1,
output [31:0] rdata2,
output flag
//output dataa
    );
wire [31:0] ena;
wire data_out0[31:0];
wire data_out1[31:0];
wire data_out2[31:0];
wire data_out3[31:0];
wire data_out4[31:0];
wire data_out5[31:0];
wire data_out6[31:0];
wire data_out7[31:0];
wire data_out8[31:0];
wire data_out9[31:0];
wire data_out10[31:0];
wire data_out11[31:0];
wire data_out12[31:0];
wire data_out13[31:0];
wire data_out14[31:0];
wire data_out15[31:0];
wire data_out16[31:0];
wire data_out17[31:0];
wire data_out18[31:0];
wire data_out19[31:0];
wire data_out20[31:0];
wire data_out21[31:0];
wire data_out22[31:0];
wire data_out23[31:0];
wire data_out24[31:0];
wire data_out25[31:0];
wire data_out26[31:0];
wire data_out27[31:0];
wire data_out28[31:0];
wire data_out29[31:0];
wire data_out30[31:0];
wire data_out31[31:0];
assign flag = (rdata1 == rdata2)?1'b1:1'b0;
//assign dataa=data_out[1];
decoder decoder(waddr,we,ena);/*
pcreg reg0 (~clk,rst,~ena[0],wdata,data_out0);
pcreg reg1 (~clk,rst,~ena[1],wdata,data_out1);
pcreg reg2 (~clk,rst,~ena[2],wdata,data_out2);
pcreg reg3 (~clk,rst,~ena[3],wdata,data_out3);
pcreg reg4 (~clk,rst,~ena[4],wdata,data_out4);
pcreg reg5 (~clk,rst,~ena[5],wdata,data_out5);
pcreg reg6 (~clk,rst,~ena[6],wdata,data_out6);
pcreg reg7 (~clk,rst,~ena[7],wdata,data_out7);
pcreg reg8 (~clk,rst,~ena[8],wdata,data_out8);
pcreg reg9 (~clk,rst,~ena[9],wdata,data_out9);
pcreg reg10 (~clk,rst,~ena[10],wdata,data_out10);
pcreg reg11 (~clk,rst,~ena[11],wdata,data_out11);
pcreg reg12 (~clk,rst,~ena[12],wdata,data_out12);
pcreg reg13 (~clk,rst,~ena[13],wdata,data_out13);
pcreg reg14 (~clk,rst,~ena[14],wdata,data_out14);
pcreg reg15 (~clk,rst,~ena[15],wdata,data_out15);
pcreg reg16 (~clk,rst,~ena[16],wdata,data_out16);
pcreg reg17 (~clk,rst,~ena[17],wdata,data_out17);
pcreg reg18 (~clk,rst,~ena[18],wdata,data_out18);
pcreg reg19 (~clk,rst,~ena[19],wdata,data_out19);
pcreg reg20 (~clk,rst,~ena[20],wdata,data_out20);
pcreg reg21 (~clk,rst,~ena[21],wdata,data_out21);
pcreg reg22 (~clk,rst,~ena[22],wdata,data_out22);
pcreg reg23 (~clk,rst,~ena[23],wdata,data_out23);
pcreg reg24 (~clk,rst,~ena[24],wdata,data_out24);
pcreg reg25 (~clk,rst,~ena[25],wdata,data_out25);
pcreg reg26 (~clk,rst,~ena[26],wdata,data_out26);
pcreg reg27 (~clk,rst,~ena[27],wdata,data_out27);
pcreg reg28 (~clk,rst,~ena[28],wdata,data_out28);
pcreg reg29 (~clk,rst,~ena[29],wdata,data_out29);
pcreg reg30 (~clk,rst,~ena[30],wdata,data_out30);
pcreg reg31 (~clk,rst,~ena[31],wdata,data_out31);*/
pcreg reg0 (~clk,rst,~ena[0],wdata,rdata1[0]);
pcreg reg1 (~clk,rst,~ena[1],wdata,rdata1[1]);
pcreg reg2 (~clk,rst,~ena[2],wdata,rdata1[2]);
pcreg reg3 (~clk,rst,~ena[3],wdata,rdata1[3]);
pcreg reg4 (~clk,rst,~ena[4],wdata,rdata1[4]);
pcreg reg5 (~clk,rst,~ena[5],wdata,rdata1[5]);
pcreg reg6 (~clk,rst,~ena[6],wdata,rdata1[6]);
pcreg reg7 (~clk,rst,~ena[7],wdata,rdata1[7]);
pcreg reg8 (~clk,rst,~ena[8],wdata,rdata1[8]);
pcreg reg9 (~clk,rst,~ena[9],wdata,rdata1[9]);
pcreg reg10 (~clk,rst,~ena[10],wdata,rdata1[10]);
pcreg reg11 (~clk,rst,~ena[11],wdata,rdata1[11]);
pcreg reg12 (~clk,rst,~ena[12],wdata,rdata1[12]);
pcreg reg13 (~clk,rst,~ena[13],wdata,rdata1[13]);
pcreg reg14 (~clk,rst,~ena[14],wdata,rdata1[14]);
pcreg reg15 (~clk,rst,~ena[15],wdata,rdata1[15]);
pcreg reg16 (~clk,rst,~ena[16],wdata,rdata1[16]);
pcreg reg17 (~clk,rst,~ena[17],wdata,rdata1[17]);
pcreg reg18 (~clk,rst,~ena[18],wdata,rdata1[18]);
pcreg reg19 (~clk,rst,~ena[19],wdata,rdata1[19]);
pcreg reg20 (~clk,rst,~ena[20],wdata,rdata1[20]);
pcreg reg21 (~clk,rst,~ena[21],wdata,rdata1[21]);
pcreg reg22 (~clk,rst,~ena[22],wdata,rdata1[22]);
pcreg reg23 (~clk,rst,~ena[23],wdata,rdata1[23]);
pcreg reg24 (~clk,rst,~ena[24],wdata,rdata1[24]);
pcreg reg25 (~clk,rst,~ena[25],wdata,rdata1[25]);
pcreg reg26 (~clk,rst,~ena[26],wdata,rdata1[26]);
pcreg reg27 (~clk,rst,~ena[27],wdata,rdata1[27]);
pcreg reg28 (~clk,rst,~ena[28],wdata,rdata1[28]);
pcreg reg29 (~clk,rst,~ena[29],wdata,rdata1[29]);
pcreg reg30 (~clk,rst,~ena[30],wdata,rdata1[30]);
pcreg reg31 (~clk,rst,~ena[31],wdata,rdata1[31]);
endmodule
