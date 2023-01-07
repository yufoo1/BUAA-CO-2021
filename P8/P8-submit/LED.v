`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:52:55 12/27/2021 
// Design Name: 
// Module Name:    LED 
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
module LED(
    input clk,
    input reset,
    input WE,
    input [3:0] byteen,
    input [31:0] WD,
    output [31:0] O,
    output [31:0] LEDLight
    );
	 
	 reg [31:0] Light;
	 always@(posedge clk) begin
		if (reset) begin
			Light <= 32'b0;
		end
		else begin
			if (byteen[0]) Light[7:0] <= WD[7:0];
			if (byteen[0]) Light[15:8] <= WD[15:8];
			if (byteen[0]) Light[23:16] <= WD[23:16];
			if (byteen[0]) Light[31:24] <= WD[31:24];
		end
	 end
	 assign LEDLight = ~Light;
	 assign O = Light;
	

endmodule
