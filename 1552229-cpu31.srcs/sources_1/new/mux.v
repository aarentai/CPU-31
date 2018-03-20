`timescale 1ns / 1ps
module mux(
	input [31:0] a,
	input [31:0] b,
	input [31:0] c,
	input [31:0] d,
	input [1:0] s,
	output [31:0] r
    );
		reg [31:0] data_temp;
		assign r = data_temp;
		always @(a or b or c or d or s) begin
			if(s == 2'b00)
				data_temp = a;
			else if(s == 2'b01)
				data_temp = b;
			else if(s == 2'b10)
				data_temp = c;
			else
				data_temp = d;
		end

endmodule
