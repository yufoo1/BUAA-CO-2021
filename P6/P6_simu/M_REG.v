`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:26:39 11/29/2021 
// Design Name: 
// Module Name:    M_REG 
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
module M_REG(
	 input clk,
	 input reset,
    input [31:0] E_ALU_O,
    input [31:0] E_O2,
    input [31:0] E_PC,
    input [31:0] E_EXT_O,
	 input [31:0] E_CMP_O,
	 input [31:0] E_MUXMDSrc_O,
    input [4:0] E_A3,
    output reg [31:0] M_ALU_O,
    output reg [31:0] M_O2,
    output reg [31:0] M_PC,
    output reg [31:0] M_EXT_O,
	 output reg [31:0] M_CMP_O,
	 output reg [31:0] M_MUXMDSrc_O,
    output reg [4:0] M_A3
    );
	 initial begin
		M_ALU_O = 32'h00000000;
		M_O2 = 32'h00000000;
		M_PC = 32'h00003000;
		M_EXT_O = 32'h00000000;
		M_CMP_O = 32'h0000000;
		M_MUXMDSrc_O = 32'h00000000;
		M_A3 = 5'b00000;
	 end
	 always@(posedge clk) begin
		if (reset) begin
			M_ALU_O <= 32'h00000000;
			M_O2 <= 32'h00000000;
			M_PC <= 32'h00000000;
			M_EXT_O <= 32'h00000000;
			M_CMP_O <= 32'h0000000;
			M_MUXMDSrc_O <= 32'h00000000;
			M_A3 <= 5'b00000;
		end
		else begin
			M_ALU_O <= E_ALU_O;
			M_O2 <= E_O2;
			M_PC <= E_PC;
			M_EXT_O <= E_EXT_O;
			M_CMP_O <= E_CMP_O;
			M_MUXMDSrc_O <= E_MUXMDSrc_O;
			M_A3 <= E_A3;
		end
	 end

endmodule
