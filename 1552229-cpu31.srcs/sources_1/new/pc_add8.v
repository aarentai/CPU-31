`timescale 1ns / 1ps
module pc_add8(
input [31:0] data_in,
output [31:0] data_out
    );
assign data_out=data_in+8;
endmodule
