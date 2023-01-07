`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:21:12 11/28/2021 
// Design Name: 
// Module Name:    IFU 
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
module IFU(
	 input clk,
	 input reset,
	 input Stall,
    input [31:0] NPC,
    output reg [31:0] PC,
    output reg [31:0] instr
    );
	 reg [31:0] ROM [4095:0];
	 integer i;
	 wire [31:0] PC_dealt;
	 initial begin
		PC = 32'h00003000;
		for(i=0; i<4096; i=i+1) begin
			ROM[i] = 32'h00000000;
		end
		$readmemh("code.txt", ROM);
	 end
	 assign PC_dealt = PC - 32'h00003000;
	 always@(posedge clk) begin
		if (reset == 1'b1) begin
			PC <= 32'h00003000;
		end
		else begin
			if (Stall != 1'b1) begin
				PC <= NPC;
			end
			else begin
			end
		end
	 end
	 always@(*) begin
		instr = ROM[PC_dealt[13:2]];
	 end

endmodule
