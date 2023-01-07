`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:34:09 11/29/2021 
// Design Name: 
// Module Name:    W_REG 
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
module W_REG(
    input clk,
    input reset,
    input [31:0] M_ALU_O,
    input [31:0] M_DM_O,
    input [31:0] M_PC,
    input [31:0] M_EXT_O,
	 input [31:0] M_CMP_O,
	 input [31:0] M_MUXMDSrc_O,
    input [4:0] M_A3,
    output reg [31:0] W_ALU_O,
    output reg [31:0] W_DM_O,
    output reg [31:0] W_PC,
    output reg [31:0] W_EXT_O,
	 output reg [31:0] W_CMP_O,
	 output reg [31:0] W_MUXMDSrc_O,
    output reg [4:0] W_A3
    );
	 initial begin
		W_ALU_O = 32'h00000000;
		W_DM_O = 32'h00000000;
		W_PC = 32'h00003000;
		W_EXT_O = 32'h00000000;
		W_CMP_O = 32'h00000000;
		W_MUXMDSrc_O = 32'h00000000;
		W_A3 = 5'b00000;
	 end
	 always@(posedge clk) begin
		if (reset) begin
			W_ALU_O <= 32'h00000000;
			W_DM_O <= 32'h00000000;
			W_PC <= 32'h00003000;
			W_EXT_O <= 32'h00000000;
			W_CMP_O <= 32'h00000000;
			W_MUXMDSrc_O <= 32'h00000000;
			W_A3 <= 5'b00000;
		end
		else begin
			W_ALU_O <= M_ALU_O;
			W_DM_O <= M_DM_O;
			W_PC <= M_PC;
			W_EXT_O <= M_EXT_O;
			W_CMP_O <= M_CMP_O;
			W_MUXMDSrc_O <= M_MUXMDSrc_O;
			W_A3 <= M_A3;
		end
	 end

endmodule
