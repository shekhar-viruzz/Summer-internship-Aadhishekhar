`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 11:16:27
// Design Name: 
// Module Name: sq_det_1110
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


module sq_det_1110(input clk,rst,din, output reg detected);
    parameter idle=2'b00; //param assigning
     parameter s1=2'b01;//these are diff states
     parameter s2=2'b10;  
     parameter s3=2'b11;                             
     reg [1:0]ps,ns;//present state and next state
     //present state logic
     always @(posedge clk)//present state only changes with clk
     begin
     if(rst) begin//synchronus rst ,after the clk=syncronous
     ps<=idle;//ps become idle
     end
     else
     ps<=ns;//ps state is combinational so blocking
     end
     
     
     //next state logic
     always@(*)
     begin
     case(ps)
     idle:
     begin
     detected=0;
     if(din==0)
     ns=idle;
     else
     ns=s1;//sequential so non blccking
     end
     s1:
     begin
     detected=0;
     if(din==0)
     ns=idle;
     else
     ns=s2;
     end
     s2:
     begin
     detected=0;
     if(din==0)
     ns=idle;
     else
     ns=s3;
     end
      s3:
     begin
     if(din==0)begin
     ns=idle;
       detected=1;//on;y in s3 the out (detected)is 1
       end
     else
     ns=s3;
     end
     endcase
     
     
    end
endmodule
