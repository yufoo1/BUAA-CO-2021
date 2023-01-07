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
	 initial begin
		out = in0;
	 end
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

module MUX_4_5(
    input [4:0] in0,
	 input [4:0] in1,
	 input [4:0] in2,
	 input [4:0] in3,
	 input [1:0] sel,
	 output reg [4:0] out
    );
	 initial begin
		out = in0;
	 end
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
	 initial begin
		out = in0;
	 end
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
	 initial begin
		out = in0;
	 end
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


