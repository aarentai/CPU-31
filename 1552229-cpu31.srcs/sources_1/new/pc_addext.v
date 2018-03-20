`timescale 1ns / 1ps
module pc_addext(
input [31:0] data_in1,
input [31:0] data_in2,
output [31:0] data_out
    );
reg [31:0] data_temp;
assign data_out=data_temp;
always@(data_in1 or data_in2)
begin
data_temp=data_in1+data_in2;
end

endmodule
