`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:23:33 12/27/2021 
// Design Name: 
// Module Name:    DipSwitch 
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
module DipSwitch(
    input [31:0] Addr,
    input [7:0] In0,
    input [7:0] In1,
    input [7:0] In2,
    input [7:0] In3,
    input [7:0] In4,
    input [7:0] In5,
    input [7:0] In6,
    input [7:0] In7,
    output [31:0] O
    );
	 //assign O = (Addr[2]) ? ~{In7, In6, In5, In4} : ~{In3, In2, In1, In0};
	 assign O = (Addr[2]) ? ~{In3, In2, In1, In0} : ~{In7, In6, In5, In4};
endmodule
