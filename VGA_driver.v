`timescale 1ns / 1ps
module VGA_driver(
    input clk,
	input rst,
	input [15:0]dis_data,
	input [11:0]color,
    output reg [11:0] vga_rgb,
    output reg hsync,//行同步
    output reg vsync//场同步
    );
	
parameter h0=24;
parameter h1=24+136;
parameter h2=24+136+1024;
parameter h3=24+136+1024+160;
parameter v0=3;
parameter v1=3+6;
parameter v2=3+6+768;
parameter v3=3+6+768+806;
parameter hd=1024;
parameter vd=768;
parameter X_start=290;
parameter Y_start=30;
parameter X_end=1324;
parameter Y_end=788;
    reg [10:0] x_cnt; 
    reg [9:0] y_cnt;
    reg [11:0]c;
	wire valid;
	wire bw;
    initial
    begin
        x_cnt=0;
        y_cnt=0;
    end
	
	//产生场同步信号
	always @(posedge clk,posedge rst)
		if(rst) hsync=1'b1;
		else if(x_cnt==0) hsync<=1'b0;
		else if(x_cnt==12'd136) hsync<=1'b1;
	
	//产生行同步信号
	always @(posedge clk,posedge rst)
		if(rst) vsync=1'b1;
		else if(y_cnt==0) vsync<=1'b0;
		else if(y_cnt==12'd6) vsync<=1'b1;
		
	//计数器x（行坐标）	
    always@(posedge clk,posedge rst)
        if(rst) x_cnt<=0;
        else if(x_cnt==h3-1) x_cnt<=12'd0;
        else x_cnt<=x_cnt+1'b1;

	//计数器y（列坐标）
    always @ (posedge clk,posedge rst)
    begin
        if(x_cnt == h3-1)
            begin
            if(rst) y_cnt<=0;
            else if(y_cnt==12'd806) y_cnt<=12'd0;
            else if(x_cnt==h3-1) y_cnt<=y_cnt+1'b1;
    end
	end
	
	always @ (posedge clk)
        begin
        case(dis_data[14:7])
        8'd24:c=12'b000000001111;
        8'd26:c=12'b000000001111;
        8'd28:c=12'b000011110000;
        8'd30:c=12'b111100000000;
        8'd32:c=12'b111100000000;
        8'd34:c=12'b111100000000;
        8'd36:c=12'b111100000000;
        endcase
        end
	
	 always @ (posedge clk)
       begin
       if(valid&&((x_cnt-h1)%30==0||(x_cnt-h1)%30==1||(x_cnt-h1)%30==2)&&((y_cnt-v1<=450)&&(y_cnt-v1>=435)))vga_rgb=12'b111111111111;
       else if(valid&&((x_cnt-h1)<=dis_data[14:7]*30+153)&&((x_cnt-h1)>=153)&&(y_cnt-v1<=434)&&(y_cnt-v1>=334))vga_rgb=c;
       else vga_rgb=12'b0;
       end
    assign valid=(x_cnt>X_start&&x_cnt<X_end&&y_cnt>Y_start&&y_cnt<Y_end)?1:0;
endmodule
