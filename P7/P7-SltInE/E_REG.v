`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:20:19 11/29/2021 
// Design Name: 
// Module Name:    E_REG 
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
module E_REG(
	 input clk,
	 input reset,
	 input Stall,
    input [31:0] D_O1,
    input [31:0] D_O2,
    input [31:0] D_PC,
    input [31:0] D_EXT_O,
	 input [31:0] D_CMP_O,
    input [4:0] D_A3,
	 input Req,
    output reg [31:0] E_O1,
    output reg [31:0] E_O2,
    output reg [31:0] E_PC,
    output reg [31:0] E_EXT_O,
	 output reg [31:0] E_CMP_O,
    output reg [4:0] E_A3
    );
	 initial begin
		E_O1 = 32'h00000000;
		E_O2 = 32'h00000000;
		E_PC = 32'h00003000;
		E_EXT_O = 32'h00000000;
		E_CMP_O = 32'h00000000;
		E_A3 = 5'b00000;
	 end
	 always@(posedge clk) begin
		if (reset || Req || Stall) begin
			E_O1 <= 32'h00000000;
			E_O2 <= 32'h00000000;
			E_PC <= (Stall) ? D_PC : (Req == 1'b1) ? 32'h00004180 : 32'h00003000;
			E_EXT_O <= 32'h00000000;
			E_CMP_O <= 32'h00000000;
			E_A3 <= 5'b00000;
		end
		else begin
			E_O1 <= D_O1;
			E_O2 <= D_O2;
			E_PC <= D_PC;
			E_EXT_O <= D_EXT_O;
			E_CMP_O <= D_CMP_O;
			E_A3 <= D_A3;
		end
	 end
endmodule
