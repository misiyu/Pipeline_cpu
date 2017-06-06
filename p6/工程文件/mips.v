`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:32:47 12/06/2015 
// Design Name: 
// Module Name:    mips 
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
module mips(
   //clk,reset
    );
	//input clk,reset;
	reg clk=0,reset;
	
	always #5 clk = ~clk;
	initial begin
        #1 reset = 1;
        #8 reset = 0;
        #1;
   end
	//----------------流水值 
	wire[10:0] addr;
	wire[31:0]  ins_F,ins_D,ins_E,ins_M,ins_W;
	wire[31:0]	alu_Result_E,alu_Result_M,alu_Result_W;
	wire[31:0]	imm_D,imm_E;
	wire[31:0]  RData1_D,RData1_E; 
	wire[31:0]	pc_F,pc_D,pc_E,pc_M,pc_W;
	wire[31:0]	RData2_D,RData2_E,RData2_M,RData2_W;
	wire[31:0]	DMRData_M,DMRData_W;
	//------------
	wire[31:0] NPC;
	wire	branch,Br,j,jr,extOp,RegWrite,ALUSrcA,ALUSrcB,
			MemWrite,RegWrite,jal_W,RegDst,MemtoReg,ForwardAD,ForwardBD,
			nop,HiLo_E,Start_E,HiLoWe,Busy_E,Over,mul_busy;
	wire[2:0] cmpOp,RM_extOp;
	wire[31:0] WData,alu_A,alu_B,rm_ext_dout,HI_E,LO_E;
	wire[4:0] RD;
	wire[3:0] BE_M;
	wire[1:0] ForwardAE,ForwardBE,Be_Op,mulOp_E;
	//一些中间变量
	wire[31:0] ALU_Atemp,ALU_Btemp,RData1_Dtemp,RData2_Dtemp;
	wire[4:0] RDtemp,ALUOp;
	
	//-----------------------------------hazard
	hazard hazard(
						.ins_D(ins_D),
						.ins_E(ins_E),
						.ins_M(ins_M),
						.ins_W(ins_W),
						.Busy_E(Busy_E),
						.RData2_M(RData2_M),
						.RData2_W(RData2_W),
						.ForwardAE(ForwardAE),
						.ForwardBE(ForwardBE),
						.ForwardAD(ForwardAD),
						.ForwardBD(ForwardBD),
						.nop(nop),
						.mul_busy(mul_busy)
					);
	
	//-------------------------W
	W_ctrl w_ctrl(.ins_W(ins_W),
						.RData2_W(RData2_W),
						.MemtoReg(MemtoReg),
						.RegDst(RegDst),
						.RegWrite(RegWrite),
						.jal_W(jal_W),
						.RM_extOp(RM_extOp)
						);
	RM_ext rm_ext(.A(alu_Result_W[1:0]),
						.Din(DMRData_W),
						.Op(RM_extOp),
						.DOut(rm_ext_dout)
						);
	mux_2_32b mux32_getGprWData(alu_Result_W,rm_ext_dout,MemtoReg,WData);
	mux_2_5b mux_getRD(ins_W[20:16],ins_W[15:11],RegDst,RDtemp);
	mux_2_5b getRD(RDtemp,5'b11111,jal_W,RD);
	//-------------------------M
	M_ctrl m_ctrl(.ins_M(ins_M),
						.MemWrite(MemWrite),
						.BE_Op(Be_Op)
						);
	BE_ext be_ext(.A(alu_Result_M[1:0]),
						.Op(Be_Op),
						.BE_M(BE_M)
						);
	dm dm(.A(alu_Result_M[12:2]),
			.BE(BE_M),
			.WD(RData2_M),
			.RD(DMRData_M),
			.We(MemWrite),
			.Clk(clk)
			);
	
	//-------------------------E
	E_ctrl e_ctrl(.ins_E(ins_E),
						.ALUOp(ALUOp),
						.ALUSrcB(ALUSrcB),
						.ALUSrcA(ALUSrcA),
						.HiLo_E(HiLo_E),
						.Start_E(Start_E),
						.HiLoWe(HiLoWe),
						.mulOp_E(mulOp_E)
						);
	alu alu(.A(alu_A),  //alu_A
				.B(alu_B),
				.Op(ALUOp),
				.C(alu_Result_E),
				.Over(Over)
				);
	mux_3_32b MFRSE(RData1_E,alu_Result_M,WData,ForwardAE,ALU_Atemp);
	mux_2_32b mux32_getALU_A(ALU_Atemp,{RData2_E[31:5],ins_E[10:6]},ALUSrcA,alu_A);
	
	mux_3_32b MFRTE(RData2_E,alu_Result_M,WData,ForwardBE,ALU_Btemp);
	mux_2_32b mux32_getALU_B(ALU_Btemp,imm_E,ALUSrcB,alu_B);
	mul_div mul_div(.D1(alu_A),
							.D2(alu_B),
							.HiLo(HiLo_E),
							.Op(mulOp_E),
							.Start(Start_E),
							.We(HiLoWe),
							.Busy(Busy_E),
							.HI(HI_E),
							.LO(LO_E),
							.Clk(clk),
							.Rst(reset)
							);
	//---------------------F
	ins_addr ins_addr(pc_F,addr);		//用于查看指令行号
	pc pc(.NPC(NPC),
			.clk(clk),
			.rst(reset),
			.en(nop||mul_busy||Start_E),
			.PCSrcD(branch&&Br),
			.PC(pc_F)
			);
	im im(.addr({0,pc_F[11:2]}),
			.ins(ins_F)
			);
	//-----------------D
	D_ctrl d_ctrl(.ins_D(ins_D),
						.j(j),
						.extOp(extOp),
						.branch(branch),
						.jal(jal),
						.jr(jr),
						.cmpOp(cmpOp)
						);
	gpr gpr(.Clk(clk),
			.Rst(reset),
			.A1(ins_D[25:21]),
			.A2(ins_D[20:16]),
			.A3(RD),
			.We(RegWrite),
			.WD(WData),
			.RD1(RData1_Dtemp),
			.RD2(RData2_Dtemp)
			);
	mux_2_32b MFRSD(RData1_Dtemp,alu_Result_M,ForwardAD,RData1_D);
	mux_2_32b MFRTD(RData2_Dtemp,alu_Result_M,ForwardBD,RData2_D);
	ext ext(.imm_in(ins_D[15:0]),
				.extOp(extOp),
				.imm_D(imm_D)
				);
	cmp cmp(.A(RData1_D),
				.B(RData2_D),
				.Op(cmpOp),
				.Br(Br)
				);
	npc npc(.PC(pc_D),
				.imm_D(imm_D),
				.RData1_D(RData1_D),
				.j(j),
				.jr(jr),
				.branch(branch),
				.ins_D(ins_D),
				.npc(NPC)
				);
//====================流水线寄存器
	IF_ID if_id(.clk(clk),
					.rst(reset),
					.en(nop||mul_busy||Start_E),
					.ins_F(ins_F),
					.pc_F(pc_F),
					.ins_D(ins_D),
					.pc_D(pc_D)
					);
	ID_EX id_ex(.clk(clk),
					.rst(reset||nop||mul_busy||Start_E),
					.en(0),
					.ins_D(ins_D),
					.pc_D(pc_D),
					.ins_E(ins_E),
					.pc_E(pc_E),
					.RData1_D(RData1_D),
					.RData2_D(RData2_D),
					.imm_D(imm_D),
					.RData1_E(RData1_E),
					.RData2_E(RData2_E),
					.imm_E(imm_E)
					);
	EX_MEM ex_mem(.clk(clk),
					  .rst(reset),
					  .en(0),
					  .ins_E(ins_E),
					  .pc_E(pc_E),
					  .RData2_E(ALU_Btemp),			//这里传入值为ALU_Btemp，方便转发
					  .alu_Result_E(alu_Result_E),
					  .HI_E(HI_E),
					  .LO_E(LO_E),
					  .ins_M(ins_M),
					  .pc_M(pc_M),
					  .RData2_M(RData2_M),
					  .alu_Result_M(alu_Result_M)
					  );
	MEM_WB mem_wb(.clk(clk),
					  .rst(reset),
					  .en(0),
					  .ins_M(ins_M),
					  .pc_M(pc_M),
					  .alu_Result_M(alu_Result_M),
					  .DMRData_M(DMRData_M),
					  .RData2_M(RData2_M),
					  .ins_W(ins_W),
					  .pc_W(pc_W),
					  .alu_Result_W(alu_Result_W),
					  .DMRData_W(DMRData_W),
					  .RData2_W(RData2_W)
					  );
endmodule
