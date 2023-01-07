`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:20:38 11/01/2021 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input [4:0] GRFReadAddr1,
    input [4:0] GRFReadAddr2,
    input [4:0] GRFWriteAddr,
    input [31:0] GRFWrite,
    input clk,
    input reset,
    input WeGRF,
    output [31:0] GRFRead1,
    output [31:0] GRFRead2,
	 
	 input[31:0] PC
    );
	reg[31:0] register[31:0];
	integer i;
	initial begin
		for (i=0; i<32; i=i+1) begin
			register[i] = 32'h00000000;
		end
	end
	
	always@(posedge clk) begin
		if (reset == 1'b1) begin
			for (i=0; i<32; i=i+1) begin
				register[i] <= 32'h00000000;
			end
		end
		else begin
			if (GRFWriteAddr != 5'b00000 && WeGRF == 1'b1) begin
				register[GRFWriteAddr] <= GRFWrite;
				$display("@%h: $%d <= %h", PC, GRFWriteAddr, GRFWrite);
			end
			else if (GRFWriteAddr == 5'b00000 && WeGRF == 1'b1) begin
				register[GRFWriteAddr] <= 32'h00000000;
				$display("@%h: $%d <= %h", PC, 5'b00000, 32'h00000000);
			end
			else begin
			end
		end
	end
	assign GRFRead1 = register[GRFReadAddr1];
	assign GRFRead2 = register[GRFReadAddr2];


endmodule
