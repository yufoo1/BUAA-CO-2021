`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:56:56 11/19/2021 
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
    input clk,
    input reset
    );
	 
	 wire [31:0] instr;
	 wire [3:0] ALUOp;
	 wire WeGRF, WeDM, IsBranchType, IsJType, IsJr, ALUSrc, IsSignExt;
	 wire [1:0] RegDst, WhichToReg;
	 
	 Controller controller(
	   //input
		.instr(instr),
		.IsEq(IsEq),
		//output
		.ALUOp(ALUOp),
		.WeGRF(WeGRF),
		.WeDM(WeDM),
		.IsBranchType(IsBranchType),
		.IsJType(IsJType),
		.IsJr(IsJr),
		.ALUSrc(ALUSrc),
		.WhichToReg(WhichToReg),
		.RegDst(RegDst),
		.IsSignExt(IsSignExt)
	 );
	 
	 DataPath datapath(
		//input
		.clk(clk),
		.reset(reset),
		.WeGRF(WeGRF),
		.WeDM(WeDM),
		.RegDst(RegDst),
		.WhichToReg(WhichToReg),
		.ALUSrc(ALUSrc),
		.ALUOp(ALUOp),
		.IsSignExt(IsSignExt),
		.IsBranchType(IsBranchType),
		.IsJType(IsJType),
		.IsJr(IsJr),
		//output
		.instr(instr),
		.IsEq(IsEq)
	 );


endmodule
