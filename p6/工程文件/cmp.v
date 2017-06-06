`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:37:13 12/01/2015 
// Design Name: 
// Module Name:    cmp 
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
module cmp(
	A,B,Op,Br
    );
	input signed[31:0] A,B;
	input [2:0] Op;
	output reg Br;
	initial	Br=0;
		
	always@(*)
	begin
	Br=0;
	case(Op)
	0: Br=(A-B==0)?1:0;
	1: Br=(A-B!=0)?1:0;
	2: Br=(A<0)?1:0;
	3: Br=(A<=0)?1:0;
	4: Br=(A>0)?1:0;
	5: Br=(A>=0)?1:0;
	6: Br=1;
	endcase
	end
endmodule
