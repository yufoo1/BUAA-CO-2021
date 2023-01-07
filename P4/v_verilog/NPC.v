`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:42:41 11/19/2021 
// Design Name: 
// Module Name:    NPC 
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
module NPC(
    input [31:0] PC,
    input IsBranchType,
	 input IsJType,
	 input [31:0] instr,
	 input IsJr,
	 input [31:0] JrAddr,
    input [31:0] imm32,
    output reg [31:0] NPC
    );
	 always@(*) begin
		if (IsBranchType) begin
			NPC = PC + 4 + (imm32 << 2);
		end
		else if (IsJType) begin
			NPC = {PC[31:28], instr[25:0], 2'b00};
		end
		else if (IsJr) begin
			NPC = JrAddr;
		end
		else begin
			NPC = PC + 4;
		end
	 end

endmodule
