`timescale 1ns / 1ps

module i2c_drive(
			clk,rst_n,
			sw1,sw2,
			scl,sda,
			dis_data,
			vga_rgb,
            hsync,//行同步
            vsync,//场同步
            dig,
            seg
		);

input  clk;		// 100MHz
input  rst_n;	//复位信号，高有效
input  sw1,sw2;	//按键1、2,(1按下执行写入操作，2按下执行读操作)
output scl;		// adt7420的时钟端口
output [11:0] vga_rgb; // 译码结果
output hsync; // 数码管的选择。
output vsync;
inout  sda;		// adt7420的数据端口
output [15:0] dis_data;	//输出指定单元的数据
output [6:0] seg;
output [7:0] dig;
//--------------------------------------------
//按键检测
reg sw1_r,sw2_r;	//键值锁存寄存器，每20ms检测一次键值 
reg[19:0] cnt_20ms;	//20ms计数寄存器

always @ (posedge clk or negedge rst_n)
	if(rst_n) 
	   cnt_20ms <= 20'd0;
	else 
	   cnt_20ms <= cnt_20ms+1'b1;	//不断计数

always @ (posedge clk or negedge rst_n)
	if(rst_n) 
		begin
			sw1_r <= 1'b1;	//键值寄存器复位，没有键盘按下时键值都为1
			sw2_r <= 1'b1;
		end
	else if(cnt_20ms == 20'hfffff) 
		begin
			sw1_r <= sw1;	//按键1值锁存
			sw2_r <= sw2;	//按键2值锁存
		end

//---------------------------------------------
//分频部分
reg[2:0] cnt;	// cnt=0:scl上升沿，cnt=1:scl高电平中间，cnt=2:scl下降沿，cnt=3:scl低电平中间
reg[8:0] cnt_delay;	//500循环计数，产生iic所需要的时钟
reg[31:0] count;
reg clk_led='b0;
reg scl_r;		//时钟脉冲寄存器

always @ (posedge clk or negedge rst_n)
	if(rst_n) 
	   cnt_delay <= 10'd0;
	else if(cnt_delay == 10'd999) 
	   cnt_delay <= 10'd0;	//计数到10us为scl的周期，即100KHz
	else 
	   cnt_delay <= cnt_delay+1'b1;	//时钟计数
	   
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
			9'd124:	cnt <= 3'd1;	//cnt=1:scl高电平中间,用于数据采样
			9'd249:	cnt <= 3'd2;	//cnt=2:scl下降沿
			9'd374:	cnt <= 3'd3;	//cnt=3:scl低电平中间,用于数据变化
			9'd499:	cnt <= 3'd0;	//cnt=0:scl上升沿
			default: cnt <= 3'd5;
		  endcase
	  end
end


`define SCL_POS		(cnt==3'd0)		//cnt=0:scl上升沿
`define SCL_HIG		(cnt==3'd1)		//cnt=1:scl高电平中间,用于数据采样
`define SCL_NEG		(cnt==3'd2)		//cnt=2:scl下降沿
`define SCL_LOW		(cnt==3'd3)		//cnt=3:scl低电平中间,用于数据变化


always @ (posedge clk or negedge rst_n)
	if(rst_n) 
	    scl_r <= 1'b0;
	else if(cnt==3'd0) 
	    scl_r <= 1'b1;	//scl信号上升沿
   	else if(cnt==3'd2) 
        scl_r <= 1'b0;	//scl信号下降沿

assign scl = scl_r;	//产生iic所需要的时钟
//---------------------------------------------

//需要写入adt7420的地址和数据			
`define	DEVICE_READ		8'b1001_0111	//被寻址器件地址（读操作）
`define DEVICE_WRITE	8'b1001_0110	//被寻址器件地址（写操作）

`define	WRITE_DATA      8'b0000_0111	//写入EEPROM的数据
`define BYTE_ADDR       8'b0000_0000	//写入/读出EEPROM的地址寄存器	

reg[7:0] db_r;		//在IIC上传送的数据寄存器
reg[15:0] read_data;	//读出EEPROM的数据寄存器

//---------------------------------------------
		//读、写时序
parameter 	IDLE 	= 4'd0;//空闲
parameter 	START1 	= 4'd1;//启动
parameter 	ADD1 	= 4'd2;//写入adt7420的地址
parameter 	ACK1 	= 4'd3;//adt7420发送ack信号
parameter 	ADD2 	= 4'd4;//写入地址寄存器的地址
parameter 	ACK2 	= 4'd5;//adt7420发送ack信号
parameter 	START2 	= 4'd6;//第二次启动
parameter 	ADD3 	= 4'd7;//写入adt7420的地址
parameter 	ACK3	= 4'd8;//adt7420发送ack信号
parameter 	DATA1 	= 4'd9;//读出温度寄存器中的第一个字节
parameter 	ACK4	= 4'd10;//master发送ack信号
parameter 	DATA2 	= 4'd11;//读出温度寄存器中的第二个字节
parameter 	NACK	= 4'd12;//master不发送ack信号
parameter 	STOP1 	= 4'd13;//停止
parameter 	STOP2 	= 4'd14;
parameter    NOP=4'd15;//空状态
	
reg[3:0] cstate;	//状态寄存器
reg sda_r;		//输出数据寄存器
reg sda_link;	//输出数据sda信号inout方向控制位		
reg[3:0] num;//读写字节时用到的计数器
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
					    begin		//scl为高电平期间
						  sda_link <= instruction[13];	//数据线sda为output
						  sda_r <= instruction[12];		//拉低数据线sda，产生起始位信号
						  cstate <= instruction[11:8];
						  num <= 4'd0;		//num计数清零
						end
					else 
					    cstate <= instruction[7:4]; //等待scl高电平中间位置到来
				end
			ADD1:	
				begin
					if(`SCL_LOW) 
						begin
							if(num == 4'd8) 
								begin	
									num <= 4'd0;			//num计数清零
									sda_r <= instruction[12];
									sda_link <= instruction[13];		//sda置为高阻态(input)
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
						begin	//注：24C01/02/04/08/16器件可以不考虑应答位
							cstate <= instruction[11:8];	//从机响应信号
							db_r <= instruction[21:14];	// 1地址		
						end
					else 
					   cstate <= instruction[7:4];		//等待从机响应
				end
			ADD2:	
				begin
					if(`SCL_LOW) 
						begin
							if(num==4'd8) 
								begin	
									num <= 4'd0;			//num计数清零
									sda_r <= instruction[12];
									sda_link <= instruction[13];		//sda置为高阻态(input)
									cstate <= instruction[11:8];
								end
							else 
								begin
									sda_link <= 1'b1;		//sda作为output
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
					if(/*!sda*/`SCL_NEG) begin		//从机响应信号
						if(!sw1_r) begin
								cstate <= instruction[11:8]; 	//写操作
								db_r <= instruction[21:14];	//写入的数据							
							end	
						else if(!sw2_r) begin
								db_r <= `DEVICE_READ;	//送器件地址（读操作），特定地址读需要执行该步骤以下操作
								cstate <= instruction[7:4];		//读操作
							end
						end
					else cstate <= instruction[3:0];	//等待从机响应
				end
			START2: begin	//读操作起始位
					if(`SCL_LOW) begin
						sda_link <= instruction[13];	//sda作为output
						sda_r <= instruction[12];		//拉高数据线sda
						cstate <= instruction[11:8];
						end
					else if(`SCL_HIG) begin	//scl为高电平中间
						sda_r <= instruction[12];		//拉低数据线sda，产生起始位信号
						cstate <= instruction[7:4];
						end	 
					else cstate <= instruction[3:0];
				end
			ADD3:	begin	//送读操作地址
					if(`SCL_LOW) begin
							if(num==4'd8) begin	
									num <= 4'd0;			//num计数清零
									sda_r <= instruction[12];
									sda_link <= instruction[13];		//sda置为高阻态(input)
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
							cstate <= instruction[11:8];	//从机响应信号
							sda_link <= instruction[13];
						end
					else cstate <= instruction[7:4]; 		//等待从机响应
				end
			DATA1:	begin
					if(!sw2_r) begin	 //读操作
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
								num <= 4'd0;			//num计数清零
								cstate <= instruction[7:4];
								end
							else cstate <= instruction[3:0];
						end
				end
			ACK4: begin//scl为高电平时，sda也为低电平，则代表master发送的ack
					if(/*!sda*/`SCL_HIG)
					 begin
					sda_link <= instruction[13];
						sda_r <= instruction[12];
						cstate <= instruction[11:8];						
						end
					else cstate <= instruction[7:4];
				end
		DATA2:	begin
                        if(!sw2_r) begin     //读操作
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
                                    num <= 4'd0;            //num计数清零
                                    cstate <= instruction[7:4];
                                    end
                                else cstate <= instruction[3:0];
                            end
                    end
                NACK: begin
                        if(/*!sda*/`SCL_HIG) begin//scl为高电平时，sda也为高电平，则代表nack
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
							sda_r <= instruction[12];	//scl为高时，sda产生上升沿（结束信号）
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
    .hsync(hsync),//行同步
    .vsync(vsync)//场同步
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