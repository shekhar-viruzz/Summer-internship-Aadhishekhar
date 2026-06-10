`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 13:46:01
// Design Name: 
// Module Name: face_mod_tb
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


module face_module_tb(

    );
    reg [7:0]s_in_tb;
    reg clk_tb;
    wire [7:0]s_out_tb;
    face_mod dut(s_in_tb,clk_tb,s_out_tb);
    initial
    begin
    {s_in_tb,clk_tb}=0;
    end
   always #5 clk_tb<=~clk_tb;
   initial
   begin
   s_in_tb=8'h11;
   #10;
   s_in_tb=8'h22;
   #10;
    s_in_tb=8'h33;
   #10; 
   s_in_tb=8'h44;
   #10;
      end
    
endmodule