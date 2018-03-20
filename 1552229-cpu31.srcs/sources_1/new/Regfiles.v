`timescale 1ns / 1ps
module regfile(
input clk, // �Ĵ�����ʱ���źţ��½���д������
input rst, //reset�źţ��ߵ�ƽ��Ч���첽reset
input we, // д��Ч�źţ� �ߵ�ƽ ʱ�Ĵ������ܱ�д�룬��clk�첽���������͵�ƽʱ����Ĵ�����������
input [4:0] raddr1, // �����ȡ�ļĴ�����ַ
input [4:0] raddr2, // �����ȡ�ļĴ�����ַ
input [4:0] waddr, // д�Ĵ����ĵ�ַ
input [31:0] wdata, // д�Ĵ�������
output [31:0] rdata1, //raddr1 ����Ӧ�Ĵ����� ��� ���ݣ�
// ֻҪ�� raddr 1�����뼴����Ӧ����
output [31:0] rdata2, //raddr2 ����Ӧ�Ĵ����� ��� ����
// ֻҪ�� raddr2
output flag,
output [15:0] reg28//28�żĴ����ĵ�16λ���������
    );
    assign flag = (rdata1 == rdata2)?1'b1:1'b0;
reg [31:0] register [0:31]; //$1-$31
    initial register[0]=0;
    assign rdata1=(raddr1==0)?0:register[raddr1];    
    assign rdata2=(raddr2==0)?0:register[raddr2];
    assign reg28= register[28][15:0];////28�żĴ������������
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


