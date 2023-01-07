`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:10:54 11/28/2021 
// Design Name: 
// Module Name:    CMP 
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
`define BEQ 4'b0000
module CMP(
    input [31:0] A1,
    input [31:0] A2,
    input [3:0] CMPType,
    output reg O
    );
	 initial begin
		O = 1'b0;
	 end
	 always@(*) begin
		case (CMPType)
			`BEQ: begin
				if (A1 == A2) begin
					O = 1'b1;
				end
				else begin
					O = 1'b0;
				end
			end
			default: begin
			end
		endcase
	 end

endmodule
