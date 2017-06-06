`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:35:36 12/06/2015 
// Design Name: 
// Module Name:    ins_addr 
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
module ins_addr(
	pc_F,addr
    );
	input[31:0] pc_F;
	output [10:0] addr;
	assign addr={0,pc_F[11:2]}+1;

endmodule
