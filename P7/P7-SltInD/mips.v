`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:17:56 12/12/2021 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset,
    input interrupt,
    output [31:0] macroscopic_pc,
    output [31:0] i_inst_addr,
    input  [31:0] i_inst_rdata,
    output [31:0] m_data_addr,
    input  [31:0] m_data_rdata,
    output [31:0] m_data_wdata,
    output [3:0] m_data_byteen,
    output [31:0] m_inst_addr,
    output w_grf_we,
    output [4 :0] w_grf_addr,
    output [31:0] w_grf_wdata,
    output [31:0] w_inst_addr
    );
	 reg Req;
	 always@(posedge clk) begin
		Req <= TBReq;
	 end
	 //out from CPU
	 wire PrWE, TBReq;
	 wire [3:0] byteen;
	 wire [31:0] addr;
	 //out from Bridge
	 wire DMWE, DEV0WE, DEV1WE;
	 wire [31:0] PrRD, DEVAddr, DEVWD;
	 //out from Timer0 and Timer1
	 wire IRQ0, IRQ1;
	 wire [31:0] DEV0RD, DEV1RD;
	 
	 
	 assign m_data_byteen = (Req) ? 4'b1 : byteen;
	 assign m_data_addr = (Req) ? 32'h7f20 : addr;
	 
	 CPU cpu(
		// input
		.reset(reset),
		.clk(clk),
		.i_inst_rdata(i_inst_rdata),
		.m_data_rdata(PrRD),
		.HWInt({3'b0, interrupt, IRQ1, IRQ0}),
		// output
		.i_inst_addr(i_inst_addr),
		.m_data_addr(addr),
		.m_data_wdata(m_data_wdata),
		.m_data_byteen(byteen),
		.m_inst_addr(m_inst_addr),
		.w_grf_we(w_grf_we),
	   .w_grf_addr(w_grf_addr),
		.w_grf_wdata(w_grf_wdata),
		.w_inst_addr(w_inst_addr),
		.macroscopic_pc(macroscopic_pc),
		.PrWE(PrWE),
		.TBReq(TBReq)
	 );
	 
	 Bridge bridge(
		// input
		.PrAddr(addr),
		.PrWD(m_data_wdata),
		.PrWE(PrWE),
		.DMRD(m_data_rdata),
		.DEV0RD(DEV0RD),
		.DEV1RD(DEV1RD),
		// output
		.PrRD(PrRD),
		.DEVAddr(DEVAddr),
		.DEVWD(DEVWD),
		.DMWE(DMWE),
		.DEV0WE(DEV0WE),
		.DEV1WE(DEV1WE)
	 );
	 
	 TC Timer0(
		// input
		.clk(clk),
		.reset(reset),
		.Addr(DEVAddr[31:2]),
		.WE(DEV0WE),
		.Din(DEVWD),
		// output
		.Dout(DEV0RD),
		.IRQ(IRQ0)
	 );
	 TC Timer1(
		// input
		.clk(clk),
		.reset(reset),
		.Addr(DEVAddr[31:2]),
		.WE(DEV1WE),
		.Din(DEVWD),
		// output
		.Dout(DEV1RD),
		.IRQ(IRQ1)
	 );

endmodule
