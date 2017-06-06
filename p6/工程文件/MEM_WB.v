`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:54:55 11/22/2015 
// Design Name: 
// Module Name:    MEM_WB 
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
module MEM_WB(
clk,rst,en,ins_M,pc_M,alu_Result_M,DMRData_M,RData2_M,
ins_W,pc_W,alu_Result_W,DMRData_W,RData2_W
    );
	input clk,rst,en;
	input[31:0] ins_M,pc_M,alu_Result_M,DMRData_M,RData2_M;
	output reg[31:0] ins_W,pc_W,alu_Result_W,DMRData_W,RData2_W;
	initial begin
	ins_W=0;
	pc_W=0;
	alu_Result_W=0;
	DMRData_W=0;
	RData2_W=0;
	end
	always @(posedge clk)
	begin
		if(rst)
		begin
			ins_W <=0;
			pc_W <=0;
			alu_Result_W <=0;
			DMRData_W <=0;
			RData2_W=0;
		end
		else if(!en)
		begin
			ins_W <=ins_M;
			pc_W <=pc_M;
			alu_Result_W <=alu_Result_M;
			DMRData_W <=DMRData_M;
			RData2_W<=RData2_M;
		end
	end

endmodule
