`timescale 1ns / 1ps
module mux_5(
   input [4:0] a,
	input [4:0] b,
	input  s,
	output [4:0] r
    );
		reg [4:0] data_temp;
		assign r = data_temp;
		always @(a or b or s) begin
			if(s == 1'b0)
				data_temp = a;
			else
				data_temp = b;
		end

endmodule

