`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:06:35 11/01/2021 
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
    input IsSignExt,
    output reg [31:0] imm32
    );
	always@(*) begin
		if (IsSignExt == 1 && imm16[15] == 1) begin
			imm32 = {16'hffff, imm16};
		end
		else if ((IsSignExt == 1 && imm16[15] == 0) || IsSignExt == 0) begin
			imm32 = {16'h0000, imm16};
		end
		else begin
		end
	end

endmodule
