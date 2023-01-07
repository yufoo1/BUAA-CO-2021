`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:13:31 11/28/2021 
// Design Name: 
// Module Name:    ALU 
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

`define ADD 4'b0000
`define SUB 4'b0001
`define AND  4'b0010
`define ORI  4'b0011
`define SLL  4'b0100
`define SRL  4'b0101
`define SRA  4'b0110
`define SLLV 4'b0111
`define SRLV 4'b1000
`define SRAV 4'b1001
`define XOR  4'b1010
`define NOR  4'b1011
module ALU(
    input [31:0] A1,
    input [31:0] A2,
	 input [4:0] shamt,
	 input [3:0] ALUOp,
    output reg [31:0] O
    );
	 initial begin
		O = 32'h00000000;
	 end
	 always@(*) begin
		case(ALUOp)
			`ADD: begin
				O = A1 + A2;
			end
			`SUB: begin
				O = A1 - A2;
			end
			`AND: begin
				O = A1 & A2;
			end
			`ORI: begin
				O = A1 | A2;
			end
			`SLL: begin
				O = A2 << shamt;
			end
			`SRL: begin
				O = A2 >> shamt;
			end
			`SRA: begin
				O = $signed(A2) >>> shamt;
			end
			`SLLV: begin
				O = A2 << A1[4:0];
			end
			`SRLV: begin
				O = A2 >> A1[4:0];
			end
			`SRAV: begin
				O = $signed(A2) >>> A1[4:0];
			end
			`XOR: begin
				O = A1 ^ A2;
			end
			`NOR: begin
				O = ~(A1 | A2);
			end
			default: begin
				O = 32'h00000000;
			end
		endcase
	 end
endmodule
