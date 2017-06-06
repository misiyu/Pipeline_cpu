`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:35:13 11/29/2015 
// Design Name: 
// Module Name:    stop 
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
module stop(
	ins_D,ins_E,ins_M,Busy_E,nop,mul_busy
    );
	input [31:0] ins_D,ins_E,ins_M;
	input Busy_E;
	output reg nop,mul_busy;
	reg[4:0] RS_D,RT_D,RD_E;
	initial 
	begin
		nop=0;
		mul_busy=0;
	end
	always@(*)
	begin
	nop=0;
	mul_busy=0;
	RS_D=0;
	RT_D=0;
	RD_E=0;
	//========get Rs_D,RT_D
	if(ins_D[31:26]==6'b000000)    
	begin
		if((ins_D[5:0]==6'b100001)		//addu
			||(ins_D[5:0]==6'b100011)	//subu
			||(ins_D[5:0]==6'b001010)	//
			||(ins_D[5:0]==6'b100101)	//or
			||(ins_D[5:0]==6'b100000)	//add
			||(ins_D[5:0]==6'b100010) //sub
			||(ins_D[5:0]==6'b100100) //and
			||(ins_D[5:0]==6'b100110) //xor
			||(ins_D[5:0]==6'b100111) //nor
			||(ins_D[5:0]==6'b101010) //slt
			||(ins_D[5:0]==6'b101011) //sltu
			||(ins_D[5:0]==6'b000000&&ins_D!=0) //sll
			||(ins_D[5:0]==6'b000100) //sllv
			||(ins_D[5:0]==6'b000010) //srl
			||(ins_D[5:0]==6'b000110) //srlv
			||(ins_D[5:0]==6'b000011) //sra
			||(ins_D[5:0]==6'b000111) //srav
			||(ins_D[5:0]==6'b010001) //	mthi
			||(ins_D[5:0]==6'b010011) //	mtlo
			||(ins_D[5:0]==6'b011001)	//	multu
			||(ins_D[5:0]==6'b011000)	//	mult
			||(ins_D[5:0]==6'b011010)	//	div
			||(ins_D[5:0]==6'b011011)	//	divu
			)
		begin
			RS_D=ins_D[25:21];
			RT_D=ins_D[20:16];
		end
		else if(ins_D[5:0]==6'b001000	//jr
					||ins_D[5:0]==6'b001001	//jalr
					)	
		begin
			RS_D=ins_D[25:21];
		end
	end
	else if(	ins_D[31:26]==6'b001101		//ori
				||ins_D[31:26]==6'b001001	//addiu
				||ins_D[31:26]==6'b001000	//addi
				||ins_D[31:26]==6'b001100  //andi
				||ins_D[31:26]==6'b001010  //slti
				||ins_D[31:26]==6'b001011  //sltiu
				||ins_D[31:26]==6'b001110  //xori
				||ins_D[31:26]==6'b100011   //lw
				||ins_D[31:26]==6'b100000	//lb
				||ins_D[31:26]==6'b100001	//lh
				||ins_D[31:26]==6'b100101	//lhu
				||ins_D[31:26]==6'b100100	//lbu
				)	
	begin
		RS_D=ins_D[25:21];
	end
	else if(	ins_D[31:26]==6'b101011   //sw
				||ins_D[31:26]==6'b101001   //sh
				||ins_D[31:26]==6'b101000   //sb
				||ins_D[31:26]==6'b000100   //beq
				||ins_D[31:26]==6'b000101   //bne
				||ins_D[31:26]==6'b000110   //blez
				||ins_D[31:26]==6'b000111   //bgtz
				||ins_D[31:26]==6'b000001   //bltz bgez	
				)
	begin
		RS_D=ins_D[25:21];
		RT_D=ins_D[20:16];
	end

	//================= get RD_E
	if(ins_E[31:26]==6'b000000)    //addu subu
	begin
		if((ins_E[5:0]==6'b100001)		//addu
			||(ins_E[5:0]==6'b100011)	//subu
			||(ins_E[5:0]==6'b001010)	//
			||(ins_E[5:0]==6'b100101)	//or
			||(ins_E[5:0]==6'b100000)	//add
			||(ins_E[5:0]==6'b100010) //sub
			||(ins_E[5:0]==6'b100100) //and
			||(ins_E[5:0]==6'b100110) //xor
			||(ins_E[5:0]==6'b100111) //nor
			||(ins_E[5:0]==6'b101010) //slt
			||(ins_E[5:0]==6'b101011) //sltu
			||(ins_E[5:0]==6'b000000&&ins_E!=0) //sll
			||(ins_E[5:0]==6'b000100) //sllv
			||(ins_E[5:0]==6'b000010) //srl
			||(ins_E[5:0]==6'b000110) //srlv
			||(ins_E[5:0]==6'b000011) //sra
			||(ins_E[5:0]==6'b000111) //srav
			||(ins_E[5:0]==6'b010000) //	mfhi
			||(ins_E[5:0]==6'b010010) //	mflo
			||(ins_E[5:0]==6'b001001)	//jalr
			)
		begin
			RD_E=ins_E[15:11];
		end
	end
	else if(ins_E[31:26]==6'b001101		//ori
				||ins_E[31:26]==6'b001001	//addiu
				||ins_E[31:26]==6'b001000	//addi
				||ins_E[31:26]==6'b001100  //andi
				||ins_E[31:26]==6'b001010  //slti
				||ins_E[31:26]==6'b001011  //sltiu
				||ins_E[31:26]==6'b001110  //xori
				||ins_E[31:26]==6'b100011   //lw
				||ins_E[31:26]==6'b100000	//lb
				||ins_E[31:26]==6'b100001	//lh
				||ins_E[31:26]==6'b100101	//lhu
				||ins_E[31:26]==6'b100100	//lbu
				||ins_E[31:26]==6'b001111	//lui
				)
		RD_E=ins_E[20:16];
	else if(ins_E[31:26]==6'b000011)	//jal
		RD_E=5'b11111;
	
	
	//================暂停条件判断
	if(ins_E[31:26]==6'b100011	//lw  如果lw在E级
		||ins_E[31:26]==6'b100000	//lb
		||ins_E[31:26]==6'b100001	//lh
		||ins_E[31:26]==6'b100101	//lhu
		||ins_E[31:26]==6'b100100	//lbu
			)	
		if((RD_E==RS_D||RD_E==RT_D)&&RD_E!=0)
			nop=1;
	
	if(ins_D[31:26]==6'b000100       //beq
		||ins_D[31:26]==6'b000101       //bne
		||ins_D[31:26]==6'b000110       //blez
		||ins_D[31:26]==6'b000111       //bgtz
		||ins_D[31:26]==6'b000001       //bltz,bgez
		)
	begin
		if(ins_M[31:26]==6'b100011	//如果M级为lw
			||ins_M[31:26]==6'b100000	//lb
			||ins_M[31:26]==6'b100001	//lh
			||ins_M[31:26]==6'b100101	//lhu
			||ins_M[31:26]==6'b100100	//lbu
			)
			if((ins_M[20:16]==RS_D||ins_M[20:16]==RT_D)&&ins_M[20:16]!=0)
			nop=1;
		if((RD_E==RS_D||RD_E==RT_D)&&RD_E!=0)		//如果判断的数正在E级计算
			nop=1;
	end
	
	
	else if(ins_D[31:26]==6'b000000)		
	begin
		if(ins_D[5:0]==6'b001000	//jr
			||ins_D[5:0]==6'b001001	//jalr
			)
		begin
			if((RD_E==RS_D||RD_E==RT_D)&&RD_E!=0)
				nop=1;
			if(ins_M[31:26]==6'b100011	//如果M级为lw
				||ins_M[31:26]==6'b100000	//lb
				||ins_M[31:26]==6'b100001	//lh
				||ins_M[31:26]==6'b100101	//lhu
				||ins_M[31:26]==6'b100100	//lbu
				)
				if((ins_M[20:16]==RS_D||ins_M[20:16]==RT_D)&&ins_M[20:16]!=0)
				nop=1;
		end
	end
	if((ins_D[31:26]==0)&&Busy_E&&
				(
				(ins_D[5:0]==6'b011001)	//multu
				||(ins_D[5:0]==6'b011000)	//mult
				||(ins_D[5:0]==6'b011011) //	divu
				||(ins_D[5:0]==6'b011010) //	div
				||(ins_D[5:0]==6'b010001) //	mthi
				||(ins_D[5:0]==6'b010011) //	mtlo
				||(ins_D[5:0]==6'b010000) //	mfhi
				||(ins_D[5:0]==6'b010010) //	mflo
				)
			)
		mul_busy=1;
	end
endmodule
