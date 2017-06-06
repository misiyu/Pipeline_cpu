`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:26:09 11/15/2015 
// Design Name: 
// Module Name:    pc 
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
module pc(NPC,clk,rst,en,PCSrcD,PC
    );
	 input[31:0] NPC;
    input clk;
    input rst;
	 input en;
	 input PCSrcD;
	 output reg [31:0] PC;
	always@(posedge clk or posedge rst)
	begin
		if(rst)  PC= 32'h0000_3000;
		else if(!en&&PCSrcD) PC=NPC;
		else if(!en) PC=PC+4;
	end
endmodule