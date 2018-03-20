`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/22 16:28:43
// Design Name: 
// Module Name: CPU_54
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


module cpu54(
    input clk,
    input rst,
    input [31:0] DMEM_data,
    output [31:0] DMEM_in,
    output [31:0] ALU_out,
    output DM_CS,
    output DM_W
    );
    wire [31:0] PC_out;
    wire [31:0] NPC_out;
    wire IM_R;
    
    wire add;
    wire addu;
    wire sub;
    wire subu;
    wire andc;
    wire orc;
    wire xorc;
    wire norc;
    wire slt;
    wire sltu;
    wire sll;
    wire srl;
    wire sra;
    wire sllv;
    wire srlv;
    wire srav;
    wire jr;
    wire addi;
    wire addiu;
    wire andi;
    wire ori;
    wire xori;
    wire lw;
    wire sw;
    wire beq;
    wire bne;
    wire slti;
    wire sltiu;
    wire lui;
    wire j;
    wire jal;
    wire clz;
    wire divu;
    wire eret;
    wire jalr;
    wire lb;
    wire lbu;
    wire lhu;
    wire sb;
    wire sh;
    wire lh;
    wire mfc0;
    wire mfhi;
    wire mflo;
    wire mtc0;
    wire mthi;
    wire mtlo;
    wire mul;
    wire multu;
    wire syscall;
    wire teq;
    wire bgez;
    wire breakc;
    wire div;
    wire [4:0] raddr1;
    wire [4:0] raddr2;
    wire [4:0] waddr;
    wire [3:0] aluc;
    wire [1:0] m8;
    wire [1:0] m7;
    wire [1:0] m6;
    wire m5;
    wire [1:0] m4;
    wire [1:0] m3;
    wire [2:0] m2;
    wire [1:0] m1;
    wire RF_W;

    wire hi_W;
    wire lo_W;
    wire [31:0] r_m1;
    wire [31:0] r_m2;
    wire [31:0] r_m3;
    wire [31:0] r_m4;
    wire [31:0] r_m5;
    wire [4:0] r_m6;
    wire [31:0] r_m7;
    wire [31:0] r_m8;
    wire [31:0] rdata1;
    wire [31:0] rdata2;
    wire [31:0] Ext5_out;
    wire [31:0] Ext16_out;
    wire [31:0] Ext18_out;
    wire [31:0] instruction;
    wire [31:0] Add_out;
    wire [31:0] mul_out;
    wire [63:0] multu_out;
    wire [63:0] div_out;
    wire [63:0] divu_out;
    wire [31:0] hi_out;
    wire [31:0] lo_out;
    wire [31:0] cz_out;
    wire [31:0] cp0_out;
    wire [31:0] cp0_addr;
    wire [31:0] cp0_status;
    wire [31:0] DMEM_load;
    wire [31:0] DMEM_save;
  

    
    decoder decoder(
                    .rst(rst),
                    .op(instruction[31:26]),
                    .func(instruction[5:0]),
                    .Rsc(instruction[25:21]),
                    .add(add),
                    .addu(addu),
                    .sub(sub),
                    .subu(subu),
                    .andc(andc),
                    .orc(orc),
                    .xorc(xorc),
                    .norc(norc),
                    .slt(slt),
                    .sltu(sltu),
                    .sll(sll),
                    .srl(srl),
                    .sra(sra),
                    .sllv(sllv),
                    .srlv(srlv),
                    .srav(srav),
                    .jr(jr),
                    .addi(addi),
                    .addiu(addiu),
                    .andi(andi),
                    .ori(ori),
                    .xori(xori),
                    .lw(lw),
                    .sw(sw),
                    .beq(beq),
                    .bne(bne),
                    .slti(slti),
                    .sltiu(sltiu),
                    .lui(lui),
                    .j(j),
                    .jal(jal),
                    .clz(clz),
                    .divu(divu),
                    .eret(eret),
                    .jalr(jalr),
                    .lb(lb),
                    .lbu(lbu),
                    .lhu(lhu),
                    .sb(sb),
                    .sh(sh),
                    .lh(lh),
                    .mfc0(mfc0),
                    .mfhi(mfhi),
                    .mflo(mflo),
                    .mtc0(mtc0),
                    .mthi(mthi),
                    .mtlo(mtlo),
                    .mul(mul),
                    .multu(multu),
                    .syscall(syscall),
                    .teq(teq),
                    .bgez(bgez),
                    .breakc(breakc),
                    .div(div)
                    );
    
    iram_ip imem(
                .a(PC_out[31:2]-30'h004000),
                .spo(instruction)
                );
    
      mul_ip mul_inst(
                          .A(rdata1),
                          .B(rdata2),
                          .P(mul_out)
                          );
              
                  multu_ip multu_inst(
                              .A(rdata1),
                              .B(rdata2),
                              .P(multu_out)
                              );
                              
                  div div_inst(
                          .s_axis_divisor_tdata(rdata2),
                          .s_axis_divisor_tvalid(1'b1),
                          .s_axis_dividend_tdata(rdata1),
                          .s_axis_dividend_tvalid(1'b1),
                          .m_axis_dout_tdata(div_out)
                          );
                  
                  divu divu_inst(
                          .s_axis_divisor_tdata(rdata2),
                          .s_axis_divisor_tvalid(1'b1),
                          .s_axis_dividend_tdata(rdata1),
                          .s_axis_dividend_tvalid(1'b1),
                          .m_axis_dout_tdata(divu_out)
                          );
                  
    ctrl ctrl(
            .add(add),
            .addu(addu),
            .sub(sub),
            .subu(subu),
            .andc(andc),
            .orc(orc),
            .xorc(xorc),
            .norc(norc),
            .slt(slt),
            .sltu(sltu),
            .sll(sll),
            .srl(srl),
            .sra(sra),
            .sllv(sllv),
            .srlv(srlv),
            .srav(srav),
            .jr(jr),
            .addi(addi),
            .addiu(addiu),
            .andi(andi),
            .ori(ori),
            .xori(xori),
            .lw(lw),
            .sw(sw),
            .beq(beq),
            .bne(bne),
            .slti(slti),
            .sltiu(sltiu),
            .lui(lui),
            .j(j),
            .jal(jal),
            .clz(clz),
            .divu(divu),
            .eret(eret),
            .jalr(jalr),
            .lb(lb),
            .lbu(lbu),
            .lhu(lhu),
            .sb(sb),
            .sh(sh),
            .lh(lh),
            .mfc0(mfc0),
            .mfhi(mfhi),
            .mflo(mflo),
            .mtc0(mtc0),
            .mthi(mthi),
            .mtlo(mtlo),
            .mul(mul),
            .multu(multu),
            .syscall(syscall),
            .teq(teq),
            .bgez(bgez),
            .breakc(breakc),
            .div(div),
            .zero(zero),
            .negative(negative),
            .Rsc(instruction[25:21]),
            .Rtc(instruction[20:16]),
            .Rdc(instruction[15:11]),
            .IM_R(IM_R),
            .raddr1(raddr1),
            .raddr2(raddr2),
            .waddr(waddr),
            .aluc(aluc),
            .m8(m8),
            .m7(m7),
            .m6(m6),
            .m5(m5),
            .m4(m4),
            .m3(m3),
            .m2(m2),
            .m1(m1),
            .RF_W(RF_W),
            .DM_CS(DM_CS),
            //.DM_R(DM_R),
            .DM_W(DM_W),
            .hi_W(hi_W),
            .lo_W(lo_W)
            );
    
    Regfiles regfiles(
                    .clk(clk), 
                    .rst(rst),
                    .we(RF_W),
                    .raddr1(raddr1),
                    .raddr2(raddr2),
                    .waddr(r_m6),
                    .wdata(r_m2),
                    .rdata1(rdata1),
                    .rdata2(rdata2)
                    );
    
    mux2 mux1(
            .data1({PC_out[31:28],instruction[25:0],2'b00}),
            .data2(r_m5),
            .data3(rdata1),
            .data4(cp0_addr),
            .pos(m1),
            .data(r_m1)
            );
    
    mux3 mux2(
            .data1(DMEM_load),
            .data2(ALU_out),
            .data3(cz_out),
            .data4(mul_out),
            .data5(multu_out),
            .data6(hi_out),
            .data7(lo_out),
            .data8(cp0_out),
            .pos(m2),
            .data(r_m2)
            );
            
    mux2 mux3(
            .data1(Ext5_out),
            .data2(rdata1),
            .data3(PC_out),
            .data4(32'h00000000),
            .pos(m3),
            .data(r_m3)
            );
    
    mux2 mux4(
            .data1(rdata2),
            .data2(Ext16_out),
            .data3(32'h00000004),
            .data4(32'h00000000),
            .pos(m4),
            .data(r_m4)
            );
            
    mux1 mux5(
            .data1(NPC_out),
            .data2(Add_out),
            .pos(m5),
            .data(r_m5)
            );
            
    mux2_5 mux6(
            .data1(waddr),
            .data2(raddr2),
            .data3(5'b11111),
            .data4(5'b00000),
            .pos(m6),
            .data(r_m6)
            );
    
     mux2 mux7(
            .data1(div_out[63:32]),
            .data2(divu_out[63:32]),
            .data3(rdata1),
            .data4(multu_out[31:0]),
            .pos(m7),
            .data(r_m7)
            );
            
    mux2 mux8(
            .data1(div_out[31:0]),
            .data2(divu_out[31:0]),
            .data3(rdata1),
            .data4(multu_out[63:32]),
            .pos(m8),
            .data(r_m8)
            );
    
    alu alu(
            .a(r_m3),
            .b(r_m4),
            .aluc(aluc),
            .r(ALU_out),
            .zero(zero),
            .carry(carry),
            .negative(negative),
            .overflow(overflow)
            );
            
            
    Add Add(
            .a(Ext18_out),
            .b(NPC_out),
            .result(Add_out)
            );
            
    Ext5 Ext5_inst(
            .data(instruction[10:6]),
            .result(Ext5_out)
            );
            
    Ext18 Ext18_inst(
            .data({instruction[15:0],2'b00}),
            .result(Ext18_out)
            );
            
    Ext16 Ext16_inst(
            .data(instruction[15:0]),
            .andi(andi),
            .ori(ori),
            .xori(xori),
            .result(Ext16_out)
            );
    
  
    cz cz(
            .data(rdata1),
            .result(cz_out)
            );
    
    forLoad load_inst(
            .data(DMEM_data),
            .lb(lb),
            .lbu(lbu),
            .lh(lh),
            .lhu(lhu),
            .result(DMEM_load)
            );
            
    forSave save_inst(
            .data(rdata2),
            .sb(sb),
            .sh(sh),
            .result(DMEM_in)
            );
            
    cp0 cp0(
            .clk(clk),
            .rst(rst),
            .mfc0(mfc0),
            .mtc0(mtc0),
            .syscall(syscall),
            .teq(teq),
            .breakc(breakc),
            .pc(PC_out),
            .Rd(instruction[15:11]),
            .wdata(rdata2),
            .eret(eret),
            .zero(zero),
            .rdata(cp0_out),
            .status(cp0_status),
            .cp0_addr(cp0_addr)
            );
            
                pcreg hi(
                    .clk(clk),
                    .rst(rst),
                    .ena(hi_W),
                    .data_in(r_m8),
                    .data_out(hi_out)
                    );
                    
            pcreg lo(
                    .clk(clk),
                    .rst(rst),
                    .ena(lo_W),
                    .data_in(r_m7),
                    .data_out(lo_out)
                    );
                    
            pc pc(
                    .clk(clk),
                    .rst(rst),
                    .ena(1'b1),
                    .data_in(r_m1),
                    .data_out(PC_out)
                    );
                    
            Add npc(
                    .rst(rst),
                    .a(PC_out),
                    .b(32'h00000004),
                    .result(NPC_out)
                    );
endmodule
