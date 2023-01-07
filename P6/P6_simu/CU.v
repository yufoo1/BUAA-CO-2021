`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:25:44 11/28/2021 
// Design Name: 
// Module Name:    CU 
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
module CU(
    input clk,
	 input reset,
    input [31:0] instr,
	 input busy,
	 input [4:0] E_MUXE_RegDst_O,
	 input [4:0] M_MUXM_RegDst_O,
	 input [4:0] W_MUXM_RegDst_O,
	 output [3:0] NPCType,
	 output [3:0] EXTType,
	 output [3:0] CMPType,
	 output [3:0] BEType,
	 output [3:0] LEType,
	 output [3:0] MDOp,
	 output reg [3:0] D_RegDst,
	 output reg [3:0] E_RegDst,
	 output reg [3:0] M_RegDst,
	 output ALUSrc,
	 output MDSrc,
	 output [3:0] ALUOp,
	 output [3:0] WhichToReg,
	 output reg [2:0] MUXE_WhichToRegSel,
	 output reg [2:0] MUXM_WhichToRegSel,
	 output Stall,
	 output reg [1:0] D_MFA1Sel,
	 output reg [1:0] D_MFA2Sel,
	 output reg [1:0] E_MFA1Sel,
	 output reg [1:0] E_MFA2Sel,
	 output reg M_MFA2Sel,
	 output reg [4:0] D_A1,
	 output reg [4:0] D_A2,
	 output reg [4:0] D_A3,
	 output reg [4:0] E_A1,
	 output reg [4:0] E_A2,
	 output reg [4:0] E_A3,
	 output reg [4:0] M_A1,
	 output reg [4:0] M_A2,
	 output reg [4:0] M_A3,
	 output reg [4:0] E_shamt
    );
	 wire [5:0] op, func;
	 wire [4:0] rs, rt, rd, shamt;
	 wire rtype;
	 wire addu, subu, ori, lw, sw, beq, lui, j, jal, jr;
	 wire add, sub, sll, srl, sra, sllv, srlv, srav, And, Or, Xor, Nor, addi, addiu, andi, xori, slt, slti, sltiu, sltu;
	 wire bne, blez, bgtz, bltz, bgez, jalr;
	 wire lb, lbu, lh, lhu, sb, sh;
	 wire mult, multu, div, divu, mfhi, mflo, mthi, mtlo;
	 reg [3:0] D_NPCType;
	 reg [3:0] D_EXTType;
	 reg [3:0] D_CMPType;
	 reg [3:0] D_BEType, E_BEType, M_BEType;
	 reg [3:0] D_LEType, E_LEType, M_LEType;
	 reg [3:0] D_MDOp, E_MDOp;
	 reg D_ALUSrc, E_ALUSrc;
	 reg D_MDSrc, E_MDSrc;
	 reg [3:0] D_ALUOp, E_ALUOp;
	 reg [3:0] D_WhichToReg, E_WhichToReg, M_WhichToReg, W_WhichToReg;
	 reg [1:0] Tuse_O1, Tuse_O2;
	 reg [1:0] E_Tnew, M_Tnew;
	 reg [3:0] D_StallType, E_StallType, M_StallType;
	 reg Stall_A1_E, Stall_A1_M, Stall_A2_E, Stall_A2_M, Stall_A3_E;
	 reg [4:0] W_A1, W_A2, W_A3;
	 assign op = instr[31:26];
	 assign rs = instr[25:21];
	 assign rt = instr[20:16];
	 assign rd = instr[15:11];
	 assign shamt = instr[10:6];
	 assign func = instr[5:0];
	 assign rtype = (op == 6'b000000) ? 1 : 0;
	 assign addu = (rtype && shamt == 5'b00000 && func == 6'b100001) ? 1 : 0;
	 assign subu = (rtype && shamt == 5'b00000 && func == 6'b100011) ? 1 : 0;
	 assign ori = (op == 6'b001101) ? 1 : 0;
	 assign lw = (op == 6'b100011) ? 1 : 0;
	 assign sw = (op == 6'b101011) ? 1 : 0;
	 assign beq = (op == 6'b000100) ? 1 : 0;
	 assign lui = (op == 6'b001111) ? 1 : 0;
	 assign j = (op == 6'b000010) ? 1 : 0;
	 assign jal = (op == 6'b000011) ? 1 : 0;
	 assign jr = (rtype && rt == 5'b00000 && rd == 5'b00000 && shamt == 5'b00000 && func == 6'b001000) ? 1 : 0;
	 assign add = (rtype && shamt == 5'b00000 && func == 6'b100000) ? 1 : 0;
	 assign addi = (op == 6'b001000) ? 1 : 0;
	 assign addiu = (op == 6'b001001) ? 1 : 0;
	 assign And = (rtype && shamt == 5'b00000 && func == 6'b100100) ? 1 : 0;
	 assign andi = (op == 6'b001100) ? 1 : 0;
	 assign bgez = (op == 6'b000001 && rt == 5'b00001) ? 1 : 0;
	 assign bgtz = (op == 6'b000111 && rt == 5'b00000) ? 1 : 0;
	 assign blez = (op == 6'b000110 && rt == 5'b00000) ? 1 : 0;
	 assign bltz = (op == 6'b000001 && rt == 5'b00000) ? 1 : 0;
	 assign bne = (op == 6'b000101) ? 1 : 0;
	 assign div = (rtype && rd == 5'b00000 && shamt == 5'b00000 && func == 6'b011010) ? 1 : 0;
	 assign divu = (rtype && rd == 5'b00000 && shamt == 5'b00000 && func == 6'b011011) ? 1 : 0;
	 assign jalr = (rtype && rt == 5'b00000 && shamt == 5'b00000 && func == 6'b001001) ? 1 : 0;
	 assign lb = (op == 6'b100000) ? 1 : 0;
	 assign lbu = (op == 6'b100100) ? 1 : 0;
	 assign lh = (op == 6'b100001) ? 1 : 0;
	 assign lhu = (op == 6'b100101) ? 1 : 0;
	 assign mfhi = (rtype && rs == 5'b00000 && rt == 5'b00000 && shamt == 5'b00000 && func == 6'b010000) ? 1 : 0;
	 assign mflo = (rtype && rs == 5'b00000 && rt == 5'b00000 && shamt == 5'b00000 && func == 6'b010010) ? 1 : 0;
	 assign mthi = (rtype && rt == 5'b00000 && rd == 5'b00000 && shamt == 5'b00000 && func == 6'b010001) ? 1 : 0;
	 assign mtlo = (rtype && rt == 5'b00000 && rd == 5'b00000 && shamt == 5'b00000 && func == 6'b010011) ? 1 : 0;
	 assign mult = (rtype && rd == 5'b00000 && shamt == 5'b00000 && func == 6'b011000) ? 1 : 0;
	 assign multu = (rtype && rd == 5'b00000 && shamt == 5'b00000 && func == 6'b011001) ? 1 : 0;
	 assign Nor = (rtype && shamt == 5'b00000 && func == 6'b100111) ? 1 : 0;
	 assign Or = (rtype && shamt == 5'b00000 && func == 6'b100101) ? 1 : 0;
	 assign sb = (op == 6'b101000) ? 1 : 0;
	 assign sh = (op == 6'b101001) ? 1 : 0;
	 assign sll = (rtype && rs == 5'b00000 && func == 6'b000000) ? 1 : 0;
	 assign sllv = (rtype && shamt == 5'b00000 && func == 6'b000100) ? 1 : 0;
	 assign slt = (rtype && shamt == 5'b00000 && func == 6'b101010) ? 1 : 0;
	 assign slti = (op == 6'b001010) ? 1 : 0;
	 assign sltiu = (op == 6'b001011) ? 1 : 0;
	 assign sltu = (rtype && shamt == 5'b00000 && func == 6'b101011) ? 1 : 0;
	 assign sra = (rtype && rs == 5'b00000 && func == 6'b000011) ? 1 : 0;
	 assign srav = (rtype && func == 6'b000111) ? 1 : 0;
	 assign srl = (rtype && rs == 5'b00000 && func == 6'b000010) ? 1 : 0;
	 assign srlv = (rtype && shamt == 5'b00000 && func == 6'b000110) ? 1 : 0;
	 assign sub = (rtype && shamt == 5'b00000 && func == 6'b100010) ? 1 : 0;
	 assign Xor = (rtype && shamt == 5'b00000 && func == 6'b100110) ? 1 : 0;
	 assign xori = (op == 6'b001110) ? 1 : 0;
	 initial begin
		MUXE_WhichToRegSel = 0;
		MUXM_WhichToRegSel = 0;
		D_MFA1Sel = 0;
		D_MFA2Sel = 0;
		E_MFA1Sel = 0;
		E_MFA2Sel = 0;
		M_MFA2Sel = 0;
		D_NPCType = 0;
		D_EXTType = 0;
		D_CMPType = 0;
		D_BEType = 0;
		E_BEType = 0;
		M_BEType = 0;
		D_LEType = 0;
		E_LEType = 0;
		M_LEType = 0;
		D_MDOp = 0;
		E_MDOp = 0;
		D_RegDst = 0;
		D_ALUSrc = 0;
		E_ALUSrc = 0;
		D_MDSrc = 0;
		E_MDSrc = 0;
		D_ALUOp = 0;
		E_ALUOp = 0;
		D_WhichToReg = 0;
		E_WhichToReg = 0;
		M_WhichToReg = 0;
		W_WhichToReg = 0;
		E_Tnew = 0;
		M_Tnew = 0;
		Stall_A1_E = 0;
		Stall_A1_M = 0;
		Stall_A2_E = 0;
		Stall_A2_M = 0;
		Stall_A3_E = 0;
		D_StallType = 0;
		E_StallType = 0;
		M_StallType = 0;
		D_A1 = 0;
		E_A1 = 0;
		M_A1 = 0;
		W_A1 = 0;
		D_A2 = 0;
		E_A2 = 0;
		M_A2 = 0;
		W_A2 = 0;
		D_A3 = 0;
		E_A3 = 0;
		M_A3 = 0;
		W_A3 = 0;
		E_shamt = 0;
	 end
	 // D_NPCType
	 always@(*) begin
		if (beq || bne || blez || bgtz || bltz || bgez) begin
			D_NPCType = 4'b0001;
		end
		else if (j || jal) begin
			D_NPCType = 4'b0010;
		end
		else if (jr || jalr) begin
			D_NPCType = 4'b0011;
		end
		else begin
			D_NPCType = 4'b0000;
		end
	 end
	 // D_EXTType
	 always@(*) begin
		if (lw || sw || beq || addi || addiu || slti || sltiu || bne || blez || bgtz || bltz || bgez || sb || sh || lb || lbu || lh || lhu) begin
			D_EXTType = 4'b0001;
		end
		else if (lui) begin
			D_EXTType = 4'b0010;
		end
		else begin
			D_EXTType = 4'b0000;
		end
	 end
	 // D_CMPType
	 always@(*) begin
		if (beq) begin
			D_CMPType = 4'b0000;
		end
		else if (slt) begin
			D_CMPType = 4'b0001;
		end
		else if (slti) begin
			D_CMPType = 4'b0010;
		end
		else if (sltiu) begin
			D_CMPType = 4'b0011;
		end
		else if (sltu) begin
			D_CMPType = 4'b0100;
		end
		else if (bne) begin
			D_CMPType = 4'b0101;
		end
		else if (blez) begin
			D_CMPType = 4'b0110;
		end
		else if (bgtz) begin
			D_CMPType = 4'b0111;
		end
		else if (bltz) begin
			D_CMPType = 4'b1000;
		end
		else if (bgez) begin
			D_CMPType = 4'b1001;
		end
		else begin
			D_CMPType = 4'b0000;
		end
	 end
	 // D_MDOp
	 always@(*) begin
		if (mult) begin
			D_MDOp = 4'b0001;
		end
		else if (multu) begin
			D_MDOp = 4'b0010;
		end
		else if (div) begin
			D_MDOp = 4'b0011;
		end
		else if (divu) begin
			D_MDOp = 4'b0100;
		end
		else if (mtlo) begin
			D_MDOp = 4'b0101;
		end
		else if (mthi) begin
			D_MDOp = 4'b0110;
		end
		else begin
			D_MDOp = 4'b0000;
		end
	 end
	 // D_BEType
	 always@(*) begin
		if (sw) begin
			D_BEType = 4'b0001;
		end
		else if (sb) begin
			D_BEType = 4'b0010;
		end
		else if (sh) begin
			D_BEType = 4'b0011;
		end
		else begin
			D_BEType = 4'b0000;
		end
	 end
	 // D_LEType
	 always@(*) begin
		if (lw) begin
			D_LEType = 4'b0000;
		end
		else if (lb) begin
			D_LEType = 4'b0001;
		end
		else if (lbu) begin
			D_LEType = 4'b0010;
		end
		else if (lh) begin
			D_LEType = 4'b0011;
		end
		else if (lhu) begin
			D_LEType = 4'b0100;
		end
		else begin
			D_LEType = 4'b0000;
		end
	 end
	 // D_RegDst
	 always@(*) begin
		if (addu || subu || add || sub || sll || srl || sra || sllv || srlv || srav || And || Or || Xor || Nor || slt || sltu || jalr || mflo || mfhi) begin
			D_RegDst = 4'b0011;
		end
		else if (ori || lw || lui || addi || addiu || andi || xori || slti || sltiu || lb || lbu || lh || lhu) begin
			D_RegDst = 4'b0010;
		end
		else if (jal) begin
			D_RegDst = 4'b0001;
		end
		else begin
			D_RegDst = 4'b0000;
		end
	 end
	 // D_ALUSrc
	 always@(*) begin
		if (ori || lw || sw || addi || addiu || andi || xori || slti || sltiu || sb || sh || lb || lbu || lh || lhu) begin
			D_ALUSrc = 1'b1;
		end
		else begin
			D_ALUSrc = 1'b0;
		end
	 end
	 // D_MDSrc
	 always@(*) begin
		if (mfhi) begin
			D_MDSrc <= 1'b1;
		end
		else begin
			D_MDSrc <= 1'b0;
		end
	 end
	 // D_ALUOp
	 always@(*) begin
		if (addu || lw || sw || add || addi || addiu || sb || sh || lb || lbu || lh || lhu) begin
			D_ALUOp = 4'b0000;
		end
		else if (subu || sub) begin
			D_ALUOp = 4'b0001;
		end
		else if (And || andi) begin
			D_ALUOp = 4'b0010;
		end
		else if (ori || Or) begin
			D_ALUOp = 4'b0011;
		end
		else if (sll) begin
			D_ALUOp = 4'b0100;
		end
		else if (srl) begin
			D_ALUOp = 4'b0101;
		end
		else if (sra) begin
			D_ALUOp = 4'b0110;
		end
		else if (sllv) begin
			D_ALUOp = 4'b0111;
		end
		else if (srlv) begin
			D_ALUOp = 4'b1000;
		end
		else if (srav) begin
			D_ALUOp = 4'b1001;
		end
		else if (Xor || xori) begin
			D_ALUOp = 4'b1010;
		end
		else if (Nor) begin
			D_ALUOp = 4'b1011;
		end
		else begin
			D_ALUOp = 4'b0000;
		end
	 end
	 // D_WhichToReg
	 always@(*) begin
		if (addu || subu || ori || add || sub || sll || srl || sra || sllv || srlv || srav || And || Or || Xor || Nor || addi || addiu || andi || xori) begin
			D_WhichToReg = 4'b0000;
		end
		else if (lw || lb || lbu || lh || lhu) begin
			D_WhichToReg = 4'b0001;
		end
		else if (jal || jalr) begin
			D_WhichToReg = 4'b0010;
		end
		else if (lui) begin
			D_WhichToReg = 4'b0011;
		end
		else if (slt || slti || sltiu || sltu) begin
			D_WhichToReg = 4'b0100;
		end
		else if (mflo || mfhi) begin
			D_WhichToReg = 4'b0101;
		end
		else begin
			D_WhichToReg = 4'b0000;
		end
	 end
	 // MUXE_WhichToRegSel
	 always@(*) begin
		if (E_WhichToReg == 4'b0010) begin
			MUXE_WhichToRegSel = 3'b000;
		end
		else if (E_WhichToReg == 4'b0011) begin
			MUXE_WhichToRegSel = 3'b001;
		end
		else if (E_WhichToReg == 4'b0100) begin
			MUXE_WhichToRegSel = 3'b010;
		end
		else begin
			MUXE_WhichToRegSel = 3'b000;
		end
	 end
	 // MUXM_WhichToRegSel
	 always@(*) begin
		if (M_WhichToReg == 4'b0000) begin
			MUXM_WhichToRegSel = 3'b000;
		end
		else if (M_WhichToReg == 4'b0010) begin
			MUXM_WhichToRegSel = 3'b001;
		end
		else if (M_WhichToReg == 4'b0011) begin
			MUXM_WhichToRegSel = 3'b010;
		end
		else if (M_WhichToReg == 4'b0100) begin
			MUXM_WhichToRegSel = 3'b011;
		end
		else if (M_WhichToReg == 4'b0101) begin
			MUXM_WhichToRegSel = 3'b100;
		end
		else begin
			MUXM_WhichToRegSel = 3'b000;
		end
	 end
	 // Tuse_O1
	 always@(*) begin
		if (beq || jr || slt || slti || sltiu || sltu || bne || blez || bgtz || bltz || bgez || jalr) begin
			Tuse_O1 = 2'b00;
		end
		else if (addu || subu || ori || lw || sw || add || sub || sllv || srlv || srav || And || Or || Xor || Nor || addi || addiu || andi || xori || sb || sh || lb || lbu || lh || lhu || mtlo || mthi || mult || multu || div || divu) begin
			Tuse_O1 = 2'b01;
		end
		else begin
			Tuse_O1 = 2'b11;
		end
	 end
	 // Tuse_O2
	 always@(*) begin
		if (beq || slt || sltu || bne) begin
			Tuse_O2 = 2'b00;
		end
		else if (addu || subu || add || sub || sll || srl || sra || sllv || srlv || srav || And || Or || Xor || Nor || mult || multu || div || divu) begin
			Tuse_O2 = 2'b01;
		end
		else if (sw || sb || sh) begin
			Tuse_O2 = 2'b11;
		end
		else begin
			Tuse_O2 = 2'b11;
		end
	 end
	 // E_Tnew
	 always@(posedge clk) begin
		if (reset || Stall) begin
			E_Tnew <= 2'b00;
		end
		else if (lui || jal || slt || slti || sltiu || sltu || jalr) begin
			E_Tnew <= 2'b00;
		end
		else if (addu || subu || ori || add || sub || sll || srl || sra || sllv || srlv || srav || And || Or || Xor || Nor || addi || addiu || andi || xori || mflo || mfhi) begin
			E_Tnew <= 2'b01;
		end
		else if (lw || lb || lbu || lh || lhu) begin
			E_Tnew <= 2'b10;
		end
		else begin
			E_Tnew <= 2'b00;
		end
	 end
	 // M_Tnew
	 always@(posedge clk) begin
		if (reset) begin
			M_Tnew <= 2'b00;
		end
		else begin
			if (E_Tnew > 0) begin
				M_Tnew <= E_Tnew - 1;
			end
			else if (E_Tnew == 1'b0) begin
				M_Tnew <= E_Tnew;
			end
			else begin
				M_Tnew <= 2'b00;
			end
		end
	 end
	 // D_StallType
	 always@(*) begin
		D_StallType = 4'b0000;
	 end
	 // Stall_A1_E
	 always@(*) begin
		if (E_StallType == 4'b0000) begin
			if ((Tuse_O1 <  E_Tnew) && (D_A1 == E_MUXE_RegDst_O) && (D_A1 != 5'b00000)) begin
				Stall_A1_E = 1;
			end
			else begin
				Stall_A1_E = 0;
			end
		end
		else begin
		end
	 end
	 // Stall_A1_M
	 always@(*) begin
		if (M_StallType == 4'b0000) begin
			if ((Tuse_O1 <  M_Tnew) && (D_A1 == M_MUXM_RegDst_O) && (D_A1 != 5'b00000)) begin
				Stall_A1_M = 1;
			end
			else begin
				Stall_A1_M = 0;
			end
		end
		else begin
		end
	 end
	 // Stall_A2_E
	 always@(*) begin
		if (E_StallType == 4'b0000) begin
			if ((Tuse_O2 <  E_Tnew) && (D_A2 == E_MUXE_RegDst_O) && (D_A2 != 5'b00000)) begin
				Stall_A2_E = 1;
			end
			else begin
				Stall_A2_E = 0;
			end
		end
		else begin
		end
	 end
	 // Stall_A2_M
	 always@(*) begin
		if (M_StallType == 4'b0000) begin
			if ((Tuse_O2 <  M_Tnew) && (D_A2 == M_MUXM_RegDst_O) && (D_A2 != 5'b00000)) begin
				Stall_A2_M = 1;
			end
			else begin
				Stall_A2_M = 0;
			end
		end
		else begin
		end
	 end
	 // Stall_A3_E
	 always@(*) begin
		if ((MDOp == 4'b0001 || MDOp == 4'b0010 || MDOp == 4'b0011 || MDOp == 4'b0100 || busy) && (mflo || mfhi || mtlo || mthi)) begin
			Stall_A3_E = 1;
		end
		else begin
			Stall_A3_E = 0;
		end
	 end
	 // Stall
	 assign Stall = (Stall_A1_E || Stall_A1_M || Stall_A2_E || Stall_A2_M || Stall_A3_E) ? 1 : 0;
	 // D_MFA1Sel
	 always@(*) begin
		if ((D_A1 != 5'b00000) && (D_A1 == E_MUXE_RegDst_O) && (E_Tnew == 2'b00)) begin
			D_MFA1Sel = 2'b11;
		end
		else if ((D_A1 != 5'b00000) && (D_A1 == M_MUXM_RegDst_O) && (M_Tnew == 2'b00)) begin
			D_MFA1Sel = 2'b10;
		end
		else if ((D_A1 != 5'b00000) && (D_A1 == W_MUXM_RegDst_O)) begin
			D_MFA1Sel = 2'b01;
		end
		else begin
			D_MFA1Sel = 2'b00;
		end
	 end
	 // D_MFA2Sel
	 always@(*) begin
		if ((D_A2 != 5'b00000) && (D_A2 == E_MUXE_RegDst_O) && (E_Tnew == 2'b00)) begin
			D_MFA2Sel = 2'b11;
		end
		else if ((D_A2 != 5'b00000) && (D_A2 == M_MUXM_RegDst_O) && (M_Tnew == 2'b00)) begin
			D_MFA2Sel = 2'b10;
		end
		else if ((D_A2 != 5'b00000) && (D_A2 == W_MUXM_RegDst_O)) begin
			D_MFA2Sel = 2'b01;
		end
		else begin
			D_MFA2Sel = 2'b00;
		end
	 end
	 // E_MFA1Sel
	 always@(*) begin
		if ((E_A1 != 5'b00000) && (E_A1 == M_MUXM_RegDst_O) && (M_Tnew == 2'b00)) begin
			E_MFA1Sel = 2'b10;
		end
		else if ((E_A1 != 5'b00000) && (E_A1 == W_MUXM_RegDst_O)) begin
			E_MFA1Sel = 2'b01;
		end
		else begin
			E_MFA1Sel = 2'b00;
		end
	 end
	 // E_MFA2Sel
	 always@(*) begin
		if ((E_A2 != 5'b00000) && (E_A2 == M_MUXM_RegDst_O) && (M_Tnew == 2'b00)) begin
			E_MFA2Sel = 2'b10;
		end
		else if ((E_A2 != 5'b00000) && (E_A2 == W_MUXM_RegDst_O)) begin
			E_MFA2Sel = 2'b01;
		end
		else begin
			E_MFA2Sel = 2'b00;
		end
	 end
	 // M_MFA2Sel
	 always@(*) begin
		if ((M_A2 != 5'b00000) && (M_A2 == W_MUXM_RegDst_O)) begin
			M_MFA2Sel = 1'b1;
		end
		else begin
			M_MFA2Sel = 1'b0;
		end
	 end
	 // D_A1 D_A2 D_A3
	 always@(*) begin
		D_A1 = instr[25:21];
		D_A2 = instr[20:16];
		D_A3 = instr[15:11];
	 end
	 
	always@(posedge clk) begin
		if (Stall || reset) begin
			E_BEType <= 4'b0000;
			E_LEType <= 4'b0000;
			E_MDOp <= 4'b0000;
			E_ALUOp <= 4'b0000;
			E_ALUSrc <= 1'b0;
			E_MDSrc <= 1'b0;
			E_RegDst <= 4'b0000;
			E_WhichToReg <= 3'b000;
			E_A1 <= 5'b00000;
			E_A2 <= 5'b00000;
			E_A3 <= 5'b00000;
			E_shamt <= 5'b00000;
			E_StallType <= 4'b0000;
		end
		else begin
			E_BEType <= D_BEType;
			E_LEType <= D_LEType;
			E_MDOp <= D_MDOp;
			E_ALUOp <= D_ALUOp;
			E_ALUSrc <= D_ALUSrc;
			E_MDSrc <= D_MDSrc;
			E_RegDst <= D_RegDst;
			E_WhichToReg <= D_WhichToReg;
			E_A1 <= D_A1;
			E_A2 <= D_A2;
			E_A3 <= D_A3;
			E_shamt <= shamt;
			E_StallType <= D_StallType;
		end
	end
	
	always@(posedge clk) begin
		if (reset) begin
			M_BEType <= 4'b0000;
			M_LEType <= 4'b0000;
			M_RegDst <= 4'b0000;
			M_WhichToReg <= 3'b000;
			W_WhichToReg <= 3'b000;
			M_A1 <= 5'b00000;
			W_A1 <= 5'b00000;
			M_A2 <= 5'b00000;
			W_A2 <= 5'b00000;
			M_A3 <= 5'b00000;
			W_A3 <= 5'b00000;
			M_StallType <= 4'b0000;
		end
		else begin
			M_BEType <= E_BEType;
			M_LEType <= E_LEType;
			M_RegDst <= E_RegDst;
			M_WhichToReg <= E_WhichToReg;
			W_WhichToReg <= M_WhichToReg;
			M_A1 <= E_A1;
			W_A1 <= M_A1;
			M_A2 <= E_A2;
			W_A2 <= M_A2;
			M_A3 <= E_A3;
			W_A3 <= M_A3;
			M_StallType <= E_StallType;
		end
	end
	
	assign NPCType = D_NPCType;
	assign EXTType = D_EXTType;
	assign CMPType = D_CMPType;
	assign MDOp = E_MDOp;
	assign BEType = M_BEType;
	assign LEType = M_LEType;
	assign ALUSrc = E_ALUSrc;
	assign MDSrc = E_MDSrc;
	assign ALUOp = E_ALUOp;
	assign WhichToReg = W_WhichToReg;
endmodule
