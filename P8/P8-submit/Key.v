`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:38:55 12/27/2021 
// Design Name: 
// Module Name:    Key 
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
module Key(
    input [7:0] KeyIn,
    output [31:0] O
    );
	 
	 assign O = {24'b0, ~KeyIn};


endmodule
