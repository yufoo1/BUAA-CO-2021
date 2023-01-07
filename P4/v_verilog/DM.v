`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:28:20 11/01/2021 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input [31:0] DMAddr,
    input [31:0] DMWrite,
    input clk,
    input reset,
    input WeDM,
    output [31:0] DMRead,
	 
	 input[31:0] PC
    );
	reg[31:0] RAM[1023:0];
	integer i;
	initial begin
		for (i=0; i<1024; i=i+1)  begin
			RAM[i] = 32'h00000000;
		end
	end
	always@(posedge clk) begin
		if (reset == 1) begin
			for (i=0; i<1024; i=i+1) begin
				RAM[i] <= 32'h00000000;
			end
		end
		else begin
			if (WeDM == 1) begin
				RAM[DMAddr[11:2]] <= DMWrite;
				$display("@%h: *%h <= %h", PC, DMAddr, DMWrite);
			end
			else begin
			end
		end
	end
	assign DMRead = RAM[DMAddr[11:2]];
	
endmodule
