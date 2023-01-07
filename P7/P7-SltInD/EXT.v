`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:45:48 11/28/2021 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [15:0] imm16,
    input [3:0] EXTType,
    output reg [31:0] O
    );
	 initial begin
		O = 32'h00000000;
	 end
	always@(*) begin
		if (EXTType == 4'b0001) begin
			if (imm16[15] == 1'b1) begin
				O = {16'hffff, imm16};
			end
			else if (imm16[15] == 1'b0) begin
				O = {16'h0000, imm16};
			end
			else begin
			end
		end
		else if (EXTType == 4'b0010) begin
			O = {imm16, 16'h0000};
		end
		else if (EXTType == 4'b0000) begin
			O = {16'h0000, imm16};
		end
		else begin
		end
	end

endmodule
