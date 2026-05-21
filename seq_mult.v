`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.06.2025 15:02:06
// Design Name: 
// Module Name: seq_mult
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`define width 8
`define ctrwidth 4

module seq_mult (output reg signed [(2*`width)-1:0]p, 
                 output reg done, 
	             input clk, start,
	             input signed [`width-1:0] a, b
		         );
		         
reg [`ctrwidth-1:0] ctr = 0;
reg signed [(2*`width)-1:0] multiplicand, multiplier;	
reg signed [(2*`width)-1:0] temp = 0;	       

	always @(posedge clk)
		if (start) begin
			done 			<= 0;
			p 			<= 0;
			ctr 			<= 0;
			if(a[`width-1] == 0) begin 
			multiplier 		<=  a;          
			multiplicand 	<=  b;
			end
			else begin
			multiplier 		<=  b;         
			multiplicand 	<=  a;
			end  			
     	end 
     	else begin 
     	   if(ctr<`width) begin
	           if(multiplier[ctr] == 1) begin
	           temp = {{`width{multiplicand[`width-1]}},multiplicand};
	           temp = temp <<< ctr;
	           p = p + temp;
	  		   end 
	  		ctr = ctr + 1;
	  		end 
	  		else begin
	     		done <= 1; 	
	  		end
     	end
   
endmodule 

