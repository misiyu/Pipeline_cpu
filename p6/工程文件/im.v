`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:34:43 12/02/2015 
// Design Name: 
// Module Name:    im 
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
module im(addr,ins
    );
	input[10:0] addr;
	output[31:0] ins;
	reg[31:0] im[2047:0];
	assign ins=im[addr];
   initial 
	begin
		$readmemh("code.txt",im);
	end

endmodule