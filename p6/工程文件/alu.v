`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:25:53 12/01/2015 
// Design Name: 
// Module Name:    alu 
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
module alu(
	A,B,Op,C,Over
    );
	input[31:0] A,B;
	input[4:0] Op;
	output reg[31:0] C;
	output reg Over;
	reg [32:0] temp;
	integer i;
	always@(*)
	begin
	Over=0;
	case(Op)
	0: C=A+B;      //addu
	1: C=A-B;		//subu
	2: C=A|B;		//or
	3: C=B<<16;		//lui
	4:	C=A&B;		//and
	5: C=B<<A[4:0];		//sll
	6: C=B>>A[4:0];		//srl
	7:	C=A^B;		//xor
	8:	C=~(A|B);	//nor
	9: C=(A<B)?1:0;  //sltu
	10: C=($signed(A)<$signed(B))?1:0;		//slt
	11: 						//sra
	begin
		C=B>>A[4:0];
		if(B[31]==1)
			for(i=31;i>=0;i=i-1)
			begin
			if(C[i]==0)
				C[i]=1;
			else
				i=-1;
			end
	end
	12:
	begin
		C=A+B;      //add
		temp={A[31],A}+{B[31],B};
		if(temp[32]!=temp[31])
			Over=1;
	end
	13:
	begin
		C=A-B;
		temp={A[31],A}-{B[31],B};
		if(temp[32]!=temp[31])
			Over=1;
	end
	endcase
	end
endmodule
