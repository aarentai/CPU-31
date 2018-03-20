`timescale 1ns / 1ps

module scan_led(clk1,dig,seg,dis_data,dis_dataf);
input clk1;//Ƶ�ʽ��ͺ��clk
input [15:0] dis_data;//������i2c_driveģ�����������
input [15:0] dis_dataf;
output reg [7:0] dig; // ������
output reg [6:0] seg; // ����ܵ�ѡ��
reg [3:0] hundredsc;//��λ
reg [3:0] tensc;//ʮλ
reg [3:0] onesc;//��λ
reg [7:0] valid_valuesc;//������ȡdis_datac[14:7]
reg [3:0] hundredsf;//��λ
reg [3:0] tensf;//ʮλ
reg [3:0] onesf;//��λ
reg [7:0] valid_valuesf;//������ȡdis_dataf[14:7]
reg[3:0] a=0;
 parameter AN0=8'b11111110,AN1=8'b11111101,AN2 = 8'b11111011,AN3 = 8'b11110111,AN4 = 8'b11101111,AN5 = 8'b11011111,AN6=8'b10111111,AN7=8'b01111111,//�����λѡ����  
 zero = 7'b100_0000,one = 7'b111_1001,two = 7'b010_0100,three = 7'b011_0000,four = 7'b001_1001,  
               five = 7'b001_0010,six = 7'b000_0010,seven = 7'b111_1000,eigth = 7'b000_0000,nine = 7'b001_0000; 

    integer i;

always @(posedge clk1) 
begin
//������תbcd��
valid_valuesc[7:0]=dis_data[14:7];
hundredsc=4'b0;
tensc=4'b0;
onesc=4'b0;
for(i=7;i>=0;i=i-1)
begin
    if(hundredsc>=5)hundredsc=hundredsc+3;
if(tensc>=5)tensc=tensc+3;
if(onesc>=5)onesc=onesc+3;

hundredsc=hundredsc<<1;
hundredsc[0]=tensc[3];
tensc=tensc<<1;
tensc[0]=onesc[3];
onesc=onesc<<1;
onesc[0]=valid_valuesc[i];
end
valid_valuesf[7:0]=dis_data[14:7]*18/10+32;
//valid_valuesf[7:0]=dis_dataf[7:0];
hundredsf=4'b0;
tensf=4'b0;
onesf=4'b0;
for(i=7;i>=0;i=i-1)
begin
if(hundredsf>=5)hundredsf=hundredsf+3;
if(tensf>=5)tensf=tensf+3;
if(onesf>=5)onesf=onesf+3;

hundredsf=hundredsf<<1;
hundredsf[0]=tensf[3];
tensf=tensf<<1;
tensf[0]=onesf[3];
onesf=onesf<<1;
onesf[0]=valid_valuesf[i];
end
//������ʾ
if(a==8)a=0;
else a<=a+1'd1; //����ܵ�ѡ��
               case(a)  
7:begin
                                case(hundredsf [3:0])  
                                0 : seg <= zero;  
                                1 : seg <= one;  
                                2 : seg <= two;  
                                3 : seg <= three;  
                                4 : seg <= four;  
                                5 : seg <= five;  
                                6 : seg <= six;  
                                7 : seg <= seven;  
                                8 : seg <= eigth;  
                                9 : seg <= nine;  
                                default:seg <= 7'b1111111;  
                              endcase  
                                 dig <= AN7;
                                          end  
               6:begin
                                case(tensf [3:0])  
                                0 : seg <= zero;  
                                1 : seg <= one;  
                                2 : seg <= two;  
                                3 : seg <= three;  
                                4 : seg <= four;  
                                5 : seg <= five;  
                                6 : seg <= six;  
                                7 : seg <= seven;  
                                8 : seg <= eigth;  
                                9 : seg <= nine;  
                                default:seg <= 7'b1111111;  
                              endcase  
                                 dig <= AN6;
                                          end
               5:begin
                                 case(onesf [3:0])  
                 0 : seg <= zero;  
                 1 : seg <= one;  
                 2 : seg <= two;  
                 3 : seg <= three;  
                 4 : seg <= four;  
                 5 : seg <= five;  
                 6 : seg <= six;  
                 7 : seg <= seven;  
                 8 : seg <= eigth;  
                 9 : seg <= nine;  
                 default:seg <= 7'b1111111;  
               endcase  
                  dig <= AN5;
                           end
               4:begin
                            seg <= 7'b0001110; 
                            dig <= AN4;
                            end
3:begin  
                    case(hundredsc [3:0])  
                    0 : seg <= zero;  
                    1 : seg <= one;  
                    2 : seg <= two;  
                    3 : seg <= three;  
                    4 : seg <= four;  
                    5 : seg <= five;  
                    6 : seg <= six;  
                    7 : seg <= seven;  
                    8 : seg <= eigth;  
                    9 : seg <= nine;  
                    default:seg <= 7'b1111111;  
                    endcase  
                    dig <= AN3;  //���ĸ������
                 end  
2:begin  
                    case(tensc [3:0])  
                    0 : seg <= zero;  
                    1 : seg <= one;  
                    2 : seg <= two;  
                    3 : seg <= three;  
                    4 : seg <= four;  
                    5 : seg <= five;  
                    6 : seg <= six;  
                    7 : seg <= seven;  
                    8 : seg <= eigth;  
                    9 : seg <= nine;  
                    default:seg <= 7'b1111111;  
                  endcase  
                    dig <= AN2;  
                 end
1:begin
                  case(onesc [3:0])  
                    0 : seg <= zero;  
                    1 : seg <= one;  
                    2 : seg <= two;  
                    3 : seg <= three;  
                    4 : seg <= four;  
                    5 : seg <= five;  
                    6 : seg <= six;  
                    7 : seg <= seven;  
                    8 : seg <= eigth;  
                    9 : seg <= nine;  
                    default:seg <= 7'b1111111;  
                  endcase  
                     dig <= AN1;             
               end
0:begin
                       seg <= 7'b1000110; 
                        dig <= AN0;
                        end
            endcase
            end
endmodule//��������ģ��


