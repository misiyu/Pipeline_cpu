`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:33:41 12/06/2015 
// Design Name: 
// Module Name:    IF_ID 
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
module IF_ID(clk,rst,en,ins_F,pc_F,ins_D,pc_D
    );
	input clk,rst,en;
	input[31:0] ins_F,pc_F;
	output reg[31:0] ins_D,pc_D;
	initial begin
	ins_D=0;
	pc_D=0;
	end
	always @(posedge clk)
	begin
		if(rst)
		begin
			ins_D<=0;
			pc_D<=0;
		end
		else if(!en)
		begin
			ins_D<=ins_F;
			pc_D<=pc_F+4;
		end
	end

endmodule