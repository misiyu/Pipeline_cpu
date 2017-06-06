`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:39:00 12/01/2015 
// Design Name: 
// Module Name:    gpr 
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
module gpr(
	Clk,Rst,A1,A2,A3,
	We,WD,RD1,RD2
    );
	input Clk,Rst,We;
	input[4:0]  A1,A2,A3;
	input[31:0] WD;
	output [31:0] RD1,RD2;
	reg[31:0] _reg[31:0];
	integer i;
	always@(posedge Clk or posedge Rst)
	begin
		_reg[0]=0;
	   if(Rst)
			for(i=0;i<32;i=i+1)
				_reg[i]=0;
		if(We)
			_reg[A3]=WD;
	end
	assign RD1=(A3==A1&&We)?WD:_reg[A1];
	assign RD2=(A3==A2&&We)?WD:_reg[A2];
	
endmodule
