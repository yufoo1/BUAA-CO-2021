`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:34:33 11/28/2021 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD,
    input clk,
    input reset,
    output reg [31:0] O1,
    output reg [31:0] O2
    );
	 reg [31:0] register [31:0];
	 integer i;
	 
	 always@(*) begin
		if (A1 == A3 && A1 != 0) begin
			O1 = WD;
		end
		else begin
			O1 = register[A1];
		end
		if (A2 == A3 && A2 != 0) begin
			O2 = WD;
		end
		else begin
			O2 = register[A2];
		end
	 end
	 always@(posedge clk) begin
		if (reset == 1'b1) begin
			for (i=0; i<32; i=i+1) begin
				register[i] <= 32'h00000000;
			end
		end
		else begin
			if (A3 != 5'b00000)begin
				register[A3] <= WD;
				$display("$%d <= %h", A3, WD);
			end
			else begin
			end
		end
	 end

endmodule
