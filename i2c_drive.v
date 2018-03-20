`timescale 1ns / 1ps

module i2c_drive(
			clk,rst_n,
			sw1,sw2,
			scl,sda,
			dis_data,
			vga_rgb,
            hsync,//��ͬ��
            vsync,//��ͬ��
            dig,
            seg
		);

input  clk;		// 100MHz
input  rst_n;	//��λ�źţ�����Ч
input  sw1,sw2;	//����1��2,(1����ִ��д�������2����ִ�ж�����)
output scl;		// adt7420��ʱ�Ӷ˿�
output [11:0] vga_rgb; // ������
output hsync; // ����ܵ�ѡ��
output vsync;
inout  sda;		// adt7420�����ݶ˿�
output [15:0] dis_data;	//���ָ����Ԫ������
output [6:0] seg;
output [7:0] dig;
//--------------------------------------------
//�������
reg sw1_r,sw2_r;	//��ֵ����Ĵ�����ÿ20ms���һ�μ�ֵ 
reg[19:0] cnt_20ms;	//20ms�����Ĵ���

always @ (posedge clk or negedge rst_n)
	if(rst_n) 
	   cnt_20ms <= 20'd0;
	else 
	   cnt_20ms <= cnt_20ms+1'b1;	//���ϼ���

always @ (posedge clk or negedge rst_n)
	if(rst_n) 
		begin
			sw1_r <= 1'b1;	//��ֵ�Ĵ�����λ��û�м��̰���ʱ��ֵ��Ϊ1
			sw2_r <= 1'b1;
		end
	else if(cnt_20ms == 20'hfffff) 
		begin
			sw1_r <= sw1;	//����1ֵ����
			sw2_r <= sw2;	//����2ֵ����
		end

//---------------------------------------------
//��Ƶ����
reg[2:0] cnt;	// cnt=0:scl�����أ�cnt=1:scl�ߵ�ƽ�м䣬cnt=2:scl�½��أ�cnt=3:scl�͵�ƽ�м�
reg[8:0] cnt_delay;	//500ѭ������������iic����Ҫ��ʱ��
reg[31:0] count;
reg clk_led='b0;
reg scl_r;		//ʱ������Ĵ���

always @ (posedge clk or negedge rst_n)
	if(rst_n) 
	   cnt_delay <= 10'd0;
	else if(cnt_delay == 10'd999) 
	   cnt_delay <= 10'd0;	//������10usΪscl�����ڣ���100KHz
	else 
	   cnt_delay <= cnt_delay+1'b1;	//ʱ�Ӽ���
	   
always @ (posedge clk)
       if(rst_n)
       begin
           count<=0;
       end
       else
       begin
       if(count==32'd100000)
       begin
           clk_led<=~clk_led;
           count<=0;
       end
       else count<=count+1;
end

always @ (posedge clk or negedge rst_n) begin
	if(rst_n) 
	   cnt <= 3'd5;
	else 
	  begin
		 case (cnt_delay)
			9'd124:	cnt <= 3'd1;	//cnt=1:scl�ߵ�ƽ�м�,�������ݲ���
			9'd249:	cnt <= 3'd2;	//cnt=2:scl�½���
			9'd374:	cnt <= 3'd3;	//cnt=3:scl�͵�ƽ�м�,�������ݱ仯
			9'd499:	cnt <= 3'd0;	//cnt=0:scl������
			default: cnt <= 3'd5;
		  endcase
	  end
end


`define SCL_POS		(cnt==3'd0)		//cnt=0:scl������
`define SCL_HIG		(cnt==3'd1)		//cnt=1:scl�ߵ�ƽ�м�,�������ݲ���
`define SCL_NEG		(cnt==3'd2)		//cnt=2:scl�½���
`define SCL_LOW		(cnt==3'd3)		//cnt=3:scl�͵�ƽ�м�,�������ݱ仯


always @ (posedge clk or negedge rst_n)
	if(rst_n) 
	    scl_r <= 1'b0;
	else if(cnt==3'd0) 
	    scl_r <= 1'b1;	//scl�ź�������
   	else if(cnt==3'd2) 
        scl_r <= 1'b0;	//scl�ź��½���

assign scl = scl_r;	//����iic����Ҫ��ʱ��
//---------------------------------------------

//��Ҫд��adt7420�ĵ�ַ������			
`define	DEVICE_READ		8'b1001_0111	//��Ѱַ������ַ����������
`define DEVICE_WRITE	8'b1001_0110	//��Ѱַ������ַ��д������

`define	WRITE_DATA      8'b0000_0111	//д��EEPROM������
`define BYTE_ADDR       8'b0000_0000	//д��/����EEPROM�ĵ�ַ�Ĵ���	

reg[7:0] db_r;		//��IIC�ϴ��͵����ݼĴ���
reg[15:0] read_data;	//����EEPROM�����ݼĴ���

//---------------------------------------------
		//����дʱ��
parameter 	IDLE 	= 4'd0;//����
parameter 	START1 	= 4'd1;//����
parameter 	ADD1 	= 4'd2;//д��adt7420�ĵ�ַ
parameter 	ACK1 	= 4'd3;//adt7420����ack�ź�
parameter 	ADD2 	= 4'd4;//д���ַ�Ĵ����ĵ�ַ
parameter 	ACK2 	= 4'd5;//adt7420����ack�ź�
parameter 	START2 	= 4'd6;//�ڶ�������
parameter 	ADD3 	= 4'd7;//д��adt7420�ĵ�ַ
parameter 	ACK3	= 4'd8;//adt7420����ack�ź�
parameter 	DATA1 	= 4'd9;//�����¶ȼĴ����еĵ�һ���ֽ�
parameter 	ACK4	= 4'd10;//master����ack�ź�
parameter 	DATA2 	= 4'd11;//�����¶ȼĴ����еĵڶ����ֽ�
parameter 	NACK	= 4'd12;//master������ack�ź�
parameter 	STOP1 	= 4'd13;//ֹͣ
parameter 	STOP2 	= 4'd14;
parameter    NOP=4'd15;//��״̬
	
reg[3:0] cstate;	//״̬�Ĵ���
reg sda_r;		//������ݼĴ���
reg sda_link;	//�������sda�ź�inout�������λ		
reg[3:0] num;//��д�ֽ�ʱ�õ��ļ�����
wire [31:0] instruction;
always @ (posedge clk or negedge rst_n) begin
	if(rst_n) 
		begin
			cstate <= NOP;
			sda_r <= instruction[12];
			sda_link <= 0;
			num <= 0;
			read_data <= 0;
		end
	else 	  
		case (cstate)
		    NOP:
		      begin
		      sda_link <= instruction[13];
                                  sda_r <= instruction[12];
                                  if(!sw1_r || !sw2_r) 
                                      begin        
                                        db_r <= instruction[21:14];    
                                        cstate <= instruction[11:8];        
                                      end
                                  else 
                                     cstate <= IDLE;
		      end
			IDLE:	
				begin
					sda_link <= instruction[13];			
					sda_r <= instruction[12];
					if(!sw1_r || !sw2_r) 
						begin			
						  db_r <= instruction[21:14];	
						  cstate <= instruction[11:8];		
						end
					else 
					   cstate <= instruction[7:4];
				end
			START1: 
				begin
					if(`SCL_HIG) 
					    begin		//sclΪ�ߵ�ƽ�ڼ�
						  sda_link <= instruction[13];	//������sdaΪoutput
						  sda_r <= instruction[12];		//����������sda��������ʼλ�ź�
						  cstate <= instruction[11:8];
						  num <= 4'd0;		//num��������
						end
					else 
					    cstate <= instruction[7:4]; //�ȴ�scl�ߵ�ƽ�м�λ�õ���
				end
			ADD1:	
				begin
					if(`SCL_LOW) 
						begin
							if(num == 4'd8) 
								begin	
									num <= 4'd0;			//num��������
									sda_r <= instruction[12];
									sda_link <= instruction[13];		//sda��Ϊ����̬(input)
									cstate <= instruction[11:8];
								end
							else 
								begin
									cstate <= instruction[7:4];
									num <= num+1'b1;
									case (num)
										4'd0: sda_r <= db;
										4'd1: sda_r <= db;
										4'd2: sda_r <= db;
										4'd3: sda_r <= db;
										4'd4: sda_r <= db;
										4'd5: sda_r <= db;
										4'd6: sda_r <= db;
										4'd7: sda_r <= db;
										default: ;
									endcase
								end
						end
					else 
					   cstate <= instruction[3:0];
				end
			ACK1:	
				begin
					if(/*!sda*/`SCL_NEG) 
						begin	//ע��24C01/02/04/08/16�������Բ�����Ӧ��λ
							cstate <= instruction[11:8];	//�ӻ���Ӧ�ź�
							db_r <= instruction[21:14];	// 1��ַ		
						end
					else 
					   cstate <= instruction[7:4];		//�ȴ��ӻ���Ӧ
				end
			ADD2:	
				begin
					if(`SCL_LOW) 
						begin
							if(num==4'd8) 
								begin	
									num <= 4'd0;			//num��������
									sda_r <= instruction[12];
									sda_link <= instruction[13];		//sda��Ϊ����̬(input)
									cstate <= instruction[11:8];
								end
							else 
								begin
									sda_link <= 1'b1;		//sda��Ϊoutput
									num <= num+1'b1;
									case (num)
										4'd0: sda_r <= db;
										4'd1: sda_r <= db;
										4'd2: sda_r <= db;
										4'd3: sda_r <= db;
										4'd4: sda_r <= db;
										4'd5: sda_r <= db;
										4'd6: sda_r <= db;
										4'd7: sda_r <= db;
										default: ;
									endcase	
									cstate <= instruction[7:4];					
								end
						end
					else 
					    cstate <= instruction[3:0];				
				end
			ACK2:	begin
					if(/*!sda*/`SCL_NEG) begin		//�ӻ���Ӧ�ź�
						if(!sw1_r) begin
								cstate <= instruction[11:8]; 	//д����
								db_r <= instruction[21:14];	//д�������							
							end	
						else if(!sw2_r) begin
								db_r <= `DEVICE_READ;	//��������ַ�������������ض���ַ����Ҫִ�иò������²���
								cstate <= instruction[7:4];		//������
							end
						end
					else cstate <= instruction[3:0];	//�ȴ��ӻ���Ӧ
				end
			START2: begin	//��������ʼλ
					if(`SCL_LOW) begin
						sda_link <= instruction[13];	//sda��Ϊoutput
						sda_r <= instruction[12];		//����������sda
						cstate <= instruction[11:8];
						end
					else if(`SCL_HIG) begin	//sclΪ�ߵ�ƽ�м�
						sda_r <= instruction[12];		//����������sda��������ʼλ�ź�
						cstate <= instruction[7:4];
						end	 
					else cstate <= instruction[3:0];
				end
			ADD3:	begin	//�Ͷ�������ַ
					if(`SCL_LOW) begin
							if(num==4'd8) begin	
									num <= 4'd0;			//num��������
									sda_r <= instruction[12];
									sda_link <= instruction[13];		//sda��Ϊ����̬(input)
									cstate <= instruction[11:8];
								end
							else begin
									num <= num+1'b1;
									case (num)
										4'd0: sda_r <= db;
										4'd1: sda_r <= db;
										4'd2: sda_r <= db;
										4'd3: sda_r <= db;
										4'd4: sda_r <= db;
										4'd5: sda_r <= db;
										4'd6: sda_r <= db;
										4'd7: sda_r <= db;
										default: ;
										endcase
									cstate <= instruction[7:4];					
								end
						end
					else cstate <= instruction[3:0];				
				end
			ACK3:	begin
					if(/*!sda*/`SCL_NEG) begin
							cstate <= instruction[11:8];	//�ӻ���Ӧ�ź�
							sda_link <= instruction[13];
						end
					else cstate <= instruction[7:4]; 		//�ȴ��ӻ���Ӧ
				end
			DATA1:	begin
					if(!sw2_r) begin	 //������
							if(num<=4'd7) begin
								cstate <= instruction[11:8];
								if(`SCL_HIG) begin	
									num <= num+1'b1;	
									case (num)
										4'd0: read_data[15] <= sda;
										4'd1: read_data[14] <= sda;  
										4'd2: read_data[13] <= sda; 
										4'd3: read_data[12] <= sda; 
										4'd4: read_data[11] <= sda; 
										4'd5: read_data[10] <= sda; 
										4'd6: read_data[9] <= sda; 
										4'd7: read_data[8] <= sda; 
										default: ;
										endcase
									end
								end
							else if((`SCL_LOW) && (num==4'd8)) begin
								num <= 4'd0;			//num��������
								cstate <= instruction[7:4];
								end
							else cstate <= instruction[3:0];
						end
				end
			ACK4: begin//sclΪ�ߵ�ƽʱ��sdaҲΪ�͵�ƽ�������master���͵�ack
					if(/*!sda*/`SCL_HIG)
					 begin
					sda_link <= instruction[13];
						sda_r <= instruction[12];
						cstate <= instruction[11:8];						
						end
					else cstate <= instruction[7:4];
				end
		DATA2:	begin
                        if(!sw2_r) begin     //������
                                if(num<=4'd7) begin
                                    cstate <= instruction[11:8];
                                    if(`SCL_HIG) begin    
                                        num <= num+1'b1;    
                                        case (num)
                                            4'd0: read_data[7] <= sda;
                                            4'd1: read_data[6] <= sda;  
                                            4'd2: read_data[5] <= sda; 
                                            4'd3: read_data[4] <= sda; 
                                            4'd4: read_data[3] <= sda; 
                                            4'd5: read_data[2] <= sda; 
                                            4'd6: read_data[1] <= sda; 
                                            4'd7: read_data[0] <= sda; 
                                            default: ;
                                            endcase
                                        end
                                    end
                                else if((`SCL_LOW) && (num==4'd8)) begin
                                    num <= 4'd0;            //num��������
                                    cstate <= instruction[7:4];
                                    end
                                else cstate <= instruction[3:0];
                            end
                    end
                NACK: begin
                        if(/*!sda*/`SCL_HIG) begin//sclΪ�ߵ�ƽʱ��sdaҲΪ�ߵ�ƽ�������nack
                        sda_link <= instruction[13];
                           sda_r <= instruction[12];
                            cstate <= instruction[11:8];                        
                            end
                        else cstate <= instruction[7:4];
                    end
			STOP1:	begin
					if(`SCL_LOW) begin
							sda_link <= instruction[13];
							sda_r <= instruction[12];
							cstate <= instruction[11:8];
						end
					else if(`SCL_HIG) begin
							sda_r <= instruction[12];	//sclΪ��ʱ��sda���������أ������źţ�
							cstate <= instruction[7:4];
						end
					else cstate <= instruction[3:0];
				end
			STOP2:	begin
					if(`SCL_LOW) sda_r <= instruction[12];
					else if(cnt_20ms==20'hffff0) cstate <= instruction[11:8];
					else cstate <=  instruction[7:4];
				end
			default: cstate <= instruction[3:0];
			endcase
end

assign sda = sda_link ? sda_r:1'bz;
assign dis_data = read_data;

wire clk_cpu;
wire clk_vga;
wire [11:0]color;
Divider divider(
    .I_CLK(clk),
    .Rst(rst),
    .O_CLK(clk_vga)
    );

VGA_driver VGA_driver(
    .clk(clk_vga),
	.rst(rst),
	.dis_data(dis_data),
    .vga_rgb(vga_rgb),
    .hsync(hsync),//��ͬ��
    .vsync(vsync)//��ͬ��
    );
 
top top(
.clk_in(clk),
.rst(rst),
.instruction(instruction),
.db(db)
);

top2 top2(
.clk_in(clk),
.rst(rst),
.dis_datac(dis_data),
.dis_dataf(dis_dataf),
.color(color)
);

scan_led(
.clk1(clk_led),
.dis_data(dis_data),
.dis_dataf(dis_dataf),
.dig(dig),
.seg(seg)
);
endmodule