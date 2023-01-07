`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:11:39 12/06/2021 
// Design Name: 
// Module Name:    MUXD_RegDst 
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
module MUXD_RegDst(
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [3:0] D_RegDst,
    output reg [4:0] D_MUXD_RegDst_O
    );
	 initial begin
		D_MUXD_RegDst_O = 5'b00000;
	 end
	 always@(*) begin
		if (D_RegDst == 4'b0000) begin
			D_MUXD_RegDst_O = 5'b00000;
		end
		else if (D_RegDst == 4'b0001) begin
			D_MUXD_RegDst_O = 5'b11111;
		end
		else if (D_RegDst == 4'b0010) begin
			D_MUXD_RegDst_O = A2;
		end
		else if (D_RegDst == 4'b0011) begin
			D_MUXD_RegDst_O = A3;
		end
		else begin
			D_MUXD_RegDst_O = 5'b00000;
		end
	 end

endmodule
