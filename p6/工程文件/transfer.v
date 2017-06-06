`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:02:30 11/29/2015 
// Design Name: 
// Module Name:    transfer 
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
module transfer(
	ins_D,ins_E,ins_M,ins_W,RData2_M,RData2_W,ForwardAE,ForwardBE,ForwardAD,ForwardBD//,RS_E,RT_E,RD_M,RD_W,RS_D,RT_D
    );
	input[31:0] ins_D,ins_E,ins_M,ins_W,RData2_M,RData2_W;
	output reg[1:0]  ForwardAE,ForwardBE;
	output reg ForwardAD,ForwardBD;
	reg[4:0] RS_E,RT_E,RD_M,RD_W,RS_D,RT_D;
	always @(*)
	begin
	//---------------------------------get ALU a ,b 
	RS_E=0;
	RT_E=0;
	RS_D=0;
	RT_D=0;
	RD_M=0;
	RD_W=0;
	// ===========================get RS_E,RT_E
	if(ins_E[31:26]==0)    
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
			||(ins_E[5:0]==0&&ins_E!=0) //sll
			||(ins_E[5:0]==6'b000100) //sllv
			||(ins_E[5:0]==6'b000010) //srl
			||(ins_E[5:0]==6'b000110) //srlv
			||(ins_E[5:0]==6'b000011) //sra
			||(ins_E[5:0]==6'b000111) //srav
			||(ins_E[5:0]==6'b011001)	//multu
			||(ins_E[5:0]==6'b011000)	//mult
			||(ins_E[5:0]==6'b011011) //	divu
			||(ins_E[5:0]==6'b011010) //	div
			||(ins_E[5:0]==6'b001001)	//jalr
			)
		begin
			RS_E=ins_E[25:21];
			RT_E=ins_E[20:16];
		end
		else if((ins_E[5:0]==6'b010001) //	mthi
					||(ins_E[5:0]==6'b010011) //	mtlo
					)
				RS_E=ins_E[25:21];
	end
	else if(	ins_E[31:26]==6'b001101		//ori
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
				
				)	
		RS_E=ins_E[25:21];
	else if(ins_E[31:26]==6'b101011   //sw
				||ins_E[31:26]==6'b101001   //sh
				||ins_E[31:26]==6'b101000   //sb
				)
	begin
		RS_E=ins_E[25:21];
		RT_E=ins_E[20:16];
	end
	
	
	//=============================get RS_D  RT_D
	if(ins_D[31:26]==0)    //addu subu
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
			||(ins_D[5:0]==0&&ins_D!=0) //sll
			||(ins_D[5:0]==6'b000100) //sllv
			||(ins_D[5:0]==6'b000010) //srl
			||(ins_D[5:0]==6'b000110) //srlv
			||(ins_D[5:0]==6'b000011) //sra
			||(ins_D[5:0]==6'b000111) //srav
			||(ins_D[5:0]==6'b011001)	//multu
			||(ins_D[5:0]==6'b011000)	//mult
			||(ins_D[5:0]==6'b011011) //	divu
			||(ins_D[5:0]==6'b011010) //	div
			)
		begin
			RS_D=ins_D[25:21];
			RT_D=ins_D[20:16];
		end
		else if(ins_D[5:0]==6'b001000	//jr
					||ins_D[5:0]==6'b001001	//jalr
					||(ins_D[5:0]==6'b010001) //	mthi
					||(ins_D[5:0]==6'b010011) //	mtlo
				  )
			RS_D=ins_D[25:21];
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
				||ins_D[31:26]==6'b000110  //blez
				||ins_D[31:26]==6'b000111   //bgtz
				||ins_D[31:26]==6'b000001   //bltz //bgez
				)	
	begin
		RS_D=ins_D[25:21];
		RT_D=0;
	end
	else if(	ins_D[31:26]==6'b101011   //sw
				||ins_D[31:26]==6'b101001   //sh
				||ins_D[31:26]==6'b101000   //sb
				||ins_D[31:26]==6'b000100   //beq
				||ins_D[31:26]==6'b000101   //bne
				)
	begin
		RS_D=ins_D[25:21];
		RT_D=ins_D[20:16];
	end
	
	//-------------------------- get RD_M
	if(ins_M[31:26]==6'b000000)    //addu subu
	begin
		if((ins_M[5:0]==6'b100001)		//addu
			||(ins_M[5:0]==6'b100011)	//subu
			||(ins_M[5:0]==6'b001010)	//
			||(ins_M[5:0]==6'b100101)	//or
			||(ins_M[5:0]==6'b100000)	//add
			||(ins_M[5:0]==6'b100010) //sub
			||(ins_M[5:0]==6'b100100) //and
			||(ins_M[5:0]==6'b100110) //xor
			||(ins_M[5:0]==6'b100111) //nor
			||(ins_M[5:0]==6'b101010) //slt
			||(ins_M[5:0]==6'b101011) //sltu
			||(ins_M[5:0]==6'b000000&&ins_M!=0) //sll
			||(ins_M[5:0]==6'b000100) //sllv
			||(ins_M[5:0]==6'b000010) //srl
			||(ins_M[5:0]==6'b000110) //srlv
			||(ins_M[5:0]==6'b000011) //sra
			||(ins_M[5:0]==6'b000111) //srav
			||(ins_M[5:0]==6'b001001) //jalr
			||(ins_M[5:0]==6'b010000) //	mfhi
			||(ins_M[5:0]==6'b010010) //	mflo
			
			)
			RD_M=ins_M[15:11];
			
	end
	else if(ins_M[31:26]==6'b001101		//ori
				||ins_M[31:26]==6'b001001	//addiu
				||ins_M[31:26]==6'b001000	//addi
				||ins_M[31:26]==6'b001100  //andi
				||ins_M[31:26]==6'b001010  //slti
				||ins_M[31:26]==6'b001011  //sltiu
				||ins_M[31:26]==6'b001110  //xori
				||ins_M[31:26]==6'b100011   //lw
				||ins_M[31:26]==6'b100000	//lb
				||ins_M[31:26]==6'b100001	//lh
				||ins_M[31:26]==6'b100101	//lhu
				||ins_M[31:26]==6'b100100	//lbu
				||ins_M[31:26]==6'b001111	//lui
				)
		RD_M=ins_M[20:16];
	else if(ins_M[31:26]==6'b000011)	//jal
		RD_M=5'b11111;

	//==============================get RD_W
	if(ins_W[31:26]==6'b000000)    //addu subu
	begin
		if((ins_W[5:0]==6'b100001)		//addu
			||(ins_W[5:0]==6'b100011)	//subu
			||(ins_W[5:0]==6'b001010)	//
			||(ins_W[5:0]==6'b100101)	//or
			||(ins_W[5:0]==6'b100000)	//add
			||(ins_W[5:0]==6'b100010) //sub
			||(ins_W[5:0]==6'b100100) //and
			||(ins_W[5:0]==6'b100110) //xor
			||(ins_W[5:0]==6'b100111) //nor
			||(ins_W[5:0]==6'b101010) //slt
			||(ins_W[5:0]==6'b101011) //sltu
			||(ins_W[5:0]==6'b000000&&ins_W!=0) //sll
			||(ins_W[5:0]==6'b000100) //sllv
			||(ins_W[5:0]==6'b000010) //srl
			||(ins_W[5:0]==6'b000110) //srlv
			||(ins_W[5:0]==6'b000011) //sra
			||(ins_W[5:0]==6'b000111) //srav
			||(ins_W[5:0]==6'b001001) //jalr
			)
		begin
			RD_W=ins_W[15:11];
		end
	end
	else if(ins_W[31:26]==6'b001101		//ori
				||ins_W[31:26]==6'b001001	//addiu
				||ins_W[31:26]==6'b001000	//addi
				||ins_W[31:26]==6'b001100  //andi
				||ins_W[31:26]==6'b001010  //slti
				||ins_W[31:26]==6'b001011  //sltiu
				||ins_W[31:26]==6'b001110  //xori
				||ins_W[31:26]==6'b100011  //lw
				||ins_W[31:26]==6'b100000	//lb
				||ins_W[31:26]==6'b100001	//lh
				||ins_W[31:26]==6'b100101	//lhu
				||ins_W[31:26]==6'b100100	//lbu
				||ins_W[31:26]==6'b001111	//lui
				)
		RD_W=ins_W[20:16];
	
	else if(ins_W[31:26]==6'b000011)	//jal
		RD_W=5'b11111;

	end
	always@(*)
	begin
		ForwardAE=0;
		ForwardBE=0;
		ForwardAD=0;
		ForwardBD=0;
		if(RS_E==RD_M&&RD_M!=0)
			ForwardAE=2'b01;
		else if(RS_E==RD_W&&RD_W!=0)
			ForwardAE=2'b10;
		if(RT_E==RD_M&&RD_M!=0)
			ForwardBE=2'b01;
		else if(RT_E==RD_W&&RD_W!=0)
			ForwardBE=2'b10;
		if(RS_D==RD_M&&RD_M!=0)
			ForwardAD=1;
		if(RT_D==RD_M&&RD_M!=0)
			ForwardBD=1;
	end
endmodule
