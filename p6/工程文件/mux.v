`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:18:43 11/22/2015 
// Design Name: 
// Module Name:    mux 
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
module mux_2_5b(
	input[4:0] in0,
	input[4:0] in1,
	input choose,
	output reg[4:0] out
    );
	 always@(*)
	 begin
		out=in0;
		if(choose)
			out=in1;
	 end
endmodule

module mux_2_32b(
	input[31:0] in0,
	input[31:0] in1,
	input choose,
	output reg[31:0] out
    );
	 always@(*)
	 begin
		out=in0;
		if(choose)
			out=in1;
	 end
endmodule

module mux_3_32b(
	input[31:0] in0,
	input[31:0] in1,
	input[31:0] in2,
	input [1:0] choose,
	output reg[31:0] out
    );
	 always@(*)
	 begin
		out=in0;
		if(choose==2'b01)
			out=in1;
		else if(choose==2'b10)
			out=in2;
	 end
endmodule

