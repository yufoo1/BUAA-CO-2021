`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:55:35 11/13/2021 
// Design Name: 
// Module Name:    DataPath 
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
module DataPath(
    input clk,
    input reset,
    input WeGRF,
	 input WeDM,
    input [1:0] RegDst,
    input [1:0] WhichToReg,
    input ALUSrc,
    input [3:0] ALUOp,
    input IsSignExt,
    input IsBranchType,
	 input IsJType,
	 input IsJr,
	 output [31:0] instr,
	 output IsEq
    );
	 wire clk, reset;
	 wire [31:0] ALURead2, GRFWrite;
	 wire IsEq;
	 wire [4:0] GRFWriteAddr;
	 
	 //out from IFU
	 wire [31:0] instr;
	 wire [31:0] PC;
	 
	 //out from NPC;
	 wire [31:0] NPC;
	 
	 //out from ALU
	 wire [31:0] Res;
	 
	 //out from GRF
	 wire [31:0] GRFRead1;
	 wire [31:0] GRFRead2;
	 
	 //out from DM
	 wire [31:0] DMRead;
	 
	 //out from EXT
	 wire [31:0] imm32;
	 
	 
	 NPC npc(
		//input
		.PC(PC),
		.IsBranchType(IsBranchType),
		.IsJType(IsJType),
		.instr(instr),
		.IsJr(IsJr),
		.JrAddr(GRFRead1),
		.imm32(imm32),
		//output
		.NPC(NPC)
	 );
	 
	 IFU ifu(
		//input
		.NPC(NPC),
		.clk(clk),
		.reset(reset),
		//output
		.instr(instr),
		.PC(PC)
	 );
	 
	 MUX_2_32 MUXALURead2(
		//input
		.in0(GRFRead2),
		.in1(imm32),
		.sel(ALUSrc),
		//output
		.out(ALURead2)
	 );
	 
	 ALU alu(
		//input
		.ALURead1(GRFRead1),
		.ALURead2(ALURead2),
		.ALUOp(ALUOp),
		//output
		.Res(Res),
		.IsEq(IsEq)
	 );

	 MUX_4_5 MUXGRFWriteAddr(
		//input
		.in0(instr[15:11]),
		.in1(instr[20:16]),
		.in2(5'd31),
		.sel(RegDst),
		//output
		.out(GRFWriteAddr)
	 );
	 
	 MUX_4_32 MUXGRFWrite(
		//input
		.in0(Res),
		.in1(DMRead),
		.in2(PC+4),
		.sel(WhichToReg),
		//output
		.out(GRFWrite)
	 );
	 
	 GRF grf(
		//input
		.GRFReadAddr1(instr[25:21]),
		.GRFReadAddr2(instr[20:16]),
		.GRFWriteAddr(GRFWriteAddr),
		.GRFWrite(GRFWrite),
		.clk(clk),
		.reset(reset),
		.WeGRF(WeGRF),
		
		.PC(PC),
		//output
		.GRFRead1(GRFRead1),
		.GRFRead2(GRFRead2)
	 );
	 
	 DM dm(
		//input
		.DMAddr(Res),
		.DMWrite(GRFRead2),
		.clk(clk),
		.reset(reset),
		.WeDM(WeDM),
		
		.PC(PC),
		//output
		.DMRead(DMRead)
	 );
	 
	 EXT ext(
		//input
		.imm16(instr[15:0]),
		.IsSignExt(IsSignExt),
		//output
		.imm32(imm32)
	 );
	 
	
	

endmodule
