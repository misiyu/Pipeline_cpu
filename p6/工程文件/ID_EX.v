`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:43:37 12/06/2015 
// Design Name: 
// Module Name:    ID_EX 
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
module ID_EX(clk,rst,en,ins_D,pc_D,ins_E,pc_E,RData1_D,RData2_D,imm_D,RData1_E,RData2_E,imm_E
    );
	input clk,rst,en;
	input[31:0]       ins_D,pc_D,RData1_D,RData2_D,imm_D;
	output reg [31:0] ins_E,pc_E,RData1_E,RData2_E,imm_E;
	initial begin
	ins_E=0;
	pc_E=0;
	RData1_E=0;
	RData2_E=0;
	imm_E=0;
	end
	always @(posedge clk)
	begin
		if(rst)
		begin
			ins_E <=0;
			pc_E <=0;
			RData1_E <=0;
			RData2_E <=0;
			imm_E <=0;
		end
		else if(!en)
		begin
			ins_E <=ins_D;
			pc_E <=pc_D;
			pc_E <=pc_D+4;
			RData1_E <=RData1_D;
			RData2_E <=RData2_D;
			imm_E <=imm_D;
		end
	end

endmodule
