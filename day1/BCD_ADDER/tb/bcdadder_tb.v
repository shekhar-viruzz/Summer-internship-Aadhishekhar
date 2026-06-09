`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 22:30:21
// Design Name: 
// Module Name: bcdadder_tb
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



module bcdadder_tb();
    reg [3:0]a_tb;
    reg [3:0]b_tb;
    reg cin_tb;
    wire [3:0]sum_tb;
    wire cout_tb;
    
 Bcd_adder dut( a_tb,b_tb,cin_tb,sum_tb,cout_tb);
       initial 
       begin
       {a_tb,b_tb,cin_tb}=0;
       end 
       initial
       begin
       a_tb=4'b0000;
       b_tb=4'b0000;
       cin_tb=1'b0;
       #1;
       a_tb=4'b0001;
       b_tb=4'b0010;
       cin_tb=1'b0;
       #1;
       a_tb=4'b0101;
       b_tb=4'b0011;
       cin_tb=1'b0;
       #1;
       a_tb=4'b0100;
       b_tb=4'b0101;
       cin_tb=1'b0;
       #1;
       a_tb=4'b0101;
       b_tb=4'b0101;
       cin_tb=1'b0;
       #1;
       a_tb=4'b0110;
       b_tb=4'b0101;
       cin_tb=1'b0;
        #1;
       a_tb=4'b1001;
       b_tb=4'b1001;
       cin_tb=1'b0;
      $monitor("the value of a_tb is %b the value of b_tb is %b the value of cin_tb is %b the value of sum_tb is %b the value of cout_tb is %b",a_tb,b_tb,cin_tb,sum_tb,cout_tb);

    end
    
    
    
endmodule