`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:39:20 12/02/2015 
// Design Name: 
// Module Name:    npc 
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
module npc(PC,imm_D,RData1_D,j,jr,branch,ins_D,npc
    );
	input[31:0] PC,imm_D,RData1_D;
	input j,branch,jr;
	input[31:0] ins_D;
	output [31:0] npc;
	assign npc=j?{6'b00000000,ins_D[25:0]<<2}:
				  jr?RData1_D:
				  (branch&&!j&&!jr)?(PC+(imm_D<<2)):
				  PC;
	
endmodule
