`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:46:47 12/01/2015 
// Design Name: 
// Module Name:    dm 
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
module dm(
	A,BE,WD,RD,We,Clk
    );
	input [10:0] A;
	input [3:0] BE;
	input [31:0] WD;
	input We,Clk;
	output[31:0] RD;
	reg[31:0] dm[2047:0];
	integer i;
	initial
		for(i=0;i<2048;i=i+1)
			dm[i]=0;
	begin
	end
	always@(posedge Clk)
	begin
		if(We)
		case(BE)
		4'b0001:	dm[A][7:0]=WD[7:0];
		4'b0010:	dm[A][15:8]=WD[7:0];
		4'b0100:	dm[A][23:16]=WD[7:0];
		4'b1000:	dm[A][31:24]=WD[7:0];
		4'b0011: dm[A][15:0]=WD[15:0];
		4'b1100: dm[A][31:16]=WD[15:0];
		4'b1111: dm[A]=WD;
		default  dm[A]=0;
		endcase
	end
	assign RD=dm[A];
endmodule
