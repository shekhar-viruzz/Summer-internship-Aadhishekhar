`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 17:07:44
// Design Name: 
// Module Name: Ripple_carry_adder_tb
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


module Ripple_carry_adder_tb();
    reg[3:0]a_r_tb;
    reg[3:0]b_r_tb;
    reg cin_r_tb;
    wire [3:0]s_r_tb;
    wire cout_r_tb;
    
    Ripple_carry_adder dut(a_r_tb,b_r_tb,cin_r_tb,s_r_tb,cout_r_tb);
    initial
    begin
    {a_r_tb,b_r_tb,cin_r_tb}=0;
    end
    initial 
    begin
    a_r_tb=4'b0000;
    b_r_tb=4'b0000;
    cin_r_tb=1'b0;
    #1
     a_r_tb=4'b0000;
 b_r_tb=4'b0000;
 cin_r_tb=1'b0;
 #1
  a_r_tb=4'b0010;
  b_r_tb=4'b0100;
  cin_r_tb=1'b1;
 #1
  a_r_tb=4'b1110;
  b_r_tb=4'b0110;
  cin_r_tb=1'b1;
 #1
  a_r_tb=4'b0011;
  b_r_tb=4'b1100;
  cin_r_tb=1'b1;
  
  $monitor("the value of a_r_tb is %b the value of b_r_tb is %b the value of cin_r_tb is %b the value of s_r_tb is %b the value of cout_r_tb is %b",a_r_tb,b_r_tb,cin_r_tb,s_r_tb,cout_r_tb);
    end
endmodule

