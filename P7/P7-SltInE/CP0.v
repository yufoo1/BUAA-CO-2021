`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:43:00 12/12/2021 
// Design Name: 
// Module Name:    CP0 
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
`define SRAddr    12
`define CauseAddr 13
`define EPCAddr   14
`define PRIdAddr  15

`define IM        SR[15:10]
`define EXL       SR[1]
`define IE        SR[0]
`define IP        Cause[15:10]
`define ExcCode   Cause[6:2]
`define BD        Cause[31]


	module CP0(
	 input clk,
    input reset,
    input WE,
	 input [4:0] A,
    input [31:0] DIn,
    input [31:0] PC,
    input [6:2] ExcCodeIn,
	 input BDIn,
    input [5:0] HWInt,
    input EXLClr,
    output Req,
    output reg [31:0] EPC,
    output reg [31:0] DOut,
	 output TBReq
    );
	 
	 reg [31:0] SR, Cause, PRId;
	 wire IntReq, ExcReq;
	 assign IntReq = (|(HWInt & `IM)) & `IE & !`EXL;
	 assign ExcReq = (|ExcCodeIn) & !`EXL;
	 assign Req = IntReq | ExcReq;
	 assign TBReq = HWInt[2] & SR[12] & `IE & !`EXL;
	 initial begin
			SR = 0;
			Cause = 0;
			EPC = 0;
			PRId = "PRId";
	 end
	 always@(posedge clk) begin
		if (reset == 1'b0) begin
			`IP <= HWInt;
		end
		if (reset == 1'b1) begin
			SR <= 0;
			Cause <= 0;
			EPC <= 0;
			PRId <= "PRId";
		end
		else if (Req) begin
			`ExcCode <= (IntReq == 1'b1) ? 5'b00000 : ExcCodeIn;
			`EXL <= 1'b1;
			`BD <= BDIn;
			EPC <= (BDIn == 1'b1) ? PC - 4 : PC;
		end
		else if (WE) begin
			case(A)
				`SRAddr: begin
					`IM <= DIn[15:10];
					`EXL <= DIn[1];
					`IE <= DIn[0];
				end
				`EPCAddr: begin
					EPC <= DIn;
				end
			endcase
		end
		else if (EXLClr) begin
			`EXL <= 1'b0;
		end
		else begin
		end
	 end
	 
	 always@(*) begin
		case(A)
			`SRAddr: begin
				DOut = SR;
			end
			`CauseAddr: begin
				DOut = Cause;
			end
			`EPCAddr: begin
				DOut = EPC;
			end
			`PRIdAddr: begin
				DOut = PRId;
			end
			default: begin
				DOut = 32'h00000000;
			end
		endcase
	 end
endmodule
