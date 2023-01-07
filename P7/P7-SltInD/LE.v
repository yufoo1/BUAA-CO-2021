`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:59:32 12/07/2021 
// Design Name: 
// Module Name:    LE 
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
`define LW   4'b0000
`define LB   4'b0001
`define LBU  4'b0010
`define LH   4'b0011
`define LHU  4'b0100
module LE(
    input [31:0] A,
    input [31:0] M_ALU_O,
    input [3:0] LEType,
    output reg [31:0] O
    );
	 initial begin
		O = 32'h00000000;
	 end
	 always@(*) begin
		if (LEType == `LW) begin
			O = A;
		end
		else if (LEType == `LB) begin
			if (M_ALU_O[1:0] == 2'b00) begin
				O = {{24{A[7]}}, A[7:0]};
			end
			else if (M_ALU_O[1:0] == 2'b01) begin
				O = {{24{A[15]}}, A[15:8]};
			end
			else if (M_ALU_O[1:0] == 2'b10) begin
				O = {{24{A[23]}}, A[23:16]};
			end
			else begin
				O = {{24{A[31]}}, A[31:24]};
			end
		end
		else if (LEType == `LBU) begin
			if (M_ALU_O[1:0] == 2'b00) begin
				O = {24'h000000, A[7:0]};
			end
			else if (M_ALU_O[1:0] == 2'b01) begin
				O = {24'h000000, A[15:8]};
			end
			else if (M_ALU_O[1:0] == 2'b10) begin
				O = {24'h000000, A[23:16]};
			end
			else begin
				O = {24'h000000, A[31:24]};
			end
		end
		else if (LEType == `LH) begin
			if (M_ALU_O[1] == 1'b0) begin
				O = {{16{A[15]}}, A[15:0]};
			end
			else begin
				O = {{16{A[31]}}, A[31:16]};
			end
		end
		else if (LEType == `LHU) begin
			if (M_ALU_O[1] == 1'b0) begin
				O = {16'h0000, A[15:0]};
			end
			else begin
				O = {16'h0000, A[31:16]};
			end
		end
		else begin
			O = 32'h00000000;
		end
	 end


endmodule
