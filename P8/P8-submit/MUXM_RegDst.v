`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:32:35 12/06/2021 
// Design Name: 
// Module Name:    MUXM_RegDst 
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
module MUXM_RegDst(
    input [4:0] M_MUXE_RegDst_O,
	 input [4:0] A1,
	 input [4:0] A2,
	 input [4:0] A3,
    input [31:0] M_ALU_O,
	 input Req,
	 input M_OverflowCalInstr,
	 input M_Overflow,
    input [3:0] M_RegDst,
    output reg [4:0] M_MUXM_RegDst_O
    );
	 always@(*) begin
		if ((M_RegDst == 4'b0000 || M_RegDst == 4'b0001 || M_RegDst == 4'b0010 || M_RegDst == 4'b0011) && !(M_OverflowCalInstr && M_Overflow) && !Req) begin
			M_MUXM_RegDst_O = M_MUXE_RegDst_O;
		end
		else begin
			M_MUXM_RegDst_O = 5'b00000;
		end
	 end

endmodule
