`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:40:20 12/12/2021 
// Design Name: 
// Module Name:    Bridge 
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
module Bridge(
    input [31:0] PrAddr,
    input [31:0] PrWD,
    input PrWE,
	 input [31:0] DMRD,
    input [31:0] DEV0RD,
    input [31:0] DEV1RD,
	 input [31:0] DEV2RD,
	 input [31:0] DEV3RD,
	 input [31:0] DEV4RD,
	 input [31:0] DEV5RD,
    output reg [31:0] PrRD,
    output [31:0] DEVAddr,
    output [31:0] DEVWD,
	 output DMWE,
	 output DEV0WE,
	 output DEV1WE,
	 output DEV2WE,
	 output DEV3WE,
	 output DEV4WE,
	 output DEV5WE
    );
	 always@(*) begin
		if (PrAddr >= 32'h00000000 && PrAddr <= 32'h00002fff) begin
			PrRD = DMRD;
		end
		else if (PrAddr >= 32'h00007f00 && PrAddr <= 32'h00007f0b) begin
			PrRD = DEV0RD;
		end
		else if (PrAddr >= 32'h00007f20 && PrAddr <= 32'h00007f3b) begin
			PrRD = DEV1RD;
		end
		else if (PrAddr >= 32'h00007f40 && PrAddr <= 32'h00007f47) begin
			PrRD = DEV2RD;
		end
		else if (PrAddr >= 32'h00007f50 && PrAddr <= 32'h00007f57) begin
			PrRD = DEV3RD;
		end
		else if (PrAddr >= 32'h00007f58 && PrAddr <= 32'h00007f5b) begin
			PrRD = DEV4RD;
		end
		else if (PrAddr >= 32'h00007f60 && PrAddr <= 32'h00007f63) begin
			PrRD = DEV5RD;
		end
		else begin
			PrRD = 32'h00000000;
		end
	 end
	 assign DEVAddr = PrAddr;
	 assign DEVWD = PrWD;
	 assign DMWE = (PrWE && PrAddr >= 32'h00000000 && PrAddr <= 32'h00002fff) ? 1 : 0;
	 assign DEV0WE = (PrWE && PrAddr >= 32'h00007f00 && PrAddr <= 32'h00007f0b) ? 1 : 0;
	 assign DEV1WE = (PrWE && PrAddr >= 32'h00007f20 && PrAddr <= 32'h00007f3b) ? 1 : 0;
	 assign DEV2WE = (PrWE && PrAddr >= 32'h00007f40 && PrAddr <= 32'h00007f47) ? 1 : 0;
	 assign DEV3WE = (PrWE && PrAddr >= 32'h00007f50 && PrAddr <= 32'h00007f57) ? 1 : 0;
	 assign DEV4WE = (PrWE && PrAddr >= 32'h00007f58 && PrAddr <= 32'h00007f5b) ? 1 : 0;
	 assign DEV5WE = (PrWE && PrAddr >= 32'h00007f60 && PrAddr <= 32'h00007f63) ? 1 : 0;



endmodule
