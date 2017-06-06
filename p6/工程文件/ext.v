`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:04:59 11/22/2015 
// Design Name: 
// Module Name:    ext 
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
module ext(imm_in,extOp,imm_D
    );
	input[15:0] imm_in;
	input extOp;
	output reg[31:0] imm_D;
	always@(*)
	begin
		if(extOp)
			imm_D={16'h0000,imm_in};
		else
		begin
			if(imm_in[15]==0)
				imm_D={16'h0000,imm_in};
			else
				imm_D={16'hffff,imm_in};
		end
	end
endmodule
