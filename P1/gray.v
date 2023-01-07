`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:06:03 10/12/2021 
// Design Name: 
// Module Name:    gray 
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
module gray(
	input Clk,
	input Reset,
	input En,
	output reg [2:0] Output,
	output reg Overflow
    );
	initial begin
		Output <= 3'b000;
		Overflow <= 1'b0;
	end
	always@(posedge Clk) begin
		if(Reset == 1'b1) begin
			Output <= 3'b000;
			Overflow <= 1'b0;
		end
		else if (En == 1'b1) begin
			case(Output)
				3'b000: Output <= 3'b001;
				3'b001: Output <= 3'b011;
				3'b011: Output <= 3'b010;
				3'b010: Output <= 3'b110;
				3'b110: Output <= 3'b111;
				3'b111: Output <= 3'b101;
				3'b101: Output <= 3'b100;
				3'b100: begin
					Output <= 3'b000;
					Overflow <= 1'b1;
				end
			endcase
		end
		else begin
		end
	end

endmodule
