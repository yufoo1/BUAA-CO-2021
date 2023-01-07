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
	 output [2:0] NPCType,
	 output [1:0] EXTType,
	 output [3:0] CMPType,
	 output GRFWE,
	 output DMWE,
	 output [1:0] RegDst,
	 output ALUSrc,
	 output [3:0] ALUOp,
	 output [1:0] WidthSel,
	 output LoadSign,
	 output [2:0] WhichToReg,
	 output reg MUXE_WhichToRegSel,
	 output reg [1:0] MUXM_WhichToRegSel,
	 output Stall,
	 output reg [1:0] D_MFA1Sel,
	 output reg [1:0] D_MFA2Sel,
	 output reg [1:0] E_MFA1Sel,
	 output reg [1:0] E_MFA2Sel,
	 output reg M_MFA2Sel
    );
	 wire [5:0] op, func;
	 wire [4:0] rs, rt, rd, shamt;
	 wire rtype;
	 wire addu, subu, ori, lw, sw, beq, lui, j, jal, jr, nop;
	 reg [2:0] D_NPCType;
	 reg [1:0] D_EXTType;
	 reg [3:0] D_CMPType;
	 reg D_GRFWE, E_GRFWE, M_GRFWE, W_GRFWE;
	 reg D_DMWE, E_DMWE, M_DMWE;
	 reg [1:0] D_RegDst;
	 reg D_ALUSrc, E_ALUSrc;
	 reg [3:0] D_ALUOp, E_ALUOp;
	 reg [1:0] D_WidthSel, E_WidthSel, M_WidthSel;
	 reg D_LoadSign, E_LoadSign, M_LoadSign;
	 reg [2:0] D_WhichToReg, E_WhichToReg, M_WhichToReg, W_WhichToReg;
	 wire Tuse_A1_0, Tuse_A1_1, Tuse_A2_0, Tuse_A2_1, Tuse_A2_2;
	 wire D_Type, E_Type, M_Type;
	 reg [1:0] E_Tnew, M_Tnew;
	 reg [4:0] D_A1, E_A1, M_A1, W_A1;
	 reg [4:0] D_A2, E_A2, M_A2, W_A2;
	 reg [4:0] D_A3, E_A3, M_A3, W_A3; 
	 wire Stall_A1_0_E1, Stall_A1_0_E2, Stall_A1_0_M1, Stall_A1_1_E2;
	 wire Stall_A2_0_E1, Stall_A2_0_E2, Stall_A2_0_M1, Stall_A2_1_E2;
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
	 assign nop = (rtype && func == 6'b000000) ? 1 : 0;
	 assign Tuse_A1_0 = (beq || jr) ? 1 : 0;
	 assign Tuse_A1_1 = (addu || subu || ori || lw || sw) ? 1 : 0;
	 assign Tuse_A2_0 = (beq) ? 1 : 0;
	 assign Tuse_A2_1 = (addu || subu) ? 1 : 0;
	 assign Tuse_A2_2 = (sw) ? 1 : 0;
	 assign D_Type = (lui || jr) ? 1 : 0;
	 assign E_Type = (addu || subu || ori) ? 1 : 0;
	 assign M_Type = (lw) ? 1 : 0;
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
		D_GRFWE = 0;
		E_GRFWE = 0;
		M_GRFWE = 0;
		W_GRFWE = 0;
		D_DMWE = 0;
		E_DMWE = 0;
		M_DMWE = 0;
		D_RegDst = 0;
		D_ALUSrc = 0;
		E_ALUSrc = 0;
		D_ALUOp = 0;
		E_ALUOp = 0;
		D_WidthSel = 0;
		E_WidthSel = 0;
		M_WidthSel = 0;
		D_LoadSign = 0;
		E_LoadSign = 0;
		M_LoadSign = 0;
		D_WhichToReg = 0;
		E_WhichToReg = 0;
		M_WhichToReg = 0;
		W_WhichToReg = 0;
		E_Tnew = 0;
		M_Tnew = 0;
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
	 end
	 // D_NPCType
	 always@(*) begin
		if (beq) begin
			D_NPCType = 4'b0001;
		end
		else if (j || jal) begin
			D_NPCType = 4'b0010;
		end
		else if (jr) begin
			D_NPCType = 4'b0011;
		end
		else begin
			D_NPCType = 4'b0000;
		end
	 end
	 // D_EXTType
	 always@(*) begin
		if (lw || sw || beq) begin
			D_EXTType = 2'b01;
		end
		else if (lui) begin
			D_EXTType = 2'b10;
		end
		else begin
			D_EXTType = 2'b00;
		end
	 end
	 // D_CMPType
	 always@(*) begin
		if (beq) begin
			D_CMPType = 4'b0000;
		end
		else begin
			D_CMPType = 4'b0000;
		end
	 end
	 // D_GRFWE
	 always@(*) begin
		if (addu || subu || ori || lw || lui || jal) begin
			D_GRFWE = 1'b1;
		end
		else begin
			D_GRFWE = 1'b0;
		end
	 end
	 // D_DMWE
	 always@(*) begin
		if (sw) begin
			D_DMWE = 1'b1;
		end
		else begin
			D_DMWE = 1'b0;
		end
	 end
	 // D_RegDst
	 always@(*) begin
		if (ori || lw || lui) begin
			D_RegDst = 2'b01;
		end
		else if (jal) begin
			D_RegDst = 2'b10;
		end
		else begin
			D_RegDst = 2'b00;
		end
	 end
	 // D_ALUSrc
	 always@(*) begin
		if (ori || lw || sw) begin
			D_ALUSrc = 1'b1;
		end
		else begin
			D_ALUSrc = 1'b0;
		end
	 end
	 // D_ALUOp
	 always@(*) begin
		if (addu || lw || sw) begin
			D_ALUOp = 4'b0000;
		end
		else if (subu) begin
			D_ALUOp = 4'b0001;
		end
		else if (ori) begin
			D_ALUOp = 4'b0011;
		end
	 end
	 // D_WidthSel
	 always@(*) begin
		if (lw || sw) begin
			D_WidthSel = 2'b00;
		end
		else begin
			D_WidthSel = 2'b00;
		end
	 end
	 // D_LoadSign
	 always@(*) begin
		if (lw || sw) begin
			D_LoadSign = 1'b0;
		end
		else begin
			D_LoadSign = 1'b0;
		end
	 end
	 // D_WhichToReg
	 always@(*) begin
		if (addu || subu || ori) begin
			D_WhichToReg = 3'b000;
		end
		else if (lw) begin
			D_WhichToReg = 3'b001;
		end
		else if (jal) begin
			D_WhichToReg = 3'b010;
		end
		else if (lui) begin
			D_WhichToReg = 3'b011;
		end
		else begin
			D_WhichToReg = 3'b000;
		end
	 end
	 // MUXE_WhichToRegSel
	 always@(*) begin
		if (E_WhichToReg == 3'b010) begin
			MUXE_WhichToRegSel = 1'b0;
		end
		else if (E_WhichToReg == 3'b011) begin
			MUXE_WhichToRegSel = 1'b1;
		end
		else begin
			MUXE_WhichToRegSel = 2'b00;
		end
	 end
	 // MUXM_WhichToRegSel
	 always@(*) begin
		if (M_WhichToReg == 3'b000) begin
			MUXM_WhichToRegSel = 2'b00;
		end
		else if (M_WhichToReg == 3'b010) begin
			MUXM_WhichToRegSel = 2'b01;
		end
		else if (M_WhichToReg == 3'b011) begin
			MUXM_WhichToRegSel = 2'b10;
		end
		else begin
			MUXM_WhichToRegSel = 2'b00;
		end
	 end
	 // E_Tnew
	 always@(posedge clk) begin
		if (reset || Stall) begin
			E_Tnew <= 2'b00;
		end
		else if (D_Type) begin
			E_Tnew <= 2'b00;
		end
		else if (E_Type) begin
			E_Tnew <= 2'b01;
		end
		else if (M_Type) begin
			E_Tnew <= 2'b10;
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
			else begin
				M_Tnew <= E_Tnew;
			end
		end
	 end
	 // Stall
	 assign Stall_A1_0_E1 = (Tuse_A1_0 && (E_Tnew == 2'b01) && (D_A1 == E_A3) && E_GRFWE && (D_A1 != 5'b00000)) ? 1 : 0;
	 assign Stall_A1_0_E2 = (Tuse_A1_0 && (E_Tnew == 2'b10) && (D_A1 == E_A3) && E_GRFWE && (D_A1 != 5'b00000)) ? 1 : 0;
	 assign Stall_A1_0_M1 = (Tuse_A1_0 && (M_Tnew == 2'b01) && (D_A1 == M_A3) && M_GRFWE && (D_A1 != 5'b00000)) ? 1 : 0;
	 assign Stall_A1_1_E2 = (Tuse_A1_1 && (E_Tnew == 2'b10) && (D_A1 == E_A3) && E_GRFWE && (D_A1 != 5'b00000)) ? 1 : 0;
	 assign Stall_A2_0_E1 = (Tuse_A2_0 && (E_Tnew == 2'b01) && (D_A2 == E_A3) && E_GRFWE && (D_A2 != 5'b00000)) ? 1 : 0;
	 assign Stall_A2_0_E2 = (Tuse_A2_0 && (E_Tnew == 2'b10) && (D_A2 == E_A3) && E_GRFWE && (D_A2 != 5'b00000)) ? 1 : 0;
	 assign Stall_A2_0_M1 = (Tuse_A2_0 && (M_Tnew == 2'b01) && (D_A2 == M_A3) && M_GRFWE && (D_A2 != 5'b00000)) ? 1 : 0;
	 assign Stall_A2_1_E2 = (Tuse_A2_1 && (E_Tnew == 2'b10) && (D_A2 == E_A3) && E_GRFWE && (D_A2 != 5'b00000)) ? 1 : 0;
	 assign Stall = (Stall_A1_0_E1 || Stall_A1_0_E2 || Stall_A1_0_M1 || Stall_A1_1_E2 || Stall_A2_0_E1 || Stall_A2_0_E2 || Stall_A2_0_M1 || Stall_A2_1_E2) ? 1 : 0;
	 // D_MFA1Sel
	 always@(*) begin
		if ((D_A1 != 5'b00000) && (D_A1 == E_A3) && (E_Tnew == 2'b00) && E_GRFWE) begin
			D_MFA1Sel = 2'b11;
		end
		else if ((D_A1 != 5'b00000) && (D_A1 == M_A3) && (M_Tnew == 2'b00) && M_GRFWE) begin
			D_MFA1Sel = 2'b10;
		end
		else if ((D_A1 != 5'b00000) && (D_A1 == W_A3) && W_GRFWE) begin
			D_MFA1Sel = 2'b01;
		end
		else begin
			D_MFA1Sel = 2'b00;
		end
	 end
	 // D_MFA2Sel
	 always@(*) begin
		if ((D_A2 != 5'b00000) && (D_A2 == E_A3) && (E_Tnew == 2'b00) && E_GRFWE) begin
			D_MFA2Sel = 2'b11;
		end
		else if ((D_A2 != 5'b00000) && (D_A2 == M_A3) && (M_Tnew == 2'b00) && M_GRFWE) begin
			D_MFA2Sel = 2'b10;
		end
		else if ((D_A2 != 5'b00000) && (D_A2 == M_A3) && W_GRFWE) begin
			D_MFA2Sel = 2'b01;
		end
		else begin
			D_MFA2Sel = 2'b00;
		end
	 end
	 // E_MFA1Sel
	 always@(*) begin
		if ((E_A1 != 5'b00000) && (E_A1 == M_A3) && (M_Tnew == 2'b00) && M_GRFWE) begin
			E_MFA1Sel = 2'b10;
		end
		else if ((E_A1 != 5'b00000) && (E_A1 == W_A3) && W_GRFWE) begin
			E_MFA1Sel = 2'b01;
		end
		else begin
			E_MFA1Sel = 2'b00;
		end
	 end
	 // E_MFA2Sel
	 always@(*) begin
		if ((E_A2 != 5'b00000) && (E_A2 == M_A3) && (M_Tnew == 2'b00) && M_GRFWE) begin
			E_MFA2Sel = 2'b10;
		end
		else if ((E_A2 != 5'b00000) && (E_A2 == W_A3) && W_GRFWE) begin
			E_MFA2Sel = 2'b01;
		end
		else begin
			E_MFA2Sel = 2'b00;
		end
	 end
	 // M_MFA2Sel
	 always@(*) begin
		if ((M_A2 != 5'b00000) && (M_A2 == W_A3) && W_GRFWE) begin
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
		if (D_RegDst == 2'b01) begin
			D_A3 = instr[20:16];
		end
		else if (D_RegDst == 2'b10) begin
			D_A3 = 5'b11111;
		end
		else begin
			D_A3 = instr[15:11];
		end
		
	 end
	 
	always@(posedge clk) begin
		if (Stall || reset) begin
			E_GRFWE <= 1'b0;
			E_DMWE <= 1'b0;
			E_ALUOp <= 4'b0000;
			E_WidthSel <= 2'b00;
			E_LoadSign <= 1'b0;
			E_WhichToReg <= 3'b000;
			E_A1 <= 5'b00000;
			E_A2 <= 5'b00000;
			E_A3 <= 5'b00000;
		end
		else begin
			E_GRFWE <= D_GRFWE;
			E_DMWE <= D_DMWE;
			E_ALUOp <= D_ALUOp;
			E_ALUSrc <= D_ALUSrc;
			E_WidthSel <= D_WidthSel;
			E_LoadSign <= D_LoadSign;
			E_WhichToReg <= D_WhichToReg;
			E_A1 <= D_A1;
			E_A2 <= D_A2;
			E_A3 <= D_A3;
		end
	end
	
	always@(posedge clk) begin
		if (reset) begin
			M_GRFWE <= 1'b0;
			W_GRFWE <= 1'b0;
			M_DMWE <= 1'b0;
			M_WidthSel <= 2'b00;
			M_LoadSign <= 1'b0;
			M_WhichToReg <= 3'b000;
			W_WhichToReg <= 3'b000;
			M_A1 <= 5'b00000;
			W_A1 <= 5'b00000;
			M_A2 <= 5'b00000;
			W_A2 <= 5'b00000;
			M_A3 <= 5'b00000;
			W_A3 <= 5'b00000;
		end
		else begin
			M_GRFWE <= E_GRFWE;
			W_GRFWE <= M_GRFWE;
			M_DMWE <= E_DMWE;
			M_WidthSel <= E_WidthSel;
			M_LoadSign <= E_LoadSign;
			M_WhichToReg <= E_WhichToReg;
			W_WhichToReg <= M_WhichToReg;
			M_A1 <= E_A1;
			W_A1 <= M_A1;
			M_A2 <= E_A2;
			W_A2 <= M_A2;
			M_A3 <= E_A3;
			W_A3 <= M_A3;
		end
	end
	
	assign NPCType = D_NPCType;
	assign EXTType = D_EXTType;
	assign CMPType = D_CMPType;
	assign GRFWE = W_GRFWE;
	assign DMWE = M_DMWE;
	assign RegDst = D_RegDst;
	assign ALUSrc = E_ALUSrc;
	assign ALUOp = E_ALUOp;
	assign WidthSel = M_WidthSel;
	assign LoadSign = M_LoadSign;
	assign WhichToReg = W_WhichToReg;
endmodule
