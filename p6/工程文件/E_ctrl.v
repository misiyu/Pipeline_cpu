`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:58:03 11/22/2015 
// Design Name: 
// Module Name:    EX 
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
module E_ctrl(ins_E,ALUOp,ALUSrcB,ALUSrcA,HiLo_E,Start_E,HiLoWe,mulOp_E
    );
	input[31:0] ins_E;
	output reg [4:0] ALUOp;
	output reg ALUSrcB,ALUSrcA,HiLo_E,Start_E,HiLoWe;
	output reg [1:0] mulOp_E;
	initial begin
		ALUOp=0;
		ALUSrcB=0;
		ALUSrcA=0;
		HiLo_E=0;
		Start_E=0;
		HiLoWe=0;
		mulOp_E=0;
	end
	always@(*)
	begin
		ALUSrcA=0;
		ALUSrcB=0;
		ALUOp=0;
		HiLo_E=0;
		Start_E=0;
		HiLoWe=0;
		mulOp_E=0;
		case(ins_E[31:26])
			6'b000000:
			begin
				if(ins_E[5:0]==6'b100001) //addu
					ALUOp=0;
				else if (ins_E[5:0]==6'b100000) //add
					ALUOp=12;
				else if(ins_E[5:0]==6'b100011) //subu
					ALUOp=1;
				else if(ins_E[5:0]==6'b100010) //sub
					ALUOp=13;
				else if(ins_E[5:0]==6'b100101) //or
					ALUOp=2;
				else if(ins_E[5:0]==6'b100100) //and
					ALUOp=4;
				else if(ins_E[5:0]==6'b100110) //xor
					ALUOp=7;
				else if(ins_E[5:0]==6'b100111) //nor
					ALUOp=8;
				else if(ins_E[5:0]==6'b101010) //slt
					ALUOp=10;
				else if(ins_E[5:0]==6'b101011) //sltu
					ALUOp=9;
				else if(ins_E[5:0]==6'b000000&&ins_E!=0) //sll
				begin
					ALUOp=5;
					ALUSrcA=1;
				end
				else if(ins_E[5:0]==6'b000100) //sllv
					ALUOp=5;
				else if(ins_E[5:0]==6'b000010) //srl
				begin
					ALUOp=6;
					ALUSrcA=1;
				end
				else if(ins_E[5:0]==6'b000110) //srlv
					ALUOp=6;
				else if(ins_E[5:0]==6'b000011) //sra
				begin
					ALUOp=11;
					ALUSrcA=1;
				end
				else if(ins_E[5:0]==6'b000111) //srav
					ALUOp=11;
				else if(ins_E[5:0]==6'b011001)	//multu
				begin
					HiLo_E=0;
					Start_E=1;
					HiLoWe=0;
					mulOp_E=0;
				end
				else if(ins_E[5:0]==6'b011000)	//mult
				begin
					Start_E=1;
					mulOp_E=1;
				end			
				else if(ins_E[5:0]==6'b011011) //	divu
				begin
					Start_E=1;
					mulOp_E=2;
				end	
				else if(ins_E[5:0]==6'b011010) //	div
				begin
					Start_E=1;
					mulOp_E=3;
				end	
				else if(ins_E[5:0]==6'b010001) //	mthi
				begin
					HiLo_E=1;
					HiLoWe=1;
				end	
				else if(ins_E[5:0]==6'b010011) //	mtlo
					HiLoWe=1;
			end
			6'b001110:  //xori
			begin
				ALUOp=0;
				ALUSrcB=7;
			end
			6'b001001:  //addiu
			begin
				ALUOp=0;
				ALUSrcB=1;
			end
			6'b001000:	//addi
			begin
				ALUSrcB=1;
				ALUOp=12;
			end
			6'b001101:  //ori
			begin
				ALUSrcB=1;
				ALUOp=2;
			end
			6'b001111: //lui
			begin
				ALUSrcB=1;
				ALUOp=3;
			end
			6'b001100:  //andi
			begin
				ALUSrcB=1;
				ALUOp=4;
			end
			6'b001010:  //slti
			begin
				ALUSrcB=1;
				ALUOp=10;
			end
			6'b001011:  //sltiu
			begin
				ALUSrcB=1;
				ALUOp=9;
			end
			
	//========================
			6'b101011:  //sw
				ALUSrcB=1;
			6'b100011:  //lw
				ALUSrcB=1;
			6'b101000:  //sb
				ALUSrcB=1;
			6'b100000:  //lb
				ALUSrcB=1;
			6'b101001:  //sh
				ALUSrcB=1;
			6'b100001:  //lh
				ALUSrcB=1;
			6'b100100:  //lbu
				ALUSrcB=1;
			6'b100101:  //lhu
				ALUSrcB=1;
		endcase
	end
endmodule
