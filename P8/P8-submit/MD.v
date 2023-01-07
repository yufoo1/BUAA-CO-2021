`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:38:12 12/07/2021 
// Design Name: 
// Module Name:    MD 
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
`define MULT    4'b0001
`define MULTU   4'b0010
`define DIV     4'b0011
`define DIVU    4'b0100
`define MTLO    4'b0101
`define MTHI    4'b0110
module MD(
    input [31:0] A1,
    input [31:0] A2,
    input clk,
    input reset,
	 input [3:0] MDOp,
	 input Req,
    output reg [31:0] LO,
    output reg [31:0] HI,
	 output busy
    );
	 reg [63:0] res;
	 reg [3:0] cnt;
	 always@(posedge clk) begin
		if (reset == 1'b1) begin
			res <= 64'h0000000000000000;
			cnt <= 4'b0000;
			LO <= 32'h00000000;
			HI <= 32'h00000000;
		end
		else begin
			if (MDOp != 4'b0000 && Req != 1'b1) begin
				case(MDOp)
				`MULT: begin
					//res <= $signed(A1) * $signed(A2);
					cnt <= 5;
				end
				`MULTU: begin
					//res <= A1 * A2;
					cnt <= 5;
				end
				`DIV: begin
					//res[31:0] <= (A2 == 32'h00000000) ? $signed(32'h00000000) : ($signed(A1) / $signed(A2));
					//res[63:32] <= (A2 == 32'h00000000) ? $signed(32'h00000000) : ($signed(A1) % $signed(A2));
					cnt <= 10;
				end
				`DIVU: begin
					//res[31:0] <= (A2 == 32'h00000000) ? 32'h00000000 : (A1 / A2);
					//res[63:32] <= (A2 == 32'h00000000) ? 32'h00000000 : (A1 % A2);
					cnt <= 10;
				end
				`MTLO: begin
					if (busy == 0) begin
						LO <= A1;
					end
					else begin
					end
				end
				`MTHI: begin
					if (busy == 0) begin
						HI <= A1;
					end
					else begin
					end
				end
				default: begin
				end
			endcase
			end
			else if (MDOp == 4'b0000) begin
				if (cnt > 1) begin
					cnt <= cnt - 1;
				end
				else if (cnt == 1) begin
					cnt <= cnt - 1;
					LO <= res[31:0];
					HI <= res[63:32];
				end
				else begin
				end
			end
			else begin
			end
		end
	 end
	 assign busy = (cnt != 0) ? 1 : 0;
endmodule
