`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/10 18:37:21
// Design Name: 
// Module Name: CP0
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


module cp0(
        input clk,
        input rst, 
        input mfc0,             // CPU instruction is Mfc0
        input mtc0,             // CPU instruction is Mtc0
        input syscall,
        input teq,
        input breakc,
        input [31:0]pc, 
        input [4:0] Rd,         // Specifies Cp0 register
        input [31:0] wdata,     // Data from GP register to replace Cp0 register
        input eret,             // instruction is ERET
        input zero,
        output [31:0] rdata,    // Data from Cp0 register for GP regtister
        output [31:0] status, 
        output reg [31:0]cp0_addr   // Address for PC
    );
    
    reg [31:0] data [0:31];
    integer i;
    reg flag;
    
    
    assign status = data[12];
    assign rdata = mfc0 ? data[Rd] : 32'h00000000;
    
    always@(negedge clk or posedge rst)
    begin
        if(mtc0)
            data[Rd] = wdata;   
            
        if(rst)
        begin
            for(i = 0;i < 32;i = i + 1)
                data[i] = 32'h00000000;
        end
        
        else
        begin
            if(eret & flag)
            begin
                data[12] = data[12] >> 4;
                flag = 0;
                cp0_addr = data[14];
            end
            
            if(~eret)
            begin
                flag = 1;
            end
            
            if(data[12][0])
            begin    
                if(syscall & data[12][1])
                begin
                    data[13][6:2] = 5'b01000;
                    data[14] = pc;
                    data[12] = data[12] << 4;
                    cp0_addr = 32'h00400004;
                end
                else
                begin
                    if(breakc & data[12][2])
                    begin
                        data[13][6:2] = 5'b01001;
                        data[14] = pc;
                        data[12] = data[12] << 4;
                        cp0_addr = 32'h00400004;
                    end
                    else
                    begin
                        if(teq & zero & data[12][3])
                        begin
                            data[13][6:2] = 5'b01101;
                            data[14] = pc;
                            data[12] = data[12] << 4;
                            cp0_addr = 32'h00400004;
                        end
                    end
                end
            end
            
            
        end
    end
endmodule
