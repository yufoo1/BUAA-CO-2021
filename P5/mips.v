`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:39:55 11/29/2021 
// Design Name: 
// Module Name:    mips 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mips(
    input reset,
    input clk
    );
	 
	 // out from IFU
	 wire [31:0] F_PC, F_instr;
	 // out from D_REG
	 wire [31:0] D_PC, D_instr;
	 //out from MUXM_WhichToReg
	 wire [31:0] MUXM_WhichToReg_O;
	 //out from MUXE_WhichToReg
	 wire [31:0] MUXE_WhichToReg_O;
	 //out from D_MFA1
	 wire [31:0] D_MFA1_O;
	 //out from D_MFA2
	 wire [31:0] D_MFA2_O;
	 // out from GRF
	 wire [31:0] D_O1, D_O2;
	 // out from CMP
	 wire D_CMP_O;
	 //out from NPC
	 wire [31:0] NPC;
	 //out from EXT
	 wire [31:0] D_EXT_O;
	 //out from MUXRegDst
	 wire [4:0] D_A3;
	 //out from E_REG
	 wire [31:0] E_O1, E_O2, E_PC, E_EXT_O;
	 wire [4:0] E_A3;
	 //out from E_MFA1
	 wire [31:0] E_MFA1_O;
	 //out from E_MFA2
	 wire [31:0] E_MFA2_O;
	 //out from MUXALUSrc
	 wire [31:0] E_MUXALUSrc_O;
	 //out from ALU
	 wire [31:0] E_ALU_O;
	 //out from M_REG
	 wire [31:0] M_ALU_O, M_O2, M_PC, M_EXT_O;
	 wire [4:0] M_A3;
	 //out from M_MFA2
	 wire [31:0] M_MFA2_O;
	 //out from DM
	 wire [31:0] M_DM_O;
	 //out from W_REG
	 wire [31:0] W_ALU_O, W_DM_O, W_PC, W_EXT_O;
	 wire [4:0] W_A3;
	 //out from MUXWhichToReg
	 wire [31:0] W_WD;
	 //out from CU
	 wire [2:0] NPCType, WhichToReg;
	 wire [1:0] EXTType, RegDst, WidthSel, D_MFA1Sel, D_MFA2Sel, E_MFA1Sel, E_MFA2Sel, MUXM_WhichToRegSel;
	 wire [3:0] CMPType, ALUOp;
	 wire GRFWE, DMWE, ALUSrc, LoadSign, Stall, M_MFA2Sel, MUXE_WhichToRegSel;
	 
	 IFU ifu(
		//input
		.NPC(NPC),
		.Stall(Stall),
		.clk(clk),
		.reset(reset),
		//output
		.PC(F_PC),
		.instr(F_instr)
	 );
	 
	 D_REG d_reg(
		//input
		.clk(clk),
		.reset(reset),
		.F_PC(F_PC),
		.F_instr(F_instr),
		.Stall(Stall),
		//output
		.D_PC(D_PC),
		.D_instr(D_instr)
	 );
	 
	 
	 MUX_4_32 MUXM_WhichToReg(
		//input
		.in0(M_ALU_O),
		.in1(M_PC + 8),
		.in2(M_EXT_O),
		.sel(MUXM_WhichToRegSel),
		//output
		.out(MUXM_WhichToReg_O)
	 );
	 
	 MUX_2_32 MUXE_WhichToReg(
		//input
		.in0(E_PC + 8),
		.in1(E_EXT_O),
		.sel(MUXE_WhichToRegSel),
		//output
		.out(MUXE_WhichToReg_O)
	 );
	 
	 MUX_4_32 D_MFA1(
		//input
		.in0(D_O1),
		.in1(W_WD),
		.in2(MUXM_WhichToReg_O),
		.in3(MUXE_WhichToReg_O),
		.sel(D_MFA1Sel),
		//output
		.out(D_MFA1_O)
	 );
	 
	 MUX_4_32 D_MFA2(
		//input
		.in0(D_O2),
		.in1(W_WD),
		.in2(MUXM_WhichToReg_O),
		.in3(MUXE_WhichToReg_O),
		.sel(D_MFA2Sel),
		//output
		.out(D_MFA2_O)
	 );
	 
	 GRF grf(
		//input
		.clk(clk),
		.reset(reset),
		.PC(W_PC),
		.A1(D_instr[25:21]),
		.A2(D_instr[20:16]),
		.A3(W_A3),
		.WE(GRFWE),
		.WD(W_WD),
		//output
		.O1(D_O1),
		.O2(D_O2)
	 );
	 
	 CMP cmp(
		//input
		.A1(D_MFA1_O),
		.A2(D_MFA2_O),
		.CMPType(CMPType),
		//output
		.O(D_CMP_O)
	 );
	 
	 NPC npc(
		//input
		.NPCType(NPCType),
		.CMPRes(D_CMP_O),
		.imm32(D_EXT_O),
		.instr(D_instr),
		.JrAddr(D_MFA1_O),
		.F_PC(F_PC),
		.D_PC(D_PC),
		//output
		.O(NPC)
	 );
	 
	 EXT ext(
		//input
		.imm16(D_instr[15:0]),
		.EXTType(EXTType),
		//output
		.O(D_EXT_O)
	 );	
	 
	 MUX_4_5 MUXRegDst(
		//input
		.in0(D_instr[15:11]),
		.in1(D_instr[20:16]),
		.in2(5'b11111),
		.sel(RegDst),
		//output
		.out(D_A3)
	 );
	 
	 E_REG e_reg(
		//input
		.clk(clk),
		.reset(reset),
		.Stall(Stall),
		.D_O1(D_O1),
		.D_O2(D_O2),
		.D_PC(D_PC),
		.D_EXT_O(D_EXT_O),
		.D_A3(D_A3),
		//output
		.E_O1(E_O1),
		.E_O2(E_O2),
		.E_PC(E_PC),
		.E_EXT_O(E_EXT_O),
		.E_A3(E_A3)
	 );
	 
	 MUX_4_32 E_MFA1(
		//input
		.in0(E_O1),
		.in1(W_WD),
		.in2(MUXM_WhichToReg_O),
		.sel(E_MFA1Sel),
		//output
		.out(E_MFA1_O)
	 );
	 
	 MUX_4_32 E_MFA2(
		//input
		.in0(E_O2),
		.in1(W_WD),
		.in2(MUXM_WhichToReg_O),
		.sel(E_MFA2Sel),
		//output
		.out(E_MFA2_O)
	 );
	 
	 MUX_2_32 MUXALUSrc(
		//input
		.in0(E_MFA2_O),
		.in1(E_EXT_O),
		.sel(ALUSrc),
		//output
		.out(E_MUXALUSrc_O)
	 );
	 
	 ALU alu(
		//input
		.A1(E_MFA1_O),
		.A2(E_MUXALUSrc_O),
		.ALUOp(ALUOp),
		//output
		.O(E_ALU_O)
	 );
	 
	 M_REG m_reg(
		//input
		.clk(clk),
		.reset(reset),
		.E_ALU_O(E_ALU_O),
		.E_O2(E_MFA2_O),
		.E_PC(E_PC),
		.E_EXT_O(E_EXT_O),
		.E_A3(E_A3),
		//output
		.M_ALU_O(M_ALU_O),
		.M_O2(M_O2),
		.M_PC(M_PC),
		.M_EXT_O(M_EXT_O),
		.M_A3(M_A3)
	 );
	 
	 MUX_2_32 M_MFA2(
		//input
		.in0(M_O2),
		.in1(W_WD),
		.sel(M_MFA2Sel),
		//output
		.out(M_MFA2_O)
	 );
	 
	 DM dm(
	   //input
		.A(M_ALU_O),
		.WD(M_MFA2_O),
		.WE(DMWE),
		.clk(clk),
		.reset(reset),
		.PC(M_PC),
		.WidthSel(WidthSel),
		.LoadSign(LoadSign),
		//output
		.O(M_DM_O)
	 );
	 
	 W_REG w_reg(
		//input
		.clk(clk),
		.reset(reset),
		.M_ALU_O(M_ALU_O),
		.M_DM_O(M_DM_O),
		.M_PC(M_PC),
		.M_EXT_O(M_EXT_O),
		.M_A3(M_A3),
		//output
		.W_ALU_O(W_ALU_O),
		.W_DM_O(W_DM_O),
		.W_PC(W_PC),
		.W_EXT_O(W_EXT_O),
		.W_A3(W_A3)
	 );
	 
	 MUX_8_32 MUXWhichToReg(
		//input
		.in0(W_ALU_O),
		.in1(W_DM_O),
		.in2(W_PC + 8),
		.in3(W_EXT_O),
		.sel(WhichToReg),
		//output
		.out(W_WD)
	 );
	
	 CU cu(
		//input
		.clk(clk),
		.reset(reset),
		.instr(D_instr),
		//output
		.NPCType(NPCType),
		.EXTType(EXTType),
		.CMPType(CMPType),
		.GRFWE(GRFWE),
		.DMWE(DMWE),
		.RegDst(RegDst),
		.ALUSrc(ALUSrc),
		.ALUOp(ALUOp),
		.WidthSel(WidthSel),
		.LoadSign(LoadSign),
		.WhichToReg(WhichToReg),
		.Stall(Stall),
		.D_MFA1Sel(D_MFA1Sel),
		.D_MFA2Sel(D_MFA2Sel),
		.E_MFA1Sel(E_MFA1Sel),
		.E_MFA2Sel(E_MFA2Sel),
		.M_MFA2Sel(M_MFA2Sel),
		.MUXE_WhichToRegSel(MUXE_WhichToRegSel),
		.MUXM_WhichToRegSel(MUXM_WhichToRegSel)
	 );
	 
		
endmodule
