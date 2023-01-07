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
	module mips (
    // clock and reset
    input clk_in,
    input sys_rstn,
    // dip switch
    input [7:0] dip_switch0,
    input [7:0] dip_switch1,
    input [7:0] dip_switch2,
    input [7:0] dip_switch3,
    input [7:0] dip_switch4,
    input [7:0] dip_switch5,
    input [7:0] dip_switch6,
    input [7:0] dip_switch7,
    // key
    input [7:0] user_key,
    // led
    output [31:0] led_light,
    // digital tube
    output [7:0] digital_tube2,
    output digital_tube_sel2,
    output [7:0] digital_tube1,
    output [3:0] digital_tube_sel1,
    output [7:0] digital_tube0,
    output [3:0] digital_tube_sel0,
    // uart
    input uart_rxd,
    output uart_txd
	 );


	 
	 //out from CLK
	 wire CLK_OUT1, CLK_OUT2, LOCKED;
	 //out from CPU
	 wire PrWE, TBReq;
	 wire [3:0] byteen;
	 wire [31:0] addr, i_inst_addr, m_data_wdata;
	 //out from IM
	 wire [31:0] i_inst_rdata;
	 //out from Bridge
	 wire DMWE, DEV0WE, DEV1WE, DEV2WE, DEV3WE, DEV4WE, DEV5WE;
	 wire [31:0] PrRD, DEVAddr, DEVWD;
	 //out from DM
	 wire [31:0] m_data_rdata;
	 //out from Timer
	 wire IRQ;
	 wire [31:0] DEV0RD;
	 // out from MiniUART
	 wire Interrupt, ACK_O;
	 wire [31:0] DEV1RD;
	 // out from DigitalTube
	 wire [31:0] DEV2RD;
	 // out from DipSwitch
	 wire [31:0] DEV3RD;
	 // out from Key
	 wire [31:0] DEV4RD;
	 // out from LED
	 wire [31:0] DEV5RD;
	 
	
	 CLK clk(
		//input
		.CLK_IN1(clk_in),
		//output
		.CLK_OUT1(CLK_OUT1),
		.CLK_OUT2(CLK_OUT2),
		.LOCKED(LOCKED)
	 );
	 
	 
	 CPU cpu(
		// input
		.reset(!LOCKED || !sys_rstn),
		.clk(CLK_OUT1),
		.i_inst_rdata(i_inst_rdata),
		.m_data_rdata(PrRD),
		.HWInt({3'b0, Interrupt, 1'b0, IRQ}),
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
	 
	 wire [31:0] instrAddr;
	 assign instrAddr = i_inst_addr - 32'h00003000;
	 IM im(
		// input
		.clka(CLK_OUT2),
		.addra(instrAddr[14:2]),
		.wea(4'b0),
		.dina(32'b0),
		// output
		.douta(i_inst_rdata)
	 );
	 
	 
	 Bridge bridge(
		// input
		.PrAddr(addr),
		.PrWD(m_data_wdata),
		.PrWE(PrWE),
		.DMRD(m_data_rdata),
		.DEV0RD(DEV0RD),
		.DEV1RD(DEV1RD),
		.DEV2RD(DEV2RD),
		.DEV3RD(DEV3RD),
		.DEV4RD(DEV4RD),
		.DEV5RD(DEV5RD),
		// output
		.PrRD(PrRD),
		.DEVAddr(DEVAddr),
		.DEVWD(DEVWD),
		.DMWE(DMWE),
		.DEV0WE(DEV0WE),
		.DEV1WE(DEV1WE),
		.DEV2WE(DEV2WE),
		.DEV3WE(DEV3WE),
		.DEV4WE(DEV4WE),
		.DEV5WE(DEV5WE)
	 );
	 
	 DM dm(
		// input
		.clka(CLK_OUT2),
		.wea({byteen[0] & DMWE, byteen[1] & DMWE, byteen[2] & DMWE, byteen[3] & DMWE}),
		.addra(DEVAddr),
		.dina(DEVWD),
		// output
		.douta(m_data_rdata)
	 );
	 
	 TC Timer(
		// input
		.clk(CLK_OUT1),
		.reset(!LOCKED || !sys_rstn),
		.Addr(DEVAddr[31:2]),
		.WE(DEV0WE),
		.Din(DEVWD),
		// output
		.Dout(DEV0RD),
		.IRQ(IRQ)
	 );
	 
	 MiniUART miniuart(
		// input
		.CLK_I(CLK_OUT1),
		.DAT_I(DEVWD),
		.RST_I(!LOCKED || !sys_rstn),
		.ADD_I(DEVAddr[4:2]),
		.STB_I(1'b1),
		.WE_I(DEV1WE),
		.RxD(uart_rxd),
		// output
		.DAT_O(DEV1RD),
		.ACK_O(ACK_O),
		.TxD(uart_txd),
		.Interrupt(Interrupt)
	 );
	 
	 always@(*) begin
		if (DEV1WE && (DEVAddr == 32'h7f20)) begin
			$display("*%h <= %h", DEVAddr, DEVWD);
		end
	 end
	 
	 DigitalTube digitaltube(
		// input
		.clk(CLK_OUT1),
		.reset(!LOCKED || !sys_rstn),
		.Addr(DEVAddr),
		.WE(DEV2WE),
		.byteen(byteen),
		.WD(DEVWD),
		// output
		.digital_tube0(digital_tube0),
		.digital_tube1(digital_tube1),
		.digital_tube2(digital_tube2),
		.digital_tube_sel0(digital_tube_sel0),
		.digital_tube_sel1(digital_tube_sel1),
		.digital_tube_sel2(digital_tube_sel2),
		.O(DEV2RD)
	 );
	 
	 
	 DipSwitch dipswitch(
		// input
		.Addr(DEVAddr),
		.In0(dip_switch0),
		.In1(dip_switch1),
		.In2(dip_switch2),
		.In3(dip_switch3),
		.In4(dip_switch4),
		.In5(dip_switch5),
		.In6(dip_switch6),
		.In7(dip_switch7),
		// output
		.O(DEV3RD)
	 );
	 
	 Key key(
		// input
		.KeyIn(user_key),
		// output
		.O(DEV4RD)
	 );
	 
	 LED led(
		// input
		.clk(CLK_OUT1),
		.reset(!LOCKED || !sys_rstn),
		.WE(DEV5WE),
		.byteen(byteen),
		.WD(DEVWD),
		// output
		.O(DEV5RD),
		.LEDLight(led_light)
	 );
	 
	 

endmodule
