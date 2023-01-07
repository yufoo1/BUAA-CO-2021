`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:24:24 12/07/2021 
// Design Name: 
// Module Name:    BE 
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
module BE(
    input [31:0] M_ALU_O,
    input [3:0] BEType,
    input [31:0] A,
    output reg [31:0] O,
	 output reg [3:0] byteen
    );
	 initial begin
		O = 32'h00000000;
		byteen = 4'b0000;
	 end
	 always@(*) begin
		if (BEType == 4'b0001) begin
			O = A;
			byteen = 4'b1111;
		end
		else if (BEType == 4'b0010) begin
			if (M_ALU_O[1:0] == 2'b00) begin
				O = A;
				byteen = 4'b0001;
			end
			else if (M_ALU_O[1:0] == 2'b01) begin
				O = {16'h0000, A[7:0], 8'h00};
				byteen = 4'b0010;
			end
			else if (M_ALU_O[1:0] == 2'b10) begin
				O = {8'h00, A[7:0], 16'h0000};
				byteen = 4'b0100;
			end
			else begin
				O = {A[7:0], 24'h000000};
				byteen = 4'b1000;
			end
		end
		else if (BEType == 4'b0011) begin
			if (M_ALU_O[1] == 1'b0) begin
				O = {16'h0000, A[15:0]};
				byteen = 4'b0011;
			end
			else begin
				O = {A[15:0], 16'h0000};
				byteen = 4'b1100;
			end
		end
		else begin
			byteen = 4'b0000;
		end
	 end
endmodule
