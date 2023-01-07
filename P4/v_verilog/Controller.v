`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:22:14 11/01/2021 
// Design Name: 
// Module Name:    Controller 
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
module Controller(
	 input [31:0] instr,
	 input IsEq,
    output [3:0] ALUOp,
    output WeGRF,
    output WeDM,
    output IsBranchType,
	 output IsJType,
	 output IsJr,
    output ALUSrc,
    output [1:0] WhichToReg,
    output [1:0] RegDst,
    output IsSignExt
    );
	 wire [5:0] op, func;
	 wire addu, subu, ori, lw, sw, beq, lui, j, jal, jr, nop;
	 wire RType;
	 
	 
	 
	 assign op = instr[31:26];
	 assign func = instr[5:0];
	 
	 
	 
	 assign RType = (op == 6'b000000) ? 1 : 0;
	 assign addu = (RType && func == 6'b100001) ? 1 : 0;
	 assign subu = (RType && func == 6'b100011) ? 1 : 0;
	 assign ori = (op == 6'b001101) ? 1 : 0;
	 assign lw = (op == 6'b100011) ? 1 : 0;
	 assign sw = (op == 6'b101011) ? 1 : 0;
	 assign beq = (op == 6'b000100) ? 1 : 0;
	 assign lui = (op == 6'b001111) ? 1 : 0;
	 assign j = (op == 6'b000010) ? 1 : 0;
	 assign jal = (op == 6'b000011) ? 1 : 0;
	 assign jr = (RType && func == 6'b001000) ? 1 : 0;
	 assign nop = (RType && func == 6'b000000) ? 1 : 0;
	 
	 
	 
	 assign ALUOp = (subu) ? 4'b0001 :
						 (ori) ? 4'b0011 :
						 (lui) ? 4'b0100 : 4'b0000;
	 assign WeGRF = (addu || subu || ori || lw || lui || jal) ? 1 : 0;
	 assign WeDM = (sw) ? 1 : 0;
	 assign IsBranchType = (beq && IsEq) ? 1 : 0;
	 assign IsJType = (j || jal) ? 1 : 0;
	 assign IsJr = (jr) ? 1 : 0;
	 assign ALUSrc = (ori || lui || lw || sw) ? 1 : 0;
	 assign WhichToReg = (lw) ? 2'b01 : 
								(jal) ? 2'b10 : 2'b00;
	 assign RegDst = (ori || lui || lw) ? 2'b01 : 
						  (jal) ? 2'b10 : 2'b00;
	 assign IsSignExt = (beq || lw || sw) ? 1 : 0;
endmodule
