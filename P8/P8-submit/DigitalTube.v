`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:56:42 12/27/2021 
// Design Name: 
// Module Name:    DigitalTube 
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
module DigitalTube(
    input clk,
    input reset,
    input [31:0] Addr,
    input WE,
    input [3:0] byteen,
    input [31:0] WD,
    output reg [7:0] digital_tube0,
    output reg [7:0] digital_tube1,
    output [7:0] digital_tube2,
    output reg [3:0] digital_tube_sel0,
    output reg [3:0] digital_tube_sel1,
    output digital_tube_sel2,
	 output [31:0] O
    );
	 reg [31:0] num, sign, cnt;
	 reg [3:0] tube0, tube1;
	 reg [1:0] pos;
	 assign O = (Addr[2] == 1'b1) ? num : sign;
	 
	 always@(posedge clk) begin
		if (reset) begin
			sign <= 32'b0;
			num <= 32'b0;
			tube0 <= 4'b0;
			tube1 <= 4'b0;
			digital_tube_sel0 <= 4'b0;
			digital_tube_sel1 <= 4'b0;
			cnt <= 32'b0;
			pos <= 2'b0;
		end
		else begin
			if (WE) begin
				case(Addr[2])
					1'b1: begin
						if (byteen[0]) num[7:0] <= WD[7:0];
						if (byteen[1]) num[15:8] <= WD[15:8];
						if (byteen[2]) num[23:16] <= WD[23:16];
						if (byteen[3]) num[31:24] <= WD[31:24];
					end
					1'b0: begin
						if (byteen[0]) sign[7:0] <= WD[7:0];
						if (byteen[1]) sign[15:8] <= WD[15:8];
						if (byteen[2]) sign[23:16] <= WD[23:16];
						if (byteen[3]) sign[31:24] <= WD[31:24];
					end
				endcase
			end
			else begin
			end
			cnt <= cnt + 1;
			//if (cnt == 32'd50) begin
			if (cnt == 32'd500000) begin
				cnt <= 32'd0;
				digital_tube_sel0[pos - 2'b01] <= 1'b0;
				digital_tube_sel0[pos] <= 1'b1;
				case(pos)
					2'b00: tube1 <= num[19:16];
					2'b01: tube1 <= num[23:20];
					2'b10: tube1 <= num[27:24];
					2'b11: tube1 <= num[31:28];
				endcase
				digital_tube_sel1[pos - 2'b01] <= 1'b0;
				digital_tube_sel1[pos] <= 1'b1;
				case(pos)
					2'b00: tube0 <= num[3:0];
					2'b01: tube0 <= num[7:4];
					2'b10: tube0 <= num[11:8];
					2'b11: tube0 <= num[15:12];
				endcase
				pos <= pos + 1;
			end
			else begin
			end
		end
	 end
	 
	 assign digital_tube_sel2 = 1'b1;
	 assign digital_tube2 = 8'b11111111;
	 always@(*) begin
		case(tube1)
			4'd0:  digital_tube1 = 8'b10000001;
			4'd1:  digital_tube1 = 8'b11001111;
			4'd2:  digital_tube1 = 8'b10010010;
			4'd3:  digital_tube1 = 8'b10000110;
			4'd4:  digital_tube1 = 8'b11001100;
			4'd5:  digital_tube1 = 8'b10100100;
			4'd6:  digital_tube1 = 8'b10100000;
			4'd7:  digital_tube1 = 8'b10001111;
			4'd8:  digital_tube1 = 8'b10000000;
			4'd9:  digital_tube1 = 8'b10000100;
			4'd10: digital_tube1 = 8'b10001000;
			4'd11: digital_tube1 = 8'b11100000;
			4'd12: digital_tube1 = 8'b10110001;
			4'd13: digital_tube1 = 8'b11000010;
			4'd14: digital_tube1 = 8'b10110000;
			4'd15: digital_tube1 = 8'b10111000;
			default: digital_tube1 = 8'b11111111;
		endcase
	 end
	 always@(*) begin
		case(tube0)
			4'd0:  digital_tube0 = 8'b10000001;
			4'd1:  digital_tube0 = 8'b11001111;
			4'd2:  digital_tube0 = 8'b10010010;
			4'd3:  digital_tube0 = 8'b10000110;
			4'd4:  digital_tube0 = 8'b11001100;
			4'd5:  digital_tube0 = 8'b10100100;
			4'd6:  digital_tube0 = 8'b10100000;
			4'd7:  digital_tube0 = 8'b10001111;
			4'd8:  digital_tube0 = 8'b10000000;
			4'd9:  digital_tube0 = 8'b10000100;
			4'd10: digital_tube0 = 8'b10001000;
			4'd11: digital_tube0 = 8'b11100000;
			4'd12: digital_tube0 = 8'b10110001;
			4'd13: digital_tube0 = 8'b11000010;
			4'd14: digital_tube0 = 8'b10110000;
			4'd15: digital_tube0 = 8'b10111000;
			default: digital_tube0 = 8'b11111111;
		endcase
	 end
	 

endmodule
