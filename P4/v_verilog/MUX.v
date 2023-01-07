`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:53:27 11/19/2021 
// Design Name: 
// Module Name:    MUX 
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
module MUX_2_32(
	input [31:0] in0,
	input [31:0] in1,
	input sel,
	output reg [31:0] out
    );
	always@(*) begin
		case(sel)
			1'b0: out = in0;
			1'b1: out = in1;
			default: out = 32'h00000000;
		endcase
	end
endmodule

module MUX_4_5(
	input [4:0] in0,
	input [4:0] in1,
	input [4:0] in2,
	input [4:0] in3,
	input [1:0] sel,
	output reg [4:0] out
    );
	always@(*) begin
		case(sel)
			2'b00: out = in0;
			2'b01: out = in1;
			2'b10: out = in2;
			2'b11: out = in3;
			default: out = 5'b00000;
		endcase
	end
endmodule

module MUX_4_32(
	input [31:0] in0,
	input [31:0] in1,
	input [31:0] in2,
	input [31:0] in3,
	input [1:0] sel,
	output reg [31:0] out
    );
	always@(*) begin
		case(sel)
			2'b00: out = in0;
			2'b01: out = in1;
			2'b10: out = in2;
			2'b11: out = in3;
			default: out = 32'h00000000;
		endcase
	end
endmodule




