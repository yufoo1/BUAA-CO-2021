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
`define NORMAL_TYPE 4'b0000
`define BRANCH_TYPE 4'b0001
`define J_TYPE 4'b0010
`define JR_TYPE 4'b0011
module NPC(
    input [2:0] NPCType,
	 input CMPRes,
	 input [31:0] imm32,
    input [31:0] instr,
	 input [31:0] JrAddr,
    input [31:0] F_PC,
	 input [31:0] D_PC,
    output reg [31:0] O
    );
	 initial begin
		O = 32'h00003000;
	 end
	 always@(*) begin
		case (NPCType) 
			`NORMAL_TYPE: begin
				O = F_PC + 4;
			end
			`BRANCH_TYPE: begin
				if (CMPRes == 1'b1) begin
					O = D_PC + 4 + (imm32 << 2);
				end
				else begin
					O = F_PC + 4;
				end
			end
			`J_TYPE: begin
				O = {D_PC[31:28], instr[25:0], 2'b00};
			end
			`JR_TYPE: begin
				O = JrAddr;
			end
			default: begin
			end
		endcase
	 end

endmodule
