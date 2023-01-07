`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:20:10 11/28/2021 
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
`define NORMALTYPE 4'b0000
`define BRANCHTYPE 4'b0001
`define JTYPE      4'b0010
`define JRTYPE     4'b0011
`define ERET       4'b0100
module NPC(
    input [3:0] NPCType,
	 input [31:0] CMPRes,
	 input [31:0] imm32,
    input [31:0] instr,
	 input [31:0] JrAddr,
    input [31:0] F_PC,
	 input [31:0] D_PC,
	 input [31:0] EPC,
	 input Req,
    output reg [31:0] O
    );
	
	 always@(*) begin
		if (Req) begin
			O = 32'h00004180;
		end
		else begin
			case (NPCType) 
			`NORMALTYPE: begin
				O = F_PC + 4;
			end
			`BRANCHTYPE: begin
				if (CMPRes == 32'h00000001) begin
					O = D_PC + 4 + (imm32 << 2);
				end
				else begin
					O = F_PC + 4;
				end
			end
			`JTYPE: begin
				O = {D_PC[31:28], instr[25:0], 2'b00};
			end
			`JRTYPE: begin
				O = JrAddr;
			end
			`ERET: begin
				O = EPC;
			end
			default: begin
			end
			endcase
		end
	 end

endmodule
