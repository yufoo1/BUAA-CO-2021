`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:59:47 11/13/2021 
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
    input [31:0] NPC,
    input clk,
    input reset,
    output [31:0] instr,
	 output reg [31:0] PC
    );
	reg[31:0] ROM [1023:0];
	integer i;
	initial begin
		for (i=0; i<1024; i=i+1) begin
			ROM[i] = 32'h00000000;
		end
		PC = 32'h00003000;
		$readmemh("code.txt", ROM);
	end
	always@(posedge clk) begin
		if (reset == 1) begin
			PC <= 32'h00003000;
		end
		else begin
			PC <= NPC;
		end
	end
	assign instr = ROM[PC[11:2]];
	 


endmodule
