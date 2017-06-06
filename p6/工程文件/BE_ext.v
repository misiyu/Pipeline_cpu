`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:14:18 12/06/2015 
// Design Name: 
// Module Name:    BE_ext 
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
module BE_ext(
	A,Op,BE_M
    );
	input[1:0] Op;
	input[1:0] A;
	output reg[3:0] BE_M;
	//initial BE_M=4'b1111;
	always@(*)
	begin
	if(Op==0)
		BE_M=4'b1111;
	else if(Op==1)	//×Ö½Ú
	begin
		if(A==0)
			BE_M=4'b0001;
		else if(A==1)
			BE_M=4'b0010;
		else if(A==2)
			BE_M=4'b0100;
		else if(A==3)
			BE_M=4'b1000;
	end
	else if(Op==2)		//°ë×Ö
	begin
		if(A==0)
			BE_M=4'b0011;
		else if(A==2)
			BE_M=4'b1100;
	end
	end
endmodule
