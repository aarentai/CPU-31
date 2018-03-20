`timescale 1ns / 1ps
module pcreg(
input clk, //�½���ʱΪ�Ĵ�����ֵ
input rst, //�ߵ�ƽʱ����
input ena, //1 λ����,��Ч�źŸߵ�ƽʱPC �Ĵ�������data_in
//��ֵ�����򱣳�ԭ�����
input [31:0] wdata, //32 λ���룬�������ݽ�������Ĵ����ڲ�
output reg [31:0] data_out //32 λ���������ʱʼ����� PC
//�Ĵ����ڲ��洢��ֵ
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

