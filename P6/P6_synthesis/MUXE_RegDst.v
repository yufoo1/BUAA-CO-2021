`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:27:36 12/06/2021 
// Design Name: 
// Module Name:    MUXE_RegDst 
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
module MUXE_RegDst(
    input [4:0] E_MUXD_RegDst_O,
	 input [4:0] A1,
	 input [4:0] A2,
	 input [4:0] A3,
    input [31:0] E_ALU_O,
    input [3:0] E_RegDst,
    output reg [4:0] E_MUXE_RegDst_O
    );
	 always@(*) begin
		if (E_RegDst == 4'b0000 || E_RegDst == 4'b0001 || E_RegDst == 4'b0010 || E_RegDst == 4'b0011) begin
			E_MUXE_RegDst_O = E_MUXD_RegDst_O;
		end
		else begin
			E_MUXE_RegDst_O = 5'b00000;
		end
	 end


endmodule
