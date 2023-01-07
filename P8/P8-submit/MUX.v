`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:16:39 11/28/2021 
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
			2'b00: begin
				out = in0;
			end
			2'b01: begin
				out = in1;
			end
			2'b10: begin
				out = in2;
			end
			2'b11: begin
				out = in3;
			end
			default: begin
			end
		endcase
	 end
endmodule

module MUX_2_32(
    input [31:0] in0,
	 input [31:0] in1,
	 input sel,
	 output reg [31:0] out
    );
	 
	 always@(*) begin
		case(sel)
			1'b0: begin
				out = in0;
			end
			1'b1: begin
				out = in1;
			end
			default: begin
			end
		endcase
	 end
endmodule

module MUX_8_32(
    input [31:0] in0,
	 input [31:0] in1,
	 input [31:0] in2,
	 input [31:0] in3,
	 input [31:0] in4,
	 input [31:0] in5,
	 input [31:0] in6,
	 input [31:0] in7,
	 input [2:0] sel,
	 output reg [31:0] out
    );
	 
	 always@(*) begin
		case(sel)
			3'b000: begin
				out = in0;
			end
			3'b001: begin
				out = in1;
			end
			3'b010: begin
				out = in2;
			end
			3'b011: begin
				out = in3;
			end
			3'b100: begin
				out = in4;
			end
			3'b101: begin
				out = in5;
			end
			3'b110: begin
				out = in6;
			end
			3'b111: begin
				out = in7;
			end
			default: begin
			end
		endcase
	 end
endmodule


module MUX_16_32(
    input [31:0] in0,
	 input [31:0] in1,
	 input [31:0] in2,
	 input [31:0] in3,
	 input [31:0] in4,
	 input [31:0] in5,
	 input [31:0] in6,
	 input [31:0] in7,
	 input [31:0] in8,
	 input [31:0] in9,
	 input [31:0] in10,
	 input [31:0] in11,
	 input [31:0] in12,
	 input [31:0] in13,
	 input [31:0] in14,
	 input [31:0] in15,
	 input [3:0] sel,
	 output reg [31:0] out
    );
	
	 always@(*) begin
		case(sel)
			4'b0000: begin
				out = in0;
			end
			4'b0001: begin
				out = in1;
			end
			4'b0010: begin
				out = in2;
			end
			4'b0011: begin
				out = in3;
			end
			4'b0100: begin
				out = in4;
			end
			4'b0101: begin
				out = in5;
			end
			4'b0110: begin
				out = in6;
			end
			4'b0111: begin
				out = in7;
			end
			4'b1000: begin
				out = in8;
			end
			4'b1001: begin
				out = in9;
			end
			4'b1010: begin
				out = in10;
			end
			4'b1011: begin
				out = in11;
			end
			4'b1100: begin
				out = in12;
			end
			4'b1101: begin
				out = in13;
			end
			4'b1110: begin
				out = in14;
			end
			4'b1111: begin
				out = in15;
			end
			default: begin
			end
		endcase
	 end
endmodule

