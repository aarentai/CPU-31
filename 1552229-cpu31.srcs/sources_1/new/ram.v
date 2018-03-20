`timescale 1ns / 1ps
module ram(
	input clk,
	input ram_ena,
	input wena,
	input [31:0] addr,
	input [31:0] data_in,
	output reg [31:0] data_out
    );
	 
	 reg [31:0] memory[0:4294967295];//2µÄ32´Î·½-1

    always @ (posedge clk)
     begin
         if(ram_ena)
             begin
                 if(wena==1)
                     memory[addr] = data_in;
             end
     end
     
     always@(*)
     begin
         if(ram_ena==1&&wena==0)
             data_out = memory[addr];
         else
             data_out = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
     end
endmodule
