`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:17:21 11/14/2022 
// Design Name: 
// Module Name:    MulDivUnit 
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
module MulUnit(
	 input clock,
	 input reset,
    input [31:0] in_src0,
	 input [31:0] in_src1,
    input [1:0] in_op,
    input in_sign,
    output in_ready,
    input in_valid,
    input out_ready,
    output out_valid,
    output [31:0] out_res0,
	 output [31:0] out_res1
    );
	 reg done;
	 reg[63:0] tmp;
	 wire signed[63:0] sr = $signed(in_src0) * $signed(in_src1);
	 wire[63:0] usr = in_src0 * in_src1;
	 always@(posedge clock) begin
		if(reset) begin
			done <= 'h0;
			tmp <= 'h0;
		end else if(in_valid & in_ready & (in_op == 'd1)) begin
			tmp <= in_sign ? sr : usr;
			done <= 'h1;
		end else if(out_valid & out_ready) begin
			tmp <= 'h0;
			done <= 'h0;
		end
	 end
	 assign {out_res1, out_res0, in_ready, out_valid} = {tmp, !done, done};

endmodule

module DivUnit(
	 input clock,
	 input reset,
    input [31:0] in_src0,
	 input [31:0] in_src1,
    input [1:0] in_op,
    input in_sign,
    output in_ready,
    input in_valid,
    input out_ready,
    output out_valid,
    output [31:0] out_res0,
	 output [31:0] out_res1
    );
	 wire negSrcBits[1:0];
	 assign {negSrcBits[1], negSrcBits[0]} = {in_src1[31] & in_sign, in_src0[31] & in_sign};
	 wire[31:0] absSrc[1:0];
	 assign {absSrc[1], absSrc[0]} = {negSrcBits[1] ? -in_src1 : in_src1, negSrcBits[0] ? -in_src0 : in_src0};
	 wire[63:0] absSrc64[1:0];
	 assign {absSrc64[1], absSrc64[0]} = {absSrc[1], 64'h0, absSrc[0]};
	 reg busy;
	 reg[31:0] timer;
	 reg[66:0] tmps[3:0];
	 reg negResBits[1:0];
	 wire[66:0] subs[2:0];
	 assign {subs[2], subs[1], subs[0]} = {(tmps[0] << 2) - tmps[3], (tmps[0] << 2) - tmps[2], (tmps[0] << 2) - tmps[1]};
	 wire[31:0] tmp[1:0];
	 assign {tmp[1], tmp[0]} = tmps[0][63:0];
	 assign {out_res1, out_res0} = {negResBits[1] ? -tmp[1] : tmp[1], negResBits[0] ? -tmp[0] : tmp[0]};
	 assign {in_ready, out_valid} = {!busy, !timer[1] & busy};
	 always@(posedge clock) begin
		if(reset) begin
			{negResBits[1], negResBits[0], timer, tmps[3], tmps[2], tmps[1], tmps[0], busy} <= 0;
		end else if(in_valid & in_ready & in_op == 'd2) begin
			timer <= 32'hffffffff;
			{negResBits[1], negResBits[0]} <= {negSrcBits[0], negSrcBits[0] ^ negSrcBits[1]};
			{tmps[3], tmps[2], tmps[1], tmps[0]} <= {({3'b0, absSrc64[1]} << 1) + {3'b0, absSrc64[1]}, {3'b0, absSrc64[1]} << 1, {3'b0, absSrc64[1]}, {3'b0, absSrc64[0]}};
			busy <= 'b1;
		end else begin
			if(out_valid & out_ready) begin
				busy <= 'b0;
			end
			if(timer[15] & (tmps[0][47:16] < tmps[1][63:32])) begin
				timer <= timer >> 16;
				tmps[0] <= tmps[0] << 16;
			end else if(timer[7] & (tmps[0][55:24] < tmps[1][63:32])) begin
				timer <= timer >> 8;
				tmps[0] <= tmps[0] << 8;
			end else if(timer[3] & (tmps[0][59:28] < tmps[1][63:32])) begin
				timer <= timer >> 4;
				tmps[0] <= tmps[0] << 4;
			end else if(timer[0]) begin
				timer <= timer >> 2;
				tmps[0] <= !subs[2][66] ? subs[2] + 'd3 : !subs[1][66] ? subs[1] + 'd2 : !subs[0][66] ? subs[0] + 'd1 : (tmps[0] << 2);
			end
		end
	 end
endmodule

module MulDivUnit(
	 input clock,
	 input reset,
    input [31:0] in_src0,
	 input [31:0] in_src1,
    input [1:0] in_op,
    input in_sign,
    output in_ready,
    input in_valid,
    input out_ready,
    output out_valid,
    output [31:0] out_res0,
	 output [31:0] out_res1
    );
	 wire[31:0] mul_out_res[1:0];
	 wire[31:0] div_out_res[1:0];
	 reg[1:0] op;
	 always@(posedge clock) begin
		if(reset) begin
			op  <= 'h0;
		end else if(in_ready & in_valid) begin
			op <= in_op;
		end else if(out_ready & out_valid) begin
			op <= 'h0;
		end
	 end
	 MulUnit MulUnit(
			.clock(clock), 
			.reset(reset), 
			.in_src0(in_src0),
			.in_src1(in_src1),
			.in_op(in_op), 
			.in_sign(in_sign), 
			.in_ready(mul_in_ready), 
			.in_valid(in_valid), 
			.out_ready(out_ready), 
			.out_valid(mul_out_valid), 
			.out_res0(mul_out_res[0]),
			.out_res1(mul_out_res[1]));
			
	 DivUnit DivUnit(
			.clock(clock), 
			.reset(reset), 
			.in_src0(in_src0),
			.in_src1(in_src1),
			.in_op(in_op), 
			.in_sign(in_sign), 
			.in_ready(div_in_ready), 
			.in_valid(in_valid), 
			.out_ready(out_ready), 
			.out_valid(div_out_valid), 
			.out_res0(div_out_res[0]),
			.out_res1(div_out_res[1]));
	 assign in_ready = mul_in_ready & div_in_ready;
	 assign out_valid = mul_out_valid | div_out_valid;
	 assign {out_res1, out_res0} = (op == 'd2) ? {div_out_res[1], div_out_res[0]} : {mul_out_res[1], mul_out_res[0]};
endmodule
