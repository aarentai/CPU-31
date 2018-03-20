`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/31 20:35:58
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input clk_in,
    input rst,
    output [7:0] o_sel,
    output [7:0] o_seg
    );
    
    wire [31:0] DMEM_in;
    wire [31:0] DMEM_data;
    wire [31:0] ALU_out;
    wire DM_CS;
    wire DM_W;
    
    wire [31:0] DM_test_out;
    wire clk;
    
    clk_ip Clk(
                .clk_in1(clk_in),
                .clk_out1(clk)
                );
    
    cpu54 cpu(
                .clk(clk),
                .rst(rst),
                .DMEM_data(DMEM_data),
                .DMEM_in(DMEM_in),
                .ALU_out(ALU_out),
                .DM_CS(DM_CS),
                .DM_W(DM_W)
                );
                
                
    ram dmem(
                .clk(clk),
                .ena(DM_CS),
                .wena(DM_W),
                .addr(ALU_out),
                .data_in(DMEM_in),
                .data_out(DMEM_data),
                .test_out(DM_test_out)
                );
                
    seg7x16 display(
                    .clk(clk_in),
                    .reset(rst),
                    .cs(1'b1),
                    .i_data(DM_test_out),
                    .o_seg(o_seg),
                    .o_sel(o_sel)
                    );
endmodule
