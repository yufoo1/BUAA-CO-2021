`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:13:16 10/12/2021 
// Design Name: 
// Module Name:    BlockChecker 
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
`define S0 4'b0000
`define S1 4'b0001
`define S2 4'b0010
`define S3 4'b0011
`define S4 4'b0100
`define S5 4'b0101
`define S6 4'b0110
`define S7 4'b0111
`define S8 4'b1000
`define S9 4'b1001

module BlockChecker(
	input clk,
	input reset,
	input [7:0] in,
	output result
    );
	 reg [3:0] state;
	 reg flag;
	 reg [31:0] count;
	initial begin
		state <= `S0;
		count <= 32'h00000000;
	end
	always@(posedge clk, posedge reset) begin
		if (reset == 1) begin
			state <= `S0;
			count <= 32'h00000000;
		end
		else begin
			case(state)
				`S0: begin
					if ($signed(count) >= 0 && (in == "b" || in == "B")) begin
						state <= `S2;
					end
					else if (in == "e" || in == "E") begin
						state <= `S7;
					end
					else if ((in >= "a" && in <= "z") || (in >= "A" && in <= "Z")) begin
						state <= `S1;
					end
					else begin
					end
				end
				`S1: begin
					if (in == " ") begin
						state <= `S0;
					end
					else if ((in >= "a" && in <= "z") || (in >= "A" && in <= "Z")) begin
						state <= `S1;
					end
					else begin
					end
				end
				`S2: begin
					if(in == "e" || in == "E") begin
						state <= `S3;
					end
					else if (in == " ") begin
						state <= `S0;
					end
					else if ((in >= "a" && in <= "z") || (in >= "A" && in <= "Z")) begin
						state <= `S1;
					end
					else begin
					end
				end
				`S3: begin
					if (in == "g" || in == "G") begin
						state <= `S4;
					end
					else if (in == " ") begin
						state <= `S0;
					end
					else if ((in >= "a" && in <= "z") || (in >= "A" && in <= "Z")) begin
						state <= `S1;
					end
					else begin
					end
				end
				`S4: begin
					if (in == "i" || in == "I") begin
						state <= `S5;
					end
					else if (in == " ") begin
						state <= `S0;
					end
					else if ((in >= "a" && in <= "z") || (in >= "A" && in <= "Z")) begin
						state <= `S1;
					end
					else begin
					end
				end
				`S5: begin
					if (in == "n" || in == "N") begin
						state <= `S6;
						count <= $signed(count) + 32'h00000001;
					end
					else if (in == " ") begin
						state <= `S0;
					end
					else if ((in >= "a" && in <= "z") || (in >= "A" && in <= "Z")) begin
						state <= `S1;
					end
					else begin
					end
				end
				`S6: begin
					if (in == " ") begin
						state <= `S0;
					end
					else if ((in >= "a" && in <= "z") || (in >= "A" && in <= "Z")) begin
						state <= `S1;
						count <= $signed(count) - 32'h00000001;
					end
					else begin
					end
				end
				`S7: begin
					if (in == "n" || in == "N") begin
						state <= `S8;
					end
					else if (in == " ") begin
						state <= `S0;
					end
					else if ((in >= "a" && in <= "z") || (in >= "A" && in <= "Z")) begin
						state <= `S1;
					end
					else begin
					end
				end
				`S8: begin
					if (in == "d" || in == "D") begin
						state <= `S9;
						count <= $signed(count) - 32'h00000001;
					end
					else if (in == " ") begin
						state <= `S0;
					end
					else if ((in >= "a" && in <= "z") || (in >= "A" && in <= "Z")) begin
						state <= `S1;
					end
					else begin
					end
				end
				`S9: begin
					if (in == " ") begin
						state <= `S0;
					end
					else if ((in >= "a" && in <= "z") || (in >= "A" && in <= "Z")) begin
						state <= `S1;
						count <= $signed(count) + 32'h00000001;
					end
					else begin
					end
				end
			endcase
		end
	end
	assign result = (count == 32'h00000000) ? 1 : 0;
endmodule
