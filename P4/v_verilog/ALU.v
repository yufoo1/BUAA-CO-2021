`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:59:02 11/01/2021 
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
module ALU(
    input [31:0] ALURead1,
    input [31:0] ALURead2,
    input [3:0] ALUOp,
    output reg [31:0] Res,
    output IsEq
    );
	always@(*) begin
		case(ALUOp)
			4'b0000: Res = ALURead1 + ALURead2;
			4'b0001: Res = ALURead1 - ALURead2;
			4'b0010: Res = ALURead1 & ALURead2;
			4'b0011: Res = ALURead1 | ALURead2;
			4'b0100: Res = {ALURead2, 16'h0000};
			default: Res = 32'h00000000;
		endcase
	end
	
	assign IsEq = (ALURead1 == ALURead2) ? 1 : 0;

endmodule
