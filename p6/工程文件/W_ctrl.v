`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:19:55 12/06/2015 
// Design Name: 
// Module Name:    W_ctrl 
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
module W_ctrl(
    ins_W,RData2_W,MemtoReg,RegDst,RegWrite,jal_W,RM_extOp
    );
	input[31:0] ins_W,RData2_W;
	output reg MemtoReg,RegDst,RegWrite,jal_W;
	output reg[2:0] RM_extOp;
	initial begin
	MemtoReg=0;
	RegDst=0;
	RegWrite=0;
	jal_W=0;
	RM_extOp=0;
	end
	always@(*)
	begin
		MemtoReg=0;
		RegDst=0;
		RegWrite=0;
		jal_W=0;
		RM_extOp=0;
		case(ins_W[31:26])
			6'b000000:
			begin
				if(ins_W[5:0]==6'b100001	//addu
					||ins_W[5:0]==6'b100000 //add
					||ins_W[5:0]==6'b100011 //subu
					||ins_W[5:0]==6'b100010 //sub
					||ins_W[5:0]==6'b100101	//or
					||ins_W[5:0]==6'b100100	//and
					||ins_W[5:0]==6'b100110	//xor
					||ins_W[5:0]==6'b100111 //nor
					||ins_W[5:0]==6'b101010 //slt
					||ins_W[5:0]==6'b101011 //sltu
					||(ins_W[5:0]==0&&ins_W!=0) //sll
					||ins_W[5:0]==6'b000100 //sllv
					||ins_W[5:0]==6'b000010 //srl
					||ins_W[5:0]==6'b000110 //srlv
					||ins_W[5:0]==6'b000011 //sra
					||ins_W[5:0]==6'b000111 //srav
					||ins_W[5:0]==6'b001001  //jalr
					||ins_W[5:0]==6'b010000		//mfhi
					||ins_W[5:0]==6'b010010		//mflo
				) 
				begin
					RegDst=1;
					RegWrite=1;
				end
				else if(ins_W[5:0]==6'b001001)	//jal
					RegWrite=1;
			end
			6'b001101:  //ori
				RegWrite=1;
			6'b001111: //lui
				RegWrite=1;
			6'b001001:  //addiu
				RegWrite=1;
			6'b001000:	//addi
				RegWrite=1;
			6'b001100:  //andi
				RegWrite=1;
			6'b001010:  //slti
				RegWrite=1;
			6'b001011:  //sltiu
				RegWrite=1;
			6'b001110:	//xori
				RegWrite=1;
			
		//==============================
			6'b100011:  //lw
			begin
				MemtoReg=1;
				RegWrite=1;
				RM_extOp=0;
			end
			6'b100000:  //lb
			begin
				MemtoReg=1;
				RegWrite=1;
				RM_extOp=2;
			end
			6'b100001:  //lh
			begin
				MemtoReg=1;
				RegWrite=1;
				RM_extOp=4;
			end
			6'b100100:  //lbu
			begin
				MemtoReg=1;
				RegWrite=1;
				RM_extOp=1;
			end
			6'b100101:  //lhu
			begin
				MemtoReg=1;
				RegWrite=1;
				RM_extOp=3;
			end
			
		//--------------------
			6'b000011:   //jal
			begin
				RegWrite=1;
				jal_W=1;
			end
			
		endcase
	end


endmodule
