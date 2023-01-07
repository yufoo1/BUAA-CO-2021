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

`define ADDU 4'b0000
`define SUBU 4'b0001
`define AND  4'b0010
`define ORI  4'b0011


module ALU(
    input [31:0] A1,
    input [31:0] A2,
	 input [3:0] ALUOp,
    output reg [31:0] O
    );
	 initial begin
		O = 32'h00000000;
	 end
	 always@(*) begin
		case(ALUOp)
			`ADDU: begin
				O = A1 + A2;
			end
			`SUBU: begin
				O = A1 - A2;
			end
			`AND: begin
				O = A1 & A2;
			end
			`ORI: begin
				O = A1 | A2;
			end
			default: begin
			end
		endcase
	 end
endmodule
