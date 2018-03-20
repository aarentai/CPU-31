`timescale 1ns / 1ps
module cpu_test;
	// Inputs
	reg clk;
	reg reset;
	// Outputs
	wire [15:0] op;
	cpu uut (
		.clk(clk), 
		.reset(reset), 
		.op(op)
	);
integer file_output;
//integer counter =0;

       initial begin
       // Initialize Inputs
     file_output=$fopen("result.txt");
       clk = 0;
       reset = 1;

       #50;
      reset=0; 

   end
  always #100 clk=~clk;
/*always @(posedge clk)
begin
//counter=counter+1;
$fdisplay(file_output,"pc: %h",cpu_test.uut.pcreg.data_out);
$fdisplay(file_output,"instr: %h",cpu_test.uut.ins);
$fdisplay(file_output,"regfile0: %h",cpu_test.uut.rf.register[0]);  
$fdisplay(file_output,"regfile1: %h",cpu_test.uut.rf.register[1]);  
$fdisplay(file_output,"regfile2: %h",cpu_test.uut.rf.register[2]);  
$fdisplay(file_output,"regfile3: %h",cpu_test.uut.rf.register[3]);  
$fdisplay(file_output,"regfile4: %h",cpu_test.uut.rf.register[4]);  
$fdisplay(file_output,"regfile5: %h",cpu_test.uut.rf.register[5]);  
$fdisplay(file_output,"regfile6: %h",cpu_test.uut.rf.register[6]);  
$fdisplay(file_output,"regfile7: %h",cpu_test.uut.rf.register[7]);  
$fdisplay(file_output,"regfile8: %h",cpu_test.uut.rf.register[8]);  
$fdisplay(file_output,"regfile9: %h",cpu_test.uut.rf.register[9]);  
$fdisplay(file_output,"regfile10: %h",cpu_test.uut.rf.register[10]);  
$fdisplay(file_output,"regfile11: %h",cpu_test.uut.rf.register[11]);  
$fdisplay(file_output,"regfile12: %h",cpu_test.uut.rf.register[12]);  
$fdisplay(file_output,"regfile13: %h",cpu_test.uut.rf.register[13]);
$fdisplay(file_output,"regfile14: %h",cpu_test.uut.rf.register[14]);    
$fdisplay(file_output,"regfile15: %h",cpu_test.uut.rf.register[15]);  
$fdisplay(file_output,"regfile16: %h",cpu_test.uut.rf.register[16]);  
$fdisplay(file_output,"regfile17: %h",cpu_test.uut.rf.register[17]);  
$fdisplay(file_output,"regfile18: %h",cpu_test.uut.rf.register[18]);  
$fdisplay(file_output,"regfile19: %h",cpu_test.uut.rf.register[19]);  
$fdisplay(file_output,"regfile20: %h",cpu_test.uut.rf.register[20]);  
$fdisplay(file_output,"regfile21: %h",cpu_test.uut.rf.register[21]);  
$fdisplay(file_output,"regfile22: %h",cpu_test.uut.rf.register[22]);  
$fdisplay(file_output,"regfile23: %h",cpu_test.uut.rf.register[23]);  
$fdisplay(file_output,"regfile24: %h",cpu_test.uut.rf.register[24]);  
$fdisplay(file_output,"regfile25: %h",cpu_test.uut.rf.register[25]);  
$fdisplay(file_output,"regfile26: %h",cpu_test.uut.rf.register[26]);  
$fdisplay(file_output,"regfile27: %h",cpu_test.uut.rf.register[27]);  
$fdisplay(file_output,"regfile28: %h",cpu_test.uut.rf.register[28]);  
$fdisplay(file_output,"regfile29: %h",cpu_test.uut.rf.register[29]);  
$fdisplay(file_output,"regfile30: %h",cpu_test.uut.rf.register[30]);  
$fdisplay(file_output,"regfile31: %h",cpu_test.uut.rf.register[31]);  
$fdisplay(file_output,"dram0: %h",cpu_test.uut.dram.memory[0]);  
$fdisplay(file_output,"dram28: %h",cpu_test.uut.dram.memory[28]);  
end
*/
endmodule

