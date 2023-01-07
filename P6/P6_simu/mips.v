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
    input clk,
	 input [31:0] i_inst_rdata,
    input [31:0] m_data_rdata,
    output [31:0] i_inst_addr,
    output [31:0] m_data_addr,
    output [31:0] m_data_wdata,
    output [3 :0] m_data_byteen,
    output [31:0] m_inst_addr,
    output w_grf_we,
    output [4:0] w_grf_addr,
    output [31:0] w_grf_wdata,
    output [31:0] w_inst_addr
    );
	 
	 // out from PC
	 wire [31:0] F_PC;
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
	 wire [31:0] D_CMP_O;
	 //out from NPC
	 wire [31:0] NPC;
	 //out from EXT
	 wire [31:0] D_EXT_O;
	 //out from MUXD_RegDst
	 wire [4:0] D_MUXD_RegDst_O;
	 //out from E_REG
	 wire [31:0] E_O1, E_O2, E_PC, E_EXT_O, E_CMP_O;
	 wire [4:0] E_MUXD_RegDst_O;
	 //out from E_MFA1
	 wire [31:0] E_MFA1_O;
	 //out from E_MFA2
	 wire [31:0] E_MFA2_O;
	 //out from MUXALUSrc
	 wire [31:0] E_MUXALUSrc_O;
	 //out from ALU
	 wire [31:0] E_ALU_O;
	 //out from MD
	 wire [31:0] E_LO_O, E_HI_O;
	 wire busy;
	 //out from MUXMDSrc
	 wire [31:0] E_MUXMDSrc_O;
	 //out from MUXE_RegDst
	 wire [4:0] E_MUXE_RegDst_O;
	 //out from M_REG
	 wire [31:0] M_ALU_O, M_O2, M_PC, M_EXT_O, M_MUXMDSrc_O, M_CMP_O;
	 wire [4:0] M_MUXE_RegDst_O;
	 //out from M_MFA2
	 wire [31:0] M_MFA2_O;
	 //out from BE
	 wire [31:0] M_BE_O;
	 wire [3:0] byteen;
	 //out from LE
	 wire [31:0] M_LE_O;
	 //out from MUXM_RegDst
	 wire [4:0] M_MUXM_RegDst_O;
	 //out from W_REG
	 wire [31:0] W_ALU_O, W_DM_O, W_PC, W_EXT_O, W_MUXMDSrc_O, W_CMP_O;
	 wire [4:0] W_MUXM_RegDst_O;
	 //out from MUXWhichToReg
	 wire [31:0] W_WD;
	 //out from CU
	 wire [1:0] D_MFA1Sel, D_MFA2Sel, E_MFA1Sel, E_MFA2Sel;
	 wire [2:0] MUXM_WhichToRegSel, MUXE_WhichToRegSel;
	 wire [3:0] CMPType, EXTType, NPCType, BEType, LEType, MDOp, ALUOp, WhichToReg, D_RegDst, E_RegDst, M_RegDst;
	 wire ALUSrc, MDSrc, Stall, M_MFA2Sel;
	 wire [4:0] D_A1, D_A2, D_A3, E_A1, E_A2, E_A3, M_A1, M_A2, M_A3, E_shamt;
	 
	 PC pc(
		//input
		.NPC(NPC),
		.Stall(Stall),
		.clk(clk),
		.reset(reset),
		//output
		.PC(F_PC)
	 );
	 
	 assign i_inst_addr = F_PC;
	 
	 D_REG d_reg(
		//input
		.clk(clk),
		.reset(reset),
		.F_PC(F_PC),
		.F_instr(i_inst_rdata),
		.Stall(Stall),
		//output
		.D_PC(D_PC),
		.D_instr(D_instr)
	 );
	 
	 
	 MUX_8_32 MUXM_WhichToReg(
		//input
		.in0(M_ALU_O),
		.in1(M_PC + 8),
		.in2(M_EXT_O),
		.in3(M_CMP_O),
		.in4(M_MUXMDSrc_O),
		.sel(MUXM_WhichToRegSel),
		//output
		.out(MUXM_WhichToReg_O)
	 );
	 
	 MUX_8_32 MUXE_WhichToReg(
		//input
		.in0(E_PC + 8),
		.in1(E_EXT_O),
		.in2(E_CMP_O),
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
		.A1(D_instr[25:21]),
		.A2(D_instr[20:16]),
		.A3(W_MUXM_RegDst_O),
		.WD(W_WD),
		//output
		.O1(D_O1),
		.O2(D_O2)
	 );
	 
	 assign w_grf_we = (W_MUXM_RegDst_O != 5'b00000) ? 1 : 0;
	 assign w_grf_addr = W_MUXM_RegDst_O;
	 assign w_grf_wdata = W_WD;
	 assign w_inst_addr = W_PC;
	 
	 CMP cmp(
		//input
		.A1(D_MFA1_O),
		.A2(D_MFA2_O),
		.imm32(D_EXT_O),
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
	 
	 MUXD_RegDst muxd_regdst(
		//input
		.A1(D_A1),
		.A2(D_A2),
		.A3(D_A3),
		.D_RegDst(D_RegDst),
		//output
		.D_MUXD_RegDst_O(D_MUXD_RegDst_O)
	 );
	 
	 E_REG e_reg(
		//input
		.clk(clk),
		.reset(reset),
		.Stall(Stall),
		.D_O1(D_MFA1_O),
		.D_O2(D_MFA2_O),
		.D_PC(D_PC),
		.D_EXT_O(D_EXT_O),
		.D_CMP_O(D_CMP_O),
		.D_A3(D_MUXD_RegDst_O),
		//output
		.E_O1(E_O1),
		.E_O2(E_O2),
		.E_PC(E_PC),
		.E_EXT_O(E_EXT_O),
		.E_CMP_O(E_CMP_O),
		.E_A3(E_MUXD_RegDst_O)
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
		.shamt(E_shamt),
		.ALUOp(ALUOp),
		//output
		.O(E_ALU_O)
	 );
	 
	 MD md(
		//input
		.A1(E_MFA1_O),
		.A2(E_MFA2_O),
		.clk(clk),
		.reset(reset),
		.MDOp(MDOp),
		//output
		.LO(E_LO_O),
		.HI(E_HI_O),
		.busy(busy)
	 );
	 
	 MUX_2_32 MUXMDSrc(
		//input
		.in0(E_LO_O),
		.in1(E_HI_O),
		.sel(MDSrc),
		//output
		.out(E_MUXMDSrc_O)
	 );
	 
	 MUXE_RegDst muxe_regdst(
		//input
		.E_MUXD_RegDst_O(E_MUXD_RegDst_O),
		.A1(E_A1),
		.A2(E_A2),
		.A3(E_A3),
		.E_RegDst(E_RegDst),
		//output
		.E_MUXE_RegDst_O(E_MUXE_RegDst_O)
	 );
	 
	 M_REG m_reg(
		//input
		.clk(clk),
		.reset(reset),
		.E_ALU_O(E_ALU_O),
		.E_O2(E_MFA2_O),
		.E_PC(E_PC),
		.E_EXT_O(E_EXT_O),
		.E_CMP_O(E_CMP_O),
		.E_MUXMDSrc_O(E_MUXMDSrc_O),
		.E_A3(E_MUXE_RegDst_O),
		//output
		.M_ALU_O(M_ALU_O),
		.M_O2(M_O2),
		.M_PC(M_PC),
		.M_EXT_O(M_EXT_O),
		.M_CMP_O(M_CMP_O),
		.M_MUXMDSrc_O(M_MUXMDSrc_O),
		.M_A3(M_MUXE_RegDst_O)
	 );
	 
	 MUX_2_32 M_MFA2(
		//input
		.in0(M_O2),
		.in1(W_WD),
		.sel(M_MFA2Sel),
		//output
		.out(M_MFA2_O)
	 );
	 
	 BE be(
		//input
		.M_ALU_O(M_ALU_O),
		.BEType(BEType),
		.A(M_MFA2_O),
		//output
		.O(M_BE_O),
		.byteen(byteen)
	 );
	 
	 assign m_data_addr = M_ALU_O;
	 assign m_data_wdata = M_BE_O;
	 assign m_data_byteen = byteen;
	 assign m_inst_addr = M_PC;
	 
	 LE le(
		//input
		.A(m_data_rdata),
		.M_ALU_O(M_ALU_O),
		.LEType(LEType),
		//output
		.O(M_LE_O)
	 );
	 
	 MUXM_RegDst muxm_regdst(
		//input
		.M_MUXE_RegDst_O(M_MUXE_RegDst_O),
		.A1(M_A1),
		.A2(M_A2),
		.A3(M_A3),
		.M_LE_O(M_LE_O),
		.M_RegDst(M_RegDst),
		//output
		.M_MUXM_RegDst_O(M_MUXM_RegDst_O)
	 );
	 
	 W_REG w_reg(
		//input
		.clk(clk),
		.reset(reset),
		.M_ALU_O(M_ALU_O),
		.M_DM_O(M_LE_O),
		.M_PC(M_PC),
		.M_EXT_O(M_EXT_O),
		.M_CMP_O(M_CMP_O),
		.M_MUXMDSrc_O(M_MUXMDSrc_O),
		.M_A3(M_MUXM_RegDst_O),
		//output
		.W_ALU_O(W_ALU_O),
		.W_DM_O(W_DM_O),
		.W_PC(W_PC),
		.W_EXT_O(W_EXT_O),
		.W_CMP_O(W_CMP_O),
		.W_MUXMDSrc_O(W_MUXMDSrc_O),
		.W_A3(W_MUXM_RegDst_O)
	 );
	 
	 MUX_16_32 MUXWhichToReg(
		//input
		.in0(W_ALU_O),
		.in1(W_DM_O),
		.in2(W_PC + 8),
		.in3(W_EXT_O),
		.in4({28'h0000000, 3'b000, W_CMP_O}),
		.in5(W_MUXMDSrc_O),
		.sel(WhichToReg),
		//output
		.out(W_WD)
	 );
	
	 CU cu(
		//input
		.clk(clk),
		.reset(reset),
		.instr(D_instr),
		.E_MUXE_RegDst_O(E_MUXE_RegDst_O),
		.M_MUXM_RegDst_O(M_MUXM_RegDst_O),
		.W_MUXM_RegDst_O(W_MUXM_RegDst_O),
		.busy(busy),
		//output
		.NPCType(NPCType),
		.EXTType(EXTType),
		.CMPType(CMPType),
		.BEType(BEType),
		.LEType(LEType),
		.D_RegDst(D_RegDst),
		.E_RegDst(E_RegDst),
		.M_RegDst(M_RegDst),
		.ALUSrc(ALUSrc),
		.MDSrc(MDSrc),
		.ALUOp(ALUOp),
		.MDOp(MDOp),
		.WhichToReg(WhichToReg),
		.Stall(Stall),
		.D_MFA1Sel(D_MFA1Sel),
		.D_MFA2Sel(D_MFA2Sel),
		.E_MFA1Sel(E_MFA1Sel),
		.E_MFA2Sel(E_MFA2Sel),
		.M_MFA2Sel(M_MFA2Sel),
		.MUXE_WhichToRegSel(MUXE_WhichToRegSel),
		.MUXM_WhichToRegSel(MUXM_WhichToRegSel),
		.D_A1(D_A1),
		.D_A2(D_A2),
		.D_A3(D_A3),
		.E_A1(E_A1),
		.E_A2(E_A2),
		.E_A3(E_A3),
		.M_A1(M_A1),
		.M_A2(M_A2),
		.M_A3(M_A3),
		.E_shamt(E_shamt)
	 );
	 
		
endmodule
