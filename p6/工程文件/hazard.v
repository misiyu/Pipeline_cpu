`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:14:29 12/06/2015 
// Design Name: 
// Module Name:    hazard 
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
module hazard(
   ins_D,ins_E,ins_M,ins_W,RData2_M,RData2_W,Busy_E,
	ForwardAE,ForwardBE,ForwardAD,ForwardBD,nop,mul_busy
    );
	input[31:0] ins_D,ins_E,ins_M,ins_W,RData2_M,RData2_W;
	input Busy_E;
	output [1:0]  ForwardAE,ForwardBE;
	output ForwardAD,ForwardBD;
	output  nop,mul_busy;
	transfer transfer(.ins_D(ins_D),
							.ins_E(ins_E),
							.ins_M(ins_M),
							.ins_W(ins_W),
							.RData2_M(RData2_M),
							.RData2_W(RData2_W),
							.ForwardAE(ForwardAE),
							.ForwardBE(ForwardBE),
							.ForwardAD(ForwardAD),
							.ForwardBD(ForwardBD)
							);
	stop stop(.ins_D(ins_D),
					.ins_E(ins_E),
					.ins_M(ins_M),
					.Busy_E(Busy_E),
					.nop(nop),
					.mul_busy(mul_busy)
					);
endmodule
