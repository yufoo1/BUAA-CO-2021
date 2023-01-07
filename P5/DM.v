`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:52:30 11/28/2021 
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
`define WORD 2'b00
`define HALF_WORD 2'b01
`define BYTE 2'b10
module DM(
    input [31:0] A,
    input [31:0] WD,
	 input WE,
	 input clk,
	 input reset,
	 input [31:0] PC,
	 input [1:0] WidthSel,
	 input LoadSign,
    output reg [31:0] O
    );
	 reg [31:0] RAM[4095:0];
	 integer i;
	 initial begin
		for (i=0; i<4096; i=i+1) begin
			RAM[i] = 32'h00000000;
		end
		O = 32'h00000000;
	 end
	 always@(*) begin
		case(WidthSel)
			`WORD: begin
				O <= RAM[A[13:2]];
			end
		endcase
	 end
	 always@(posedge clk) begin
		if (reset == 1'b1) begin
			for (i=0; i<4096; i=i+1) begin
				RAM[i] <= 32'h00000000;
			end
		end
		else begin
			if (WE == 1'b1) begin
				case (WidthSel)
				`WORD: begin
					RAM[A[13:2]] <= WD;
					$display("%d@%h: *%h <= %h", $time, PC, A, WD);
				end
				default: begin
				end
				endcase
			end
			else begin
			end
		end
	 end


endmodule
