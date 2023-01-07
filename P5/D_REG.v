`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:14:24 11/29/2021 
// Design Name: 
// Module Name:    D_REG 
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
module D_REG(
	 input clk,
	 input reset,
	 input Stall,
    input [31:0] F_PC,
    input [31:0] F_instr,
    output reg [31:0] D_PC,
    output reg [31:0] D_instr
    );
	 initial begin
		D_PC = 32'h00003000;
		D_instr = 32'h00000000;
	 end
	 always@(posedge clk) begin
		if (reset) begin
			D_PC <= 32'h00003000;
			D_instr <= 32'h00000000;
		end
		else begin
			if (Stall != 1'b1) begin
				D_PC <= F_PC;
				D_instr <= F_instr;
			end
			else begin
			end
		end
	 end
	

endmodule
