`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:43:20 12/06/2015 
// Design Name: 
// Module Name:    RM_ext 
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
module RM_ext(
	A,Din,Op,DOut
    );
	input[1:0] A;
	input[2:0] Op;
	input[31:0] Din;
	output reg[31:0] DOut;
	always@(*)
	begin
		DOut=0;
		if(Op==0)
			DOut=Din;
		else if(Op==1||Op==2)
		begin
			if(A==0)
				DOut[7:0]=Din[7:0];
			else if(A==1)
				DOut[7:0]=Din[15:8];
			else if(A==2)
				DOut[7:0]=Din[23:16];
			else if(A==3)
				DOut[7:0]=Din[31:24];
			if(Op==2)
			begin
				if(DOut[7]==1)
					DOut={24'hffffff,DOut[7:0]};
			end
		end
		else if(Op==3||Op==4)
		begin
			if(A==0)
				DOut[15:0]=Din[15:0];
			else if(A==2)
				DOut[15:0]=Din[31:16];
			if(Op==4)
			begin
				if(DOut[15]==1)
					DOut={16'hffff,DOut[15:0]};
			end
		end
	end
endmodule
