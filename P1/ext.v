`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:54:55 10/12/2021 
// Design Name: 
// Module Name:    ext 
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
module ext(
	input [15:0] imm,
	input [1:0] EOp,
	output reg [31:0] ext
    );
	always@(*)begin
		case(EOp)
			2'b00: begin
				ext <= $signed({imm, 16'h0000}) >>> 16; 
			end
			2'b01: begin
				ext <= {16'h0000, imm};
			end
			2'b10: begin
				ext <= {imm, 16'h0000};
			end
			2'b11: begin
				ext <= $signed({imm, 16'h0000}) >>> 14; 
			end
		endcase
	end

endmodule
