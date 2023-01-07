`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:47:38 12/06/2021 
// Design Name: 
// Module Name:    PC 
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
module PC(
    input [31:0] NPC,
    input clk,
    input reset,
    input Stall,
	 input Req,
    output reg [31:0] PC
    );
	 
	 always@(posedge clk) begin
		if (reset == 1'b1) begin
			PC <= 32'h00003000;
		end
		else if (Stall == 1'b0 || Req) begin
			PC <= (Req) ? 32'h00004180 : NPC;
		end
		else begin
		end
	 end
endmodule
