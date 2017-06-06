`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:43:15 11/22/2015 
// Design Name: 
// Module Name:    ID_ctrl 
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
module D_ctrl(
	ins_D,j,extOp,branch,jal,jr,cmpOp
    );
	input[31:0] ins_D;
	output reg extOp,j,branch,jal,jr;
	output reg[2:0] cmpOp;
	initial begin
		j=0;
		extOp=0;
		j=0;
		branch=0;
		jal=0;
		jr=0;
		cmpOp=0;
	end
	always@(*)
	begin
		extOp=0;
		j=0;
		branch=0;
		jal=0;
		jr=0;
		cmpOp=0;
		case(ins_D[31:26])
		//==================跳转相关
			6'b000010:  //j
			begin
				j=1;
				branch=1;
				cmpOp=6;
			end
			6'b000011:   //jal
			begin
				j=1;
				jal=1;
				branch=1;
				cmpOp=6;
			end
			6'b000000:   //jr jalr
			begin
				if(ins_D[5:0]==6'b001000)   //jr
				begin
					branch=1;
					cmpOp=6;
					jr=1;
				end
				else if(ins_D[5:0]==6'b001001)  //jalr
				begin
					branch=1;
					cmpOp=6;
					jr=1;
				end
			end
			//-----------B型指令
			
			6'b000100:   //beq 
			begin
				branch=1;
				cmpOp=0;
			end
			6'b000101:  //bne
			begin
				branch=1;
				cmpOp=1;
			end
			6'b000110:	//blez
			begin
				branch=1;
				cmpOp=3;
			end
			6'b000111:	//bgtz
			begin
				branch=1;
				cmpOp=4;
			end
			6'b000001:	//bltz  bgez
			begin
				branch=1;
				if(ins_D[20:16]==5'b00000)	//bltz
					cmpOp=2;
				else if(ins_D[20:16]==5'b00001) //bgez
					cmpOp=5;
			end
			
		//===================计算相关
			6'b001101:	//ori
				extOp=1;				//1表示0扩展
			6'b001100:	//andi
				extOp=1;
			6'b001110:	//xori
				extOp=1;
		endcase
	end
endmodule
