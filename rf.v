`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/11/23 19:25:21
// Design Name: 
// Module Name: Regfiles
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


module Regfiles(
    input clk,
    input rst,
    input we,
    input [4:0] raddr1,
    input [4:0] raddr2,
    input [4:0] waddr,
    input [31:0] wdata,
    output [31:0] rdata1,
    output [31:0] rdata2,
    output [15:0] test_out
    );
    wire [31:0] wpos;
    wire [31:0] data [31:0];
    
    assign test_out = data[28][15:0];
    
    addDecoder addr1(
                .addr_in(waddr),
                .we(we),
                .addr_out(wpos)
                );
    generate
    genvar i;
        for(i = 0;i < 32;i = i + 1)            
        begin:inst
        pcreg inst(
                .clk(clk),
                .rst(rst),
                .ena(wpos[i]),
                .data_in(i==0?32'h00000000:wdata),
                .data_out(data[i])
                );
        end        
    endgenerate
    
    selector slc_inst1(
                    data[0],
                    data[1],
                    data[2],
                    data[3],
                    data[4],
                    data[5],
                    data[6],
                    data[7],
                    data[8],
                    data[9],
                    data[10],
                    data[11],
                    data[12],
                    data[13],
                    data[14],
                    data[15],
                    data[16],
                    data[17],
                    data[18],
                    data[19],
                    data[20],
                    data[21],
                    data[22],
                    data[23],
                    data[24],
                    data[25],
                    data[26],
                    data[27],
                    data[28],
                    data[29],
                    data[30],
                    data[31],
                    raddr1,
                    1'b1,
                    rdata1
                    );
      selector slc_inst2(
                    data[0],
                    data[1],
                    data[2],
                    data[3],
                    data[4],
                    data[5],
                    data[6],
                    data[7],
                    data[8],
                    data[9],
                    data[10],
                    data[11],
                    data[12],
                    data[13],
                    data[14],
                    data[15],
                    data[16],
                    data[17],
                    data[18],
                    data[19],
                    data[20],
                    data[21],
                    data[22],
                    data[23],
                    data[24],
                    data[25],
                    data[26],
                    data[27],
                    data[28],
                    data[29],
                    data[30],
                    data[31],
                    raddr2,
                    1'b1,
                    rdata2
                    );              
    
endmodule
