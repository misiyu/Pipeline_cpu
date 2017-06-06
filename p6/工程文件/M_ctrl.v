`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:16:43 12/06/2015 
// Design Name: 
// Module Name:    M_ctrl 
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
module M_ctrl(
    ins_M,MemWrite,BE_Op
    );
	input[31:0] ins_M;
	output reg MemWrite;
	output reg [1:0] BE_Op;
	initial begin
		MemWrite=0;
		BE_Op=0;
	end
	always@(*)
	begin
		MemWrite=0;
		BE_Op=0;
		case(ins_M[31:26])
			6'b101011: //sw
			begin
				MemWrite=1;
				BE_Op=0;
			end
			6'b101000: //sb
			begin
				MemWrite=1;
				BE_Op=1;
			end
			6'b101001: //sh
			begin
				MemWrite=1;
				BE_Op=2;
			end
			6'b100011:	//lw
				BE_Op=0;
			6'b100000:	//lb
				BE_Op=1;
			6'b100100:	//lbu
				BE_Op=1;
			6'b100001:	//lh
				BE_Op=2;
			6'b100101:	//lhu
				BE_Op=2;
		endcase
	end

endmodule