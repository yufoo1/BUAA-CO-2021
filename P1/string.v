`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:59:56 10/12/2021 
// Design Name: 
// Module Name:    string 
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
`define S0 2'b00
`define S1 2'b01
`define S2 2'b10
module string(
	input clk,
	input clr,
	input [7:0] in,
	output out
    );
	 reg [1:0] state;
	 reg flag;
	 initial begin
		state <= `S0;
		flag <= 1'b1;
	 end
	always@(posedge clk, posedge clr) begin
		if (clr == 1) begin
			state <= `S0;
			flag <= 1'b1;
			
		end
		else begin
			case(state)
				`S0: begin
					if (flag == 1'b1 && in >= "0" && in <= "9") begin
						state <= `S1;
					end
					else begin
					end
				end
				`S1: begin
					if (flag <= 1'b1 && (in == "+" || in == "*")) begin
						state <= `S0;
					end
					else begin
						state <= `S0;
						flag <= 1'b0;
					end
				end
			endcase
		end
	end
	assign out = (state == `S1) ? 1 : 0;
endmodule
