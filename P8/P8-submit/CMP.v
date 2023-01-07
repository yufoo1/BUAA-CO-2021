`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:10:54 11/28/2021 
// Design Name: 
// Module Name:    CMP 
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
`define BEQ   4'b0000
`define SLT   4'b0001
`define SLTI  4'b0010
`define SLTIU 4'b0011
`define SLTU  4'b0100
`define BNE   4'b0101
`define BLEZ  4'b0110
`define BGTZ  4'b0111
`define BLTZ  4'b1000
`define BGEZ  4'b1001
module CMP(
    input [31:0] A1,
    input [31:0] A2,
	 input [31:0] imm32,
    input [3:0] CMPType,
    output reg [31:0] O
    );
	 
	 always@(*) begin
		O = 32'h00000000;
		case (CMPType)
			`BEQ: begin
				if (A1 == A2) begin
					O = 32'h00000001;
				end
				else begin
					O = 32'h00000000;
				end
			end
			`SLT: begin
				if ($signed(A1) < $signed(A2)) begin
					O = 32'h00000001;
				end
				else begin
					O = 32'h00000000;
				end
			end
			`SLTI: begin
				if ($signed(A1) < $signed(imm32)) begin
					O = 32'h00000001;
				end
				else begin
					O = 32'h00000000;
				end
			end
			`SLTIU: begin
				if (A1 < imm32) begin
					O = 32'h00000001;
				end
				else begin
					O = 32'h00000000;
				end
			end
			`SLTU: begin
				if (A1 < A2) begin
					O = 32'h00000001;
				end
				else begin
					O = 32'h00000000;
				end
			end
			`BNE: begin
				if (A1 != A2) begin
					O = 32'h00000001;
				end
				else begin
					O = 32'h00000000;
				end
			end
			`BLEZ: begin
				if ($signed(A1) <= $signed(0)) begin
					O = 32'h00000001;
				end
				else begin
					O = 32'h00000000;
				end
			end
			`BGTZ: begin
				if ($signed(A1) > $signed(0)) begin
					O = 32'h00000001;
				end
				else begin
					O = 32'h00000000;
				end
			end
			`BLTZ: begin
				if ($signed(A1) < $signed(0)) begin
					O = 32'h00000001;
				end
				else begin
					O = 32'h00000000;
				end
			end
			`BGEZ: begin
				if ($signed(A1) >= $signed(0)) begin
					O = 32'h00000001;
				end
				else begin
					O = 32'h00000000;
				end
			end
			default: begin
				O = 32'h00000000;
			end
		endcase
	 end

endmodule
