`timescale 1ns / 1ps
module mux0 (
  input [31:0]a,
  input [31:0]b,
  input s,
  output [31:0]r
    );
  begin
  assign r=s? b:a;
	end

endmodule
