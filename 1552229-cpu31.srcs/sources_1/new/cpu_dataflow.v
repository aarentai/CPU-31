`timescale 1ns / 1ps
module cpu_dataflow(
input [31:0] ins,
	input flag,
	output d_ram_ena,
	output d_ram_wena,
	output rf_we,
	output s_ext_s,
	output [3:0] aluc,
	output alu_a_mux,
	output [1:0] alu_b_mux,
	output [1:0] rf_wdata_mux,
	output [4:0] rf_waddr,
	output [1:0] pc_mux
    );
   wire type = ~|ins[31:26];//000000
	wire i_add = type & ins[5] & ~ins[4] & ~ins[3] & ~ins[2] & ~ins[1] & ~ins[0];
	wire i_addu = type & ins[5] & ~ins[4] & ~ins[3] & ~ins[2] & ~ins[1] & ins[0];
	wire i_sub = type & ins[5] & ~ins[4] & ~ins[3] & ~ins[2] & ins[1] & ~ins[0];
	wire i_subu = type & ins[5] & ~ins[4] & ~ins[3] & ~ins[2] & ins[1] & ins[0];
	wire i_and = type & ins[5] & ~ins[4] & ~ins[3] & ins[2] & ~ins[1] & ~ins[0];
	wire i_or = type & ins[5] & ~ins[4] & ~ins[3] & ins[2] & ~ins[1] & ins[0];
	wire i_xor = type & ins[5] & ~ins[4] & ~ins[3] & ins[2] & ins[1] & ~ins[0];
	wire i_nor = type & ins[5] & ~ins[4] & ~ins[3] & ins[2] & ins[1] & ins[0];
	wire i_slt = type & ins[5] & ~ins[4] & ins[3] & ~ins[2] & ins[1] & ~ins[0];
	wire i_sltu = type & ins[5] & ~ins[4] & ins[3] & ~ins[2] & ins[1] & ins[0];
	wire i_sll = type & ~ins[5] & ~ins[4] & ~ins[3] & ~ins[2] & ~ins[1] & ~ins[0];
	wire i_srl = type & ~ins[5] & ~ins[4] & ~ins[3] & ~ins[2] & ins[1] & ~ins[0];
	wire i_sra = type & ~ins[5] & ~ins[4] & ~ins[3] & ~ins[2] & ins[1] & ins[0];
	wire i_sllv = type & ~ins[5] & ~ins[4] & ~ins[3] & ins[2] & ~ins[1] & ~ins[0];
	wire i_srlv = type & ~ins[5] & ~ins[4] & ~ins[3] & ins[2] & ins[1] & ~ins[0];
	wire i_srav = type & ~ins[5] & ~ins[4] & ~ins[3] & ins[2] & ins[1] & ins[0];
	wire i_jr = type & ~ins[5] & ~ins[4] & ins[3] & ~ins[2] & ~ins[1] & ~ins[0];
	wire i_addi = ~ins[31] & ~ins[30] & ins[29] & ~ins[28] & ~ins[27] & ~ins[26];
	wire i_addiu = ~ins[31] & ~ins[30] & ins[29] & ~ins[28] & ~ins[27] & ins[26];
	wire i_andi = ~ins[31] & ~ins[30] & ins[29] & ins[28] & ~ins[27] & ~ins[26];
	wire i_ori = ~ins[31] & ~ins[30] & ins[29] & ins[28] & ~ins[27] & ins[26];
	wire i_xori = ~ins[31] & ~ins[30] & ins[29] & ins[28] & ins[27] & ~ins[26];
	wire i_lw = ins[31] & ~ins[30] & ~ins[29] & ~ins[28] & ins[27] & ins[26];
	wire i_sw = ins[31] & ~ins[30] & ins[29] & ~ins[28] & ins[27] & ins[26];
	wire i_beq = ~ins[31] & ~ins[30] & ~ins[29] & ins[28] & ~ins[27] & ~ins[26];
	wire i_bne = ~ins[31] & ~ins[30] & ~ins[29] & ins[28] & ~ins[27] & ins[26];
	wire i_slti = ~ins[31] & ~ins[30] & ins[29] & ~ins[28] & ins[27] & ~ins[26];
	wire i_sltiu = ~ins[31] & ~ins[30] & ins[29] & ~ins[28] & ins[27] & ins[26];
	wire i_lui = ~ins[31] & ~ins[30] & ins[29] & ins[28] & ins[27] & ins[26];
	wire i_j = ~ins[31] & ~ins[30] & ~ins[29] & ~ins[28] & ins[27] & ~ins[26];
	wire i_jal = ~ins[31] & ~ins[30] & ~ins[29] & ~ins[28] & ins[27] & ins[26];
    wire c0_type  = ~ins[31] &  ins[30] & ~ins[29] & ~ins[28] & ~ins[27] & ~ins[26];
       wire i_mfc0   = c0_type&~ins[25]&~ins[24] &~ins[23]&~ins[22]&~ins[21];
       wire i_mtc0   = c0_type&~ins[25]&~ins[24] & ins[23]&~ins[22]&~ins[21];
       wire i_eret   = c0_type& ins[25]&~ins[24] &~ins[23]&~ins[22]&~ins[21]&~ins[5]& ins[4] & ins[3]&~ins[2] & ~ins[1] & ~ins[0];
       wire i_syscall= type & ~ins[5] & ~ins[4] &  ins[3] & ins[2] & ~ins[1] & ~ins[0];
       wire i_break  = type & ~ins[5] & ~ins[4] &  ins[3] & ins[2] & ~ins[1] &  ins[0];
       wire i_teq    = type &  ins[5] &  ins[4] & ~ins[3] & ins[2] & ~ins[1] & ~ins[0];
       wire i_jalr   = type & ~ins[5] & ~ins[4] &  ins[3] &~ins[2] & ~ins[1] &  ins[0]; 
       wire i_divu     = type & ~ins[5] &  ins[4] &  ins[3] &~ins[2] &  ins[1] &  ins[0];
       wire i_div      = type & ~ins[5] &  ins[4] &  ins[3] &~ins[2] &  ins[1] & ~ins[0];  
       wire i_multu    = type & ~ins[5] &  ins[4] &  ins[3] &~ins[2] & ~ins[1] &  ins[0];
       wire i_mfhi     = type & ~ins[5] &  ins[4] & ~ins[3] &~ins[2] & ~ins[1] & ~ins[0];
       wire i_mflo     = type & ~ins[5] &  ins[4] & ~ins[3] &~ins[2] &  ins[1] & ~ins[0];
       wire i_mthi     = type & ~ins[5] &  ins[4] & ~ins[3] &~ins[2] & ~ins[1] &  ins[0];
       wire i_mtlo     = type & ~ins[5] &  ins[4] & ~ins[3] &~ins[2] &  ins[1] &  ins[0]; 
       wire i_clz      =~ins[31] &  ins[30] &  ins[29] &  ins[28] & ~ins[27] & ~ins[26]&  ins[5] & ~ins[4] & ~ins[3] &~ins[2] & ~ins[1] & ~ins[0];
       wire i_mul      =~ins[31] &  ins[30] &  ins[29] &  ins[28] & ~ins[27] & ~ins[26]& ~ins[5] & ~ins[4] & ~ins[3] &~ins[2] &  ins[1] & ~ins[0];
       wire i_bgez     =~ins[31] & ~ins[30] & ~ins[29] & ~ins[28] & ~ins[27] &  ins[26]&  ~ins[20] & ~ins[19]  & ~ins[18]  &~ins[17]  & ins[16];
       wire i_lb       = ins[31] & ~ins[30] & ~ins[29] & ~ins[28] & ~ins[27] & ~ins[26];
       wire i_lbu      = ins[31] & ~ins[30] & ~ins[29] &  ins[28] & ~ins[27] & ~ins[26];
       wire i_lh       = ins[31] & ~ins[30] & ~ins[29] & ~ins[28] & ~ins[27] &  ins[26];
       wire i_lhu      = ins[31] & ~ins[30] & ~ins[29] &  ins[28] & ~ins[27] &  ins[26];
       wire i_sb       = ins[31] & ~ins[30] &  ins[29] & ~ins[28] & ~ins[27] & ~ins[26];
       wire i_sh       = ins[31] & ~ins[30] &  ins[29] & ~ins[28] & ~ins[27] &  ins[26]; 

   wire [1:0] waddr_mux;
	assign waddr_mux[1] = i_jal;
	assign waddr_mux[0] = i_addi | i_addiu | i_andi | i_ori | i_xori | i_lw | i_slti | i_sltiu | i_lui;
	//²»Ò»Ñù
	assign d_ram_wena = i_sw;
	assign d_ram_ena = i_lw | i_sw;
	assign rf_we = i_add | i_addu | i_sub | i_subu | i_and | i_or | i_xor | i_nor | i_slt | i_sltu | i_sll | i_srl | i_sra | i_sllv | i_srlv | i_srav | i_addi | i_addiu | i_andi | i_ori | i_xori | i_lw | i_slti | i_sltiu | i_lui | i_jal;
	assign s_ext_s = i_sll | i_srl | i_sra | i_addi | i_lw | i_sw | i_beq | i_bne | i_slti | i_sltiu | i_lui | i_addiu;
	assign aluc[3] = i_slt | i_sltu | i_sll | i_srl | i_sra | i_sllv | i_srlv | i_srav | i_slti | i_sltiu | i_lui;
	assign aluc[2] = i_and | i_or | i_xor | i_nor | i_sll | i_srl | i_sra | i_sllv | i_srlv | i_srav | i_andi | i_ori | i_xori;
	assign aluc[1] = i_add | i_sub | i_xor | i_nor | i_slt | i_sltu | i_sll | i_sllv | i_addi | i_xori | i_beq | i_bne | i_slti | i_sltiu;
	assign aluc[0] = i_sub | i_subu | i_or | i_nor | i_slt | i_srl | i_srlv | i_ori | i_beq | i_bne | i_slti;
	assign alu_a_mux = i_sll | i_srl | i_sra;
	assign alu_b_mux[1] = i_beq | i_bne;
	assign alu_b_mux[0] = i_addi | i_addiu| i_andi| i_ori | i_xori |i_lw | i_sw | i_slti | i_sltiu | i_lui   ;
	assign rf_wdata_mux[1] = i_jal;
	assign rf_wdata_mux[0] = i_lw ;
	assign pc_mux[1] = i_jr | i_j | i_jal;
	assign pc_mux[0] = i_jr | (i_beq & flag) | (i_bne & ~flag);
	

	mux1 waddr(ins[15:11],ins[20:16],5'b11111,5'b00000,waddr_mux,rf_waddr);
endmodule

