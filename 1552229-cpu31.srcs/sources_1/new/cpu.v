`timescale 1ns / 1ps
module cpu(
input clk,
input reset,
output [15:0] op
    );
    wire [31:0]ins;
    wire [31:0] alu_a;
    wire [31:0] alu_b;
       wire [1:0] pc_mux;
       wire [3:0] aluc;
       wire alu_a_mux;
       wire [1:0] alu_b_mux;
       wire [1:0] rf_wdata_mux;
       wire s_ext_s;
       wire rf_we;
       wire d_ram_ena;
       wire d_ram_wena;
       wire i_ram_wena = 0;
       wire i_ram_ena = 1;
       wire pcreg_ena = 1;
       wire [4:0] rf_raddr1 = ins[25:21];
       wire [4:0] rf_raddr2 = ins[20:16];
       wire [4:0] rf_waddr;
       
       wire [31:0] pc_mux_0;
       wire [31:0] pc_mux_1;
       wire [31:0] pc_mux_2;
       wire [31:0] pc_data_in;
       wire [31:0] pc_data_out;
       wire [31:0] rf_mux_1;
       wire [31:0] rf_mux_2;
       wire [31:0] wdata;
       wire [31:0] alu_a_1;
       wire [31:0] alu_b_1;

       wire [31:0] alu_output;
       wire zero;
       wire carry;
       wire negative;
       wire overflow ;
       wire [31:0] empty;
       wire [31:0] i_ram_dataout;
       wire [31:0] d_ram_rdata1;
       wire [31:0] d_ram_rdata2;
       wire [31:0] ext_18_out;
       wire [4:0] rf_waddr_temp;
       wire flag;
      wire [15:0] reg28;
	 assign empty=0;
	 integer file_output;
     integer counter =0;

    pcreg hi(
    .clk(clk),
    .rst(rst),
    .ena(),
    .wdata(),
    .data_out()
    );
    
    pcreg lo(
    .clk(clk),
    .rst(rst),
    .ena(),
    .wdata(),
    .data_out()
    );
	 ipcore iram(
	 pc_data_out[11:2],
	 i_ram_dataout);
	 
	 cpu_dataflow cpu0(
	 ins,
	 flag,
	 d_ram_ena,
	 d_ram_wena,
	 rf_we,
	 s_ext_s,
	 aluc,
	 alu_a_mux,
	 alu_b_mux,
	 rf_wdata_mux,
	 rf_waddr_temp,
	 pc_mux
	 );
	 
    alu alu(
    alu_a,
    alu_b,
    aluc,
    alu_output,
    zero,
    carry,
    negative,
    overflow);
    
	 mux_5 overflow_mux(
	 rf_waddr_temp,
	 5'b00000,
	 overflow,
	 rf_waddr);
	 
	 ext_16 ext_16(
	 ins[15:0],
	 s_ext_s,
	 alu_b_1);
	 
	 ext_5 ext_5(
	 ins[10:6],
	 s_ext_s,
	 alu_a_1);
	 ext_18 ext_18(
	 {ins[15:0],2'b00},
	 s_ext_s,
	 ext_18_out);
	 
	 pcreg pcreg(
	 clk,
	 reset,
	 pcreg_ena,
	 pc_data_in,
	 pc_data_out
	 );
	 //仿真用
	 //ram dram(clk,d_ram_ena,d_ram_wena,alu_output,d_ram_rdata2,rf_mux_1); //仿真用
	 //iram_ip2 iram(pc_data_out[31:2],i_ram_dataout);//下板用
	 ram dram(
	 clk,
	 d_ram_ena,
	 d_ram_wena,
	 alu_output,
	 d_ram_rdata2,
	 rf_mux_1);//下板用                    z!!!!!!!!!!
	 
	 regfile rf(
	 clk,
	 reset,
	 rf_we,
	 rf_raddr1,
	 rf_raddr2,
	 rf_waddr,
	 wdata,
	 d_ram_rdata1,
	 d_ram_rdata2,
	 flag,
	 reg28);

     mux pcmux(
	 pc_mux_0,
	 pc_mux_1,
	 pc_mux_2,
	 d_ram_rdata1,
	 pc_mux,
	 pc_data_in);
	 
	 mux0 aluamux(
	 d_ram_rdata1,
	 alu_a_1,
	 alu_a_mux,
	 alu_a);
	 
	 mux alubmux(
	 d_ram_rdata2,
	 alu_b_1,
	 ext_18_out,
	 empty,
	 alu_b_mux,
	 alu_b);
	 
	 mux rfwdatamux(
	 alu_output,
	 rf_mux_1,
	 rf_mux_2,
	 empty,
	 rf_wdata_mux,
	 wdata);
	 
	 pc_add8 pc_add8(
	 pc_data_out,
	 rf_mux_2);
	 
	 pc_add4 pc_add4(
	 pc_data_out,
	 pc_mux_0);
	 
	 pc_ext3 pc_ext3(
	 pc_data_out,
	 i_ram_dataout,
	 pc_mux_2);
	 
	 pc_addext pc_addext(
	 pc_data_out,
	 ext_18_out,
	 pc_mux_1);
	 
	 assign ins = i_ram_dataout;
	 assign pc = pc_data_out;
	 assign op= reg28;
endmodule
