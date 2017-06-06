`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:52:54 12/01/2015 
// Design Name: 
// Module Name:    mul_div 
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
module mul_div(
	D1,D2,HiLo,Op,Start,We,Busy,HI,LO,Clk,Rst
    );
	input[31:0] D1,D2;
	input HiLo,Start,We,Clk,Rst;
	input[1:0] Op;
	output reg Busy;
	output reg[31:0] HI,LO;
	reg[31:0] HItemp,LOtemp,D1temp,D2temp;
	reg[2:0] Optemp;
	integer i=0;
	initial begin
	HI<=0;
	LO<=0;
	HItemp<=0;
	LOtemp<=0;
	Busy<=0;
	end
	always@(posedge Clk )
	begin
	if(Rst)
	begin
		HItemp<=0;
		LOtemp<=0;
	end
	if(Start)
	begin
		Busy=1;
		D1temp=D1;
		D2temp=D2;
		Optemp=Op;
	end	
	if(Busy==1)
		i=i+1;
	if(i==5)
	begin
		Busy=0;
		i=0;
		if(Optemp==0)
			{HItemp,LOtemp}=D1temp*D2temp;
		else if(Optemp==1)
			{HItemp,LOtemp}=$signed(D1temp)*$signed(D2temp);
		else if(Optemp==2)
		begin
			HItemp=D1temp%D2temp;
			LOtemp=D1temp/D2temp;
		end
		else if(Optemp==3)
		begin
			HItemp=$signed(D1temp)%$signed(D2temp);
			LOtemp=$signed(D1temp)/$signed(D2temp);
		end
	end
	
	if(We)
	begin
		if(HiLo==0)
			LOtemp=D1;
		else
			HItemp=D1;
	end
	HI<=HItemp;
	LO<=LOtemp;
	end
endmodule
