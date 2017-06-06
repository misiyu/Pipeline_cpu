`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:27:02 11/22/2015 
// Design Name: 
// Module Name:    EX_MEM 
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
module EX_MEM(clk,rst,en,ins_E,pc_E,RData2_E,alu_Result_E,HI_E,LO_E,ins_M,pc_M,RData2_M,alu_Result_M
    );
	input clk,rst,en;
	input[31:0] ins_E,pc_E,RData2_E,alu_Result_E,HI_E,LO_E;
	output reg[31:0] ins_M,pc_M,RData2_M,alu_Result_M;
	initial begin
	ins_M=0;
	pc_M=0;
	RData2_M=0;
	alu_Result_M=0;
	end
	always @(posedge clk)
	begin
		if(rst)
		begin
			ins_M <=0;
			pc_M <=0;
			RData2_M <=0;
			alu_Result_M <=0;
		end
		else if(!en)
		begin
			ins_M <=ins_E;
			pc_M <=pc_E;
			RData2_M <=RData2_E;			//RData2_E;实际传入值为ALU_Btemp
			alu_Result_M <=alu_Result_E;
			if(ins_E[31:26]==6'b000011)		//jal
				alu_Result_M<=pc_E;
			else if(ins_E[31:26]==0)
			begin
				if(ins_E[5:0]==6'b001001)		//jalr
					alu_Result_M<=pc_E;
				else if(ins_E[5:0]==6'b010000)		//mfhi
					alu_Result_M<=HI_E;
				else if(ins_E[5:0]==6'b010010)		//mflo
					alu_Result_M<=LO_E;
			end
		end
	end


endmodule
