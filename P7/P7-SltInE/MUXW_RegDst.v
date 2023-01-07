`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:21:19 12/11/2021 
// Design Name: 
// Module Name:    MUXW_RegDst 
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
module MUXW_RegDst(
    input [4:0] W_MUXM_RegDst_O,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [3:0] W_RegDst,
	 input [31:0] W_DM_O,
    output reg [4:0] W_MUXW_RegDst_O
    );
	 always@(*) begin
		if (W_RegDst == 4'b0000 || W_RegDst == 4'b0001 || W_RegDst == 4'b0010 || W_RegDst == 4'b0011) begin
			W_MUXW_RegDst_O = W_MUXM_RegDst_O;
		end
		else begin
			W_MUXW_RegDst_O = 5'b00000;
		end
	 end
	 

endmodule
