`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:53:02 12/06/2015 
// Design Name: 
// Module Name:    test 
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
module test(
    input [5:0] a,
    input [5:0] b,
    output[12:0]  c,
	 output[5:0] d
    );
	assign c=$signed(a)/$signed(b);
	assign d=$signed(a)%$signed(b);

endmodule
