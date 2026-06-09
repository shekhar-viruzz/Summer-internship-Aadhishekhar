`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 13:40:19
// Design Name: 
// Module Name: d_ff_tb
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


module d_ff_tb(

    );
     reg d_tb; 
    reg rst_tb;
    reg clk_tb;
    wire q_tb;
    wire qbar_tb;
    
    d_ff dut(d_tb,rst_tb,clk_tb,q_tb,qbar_tb);
    initial 
    begin
    { d_tb,rst_tb,clk_tb}=0;
    end                                      
    //for changing clock continuosly
    always #5 clk_tb=~clk_tb;
    initial
    begin
    rst_tb=1;//rst change  in 10 
    #1;
    rst_tb=0;
    d_tb=1'b0;
    #10;
    d_tb=1'b1;
    #10;
  
    end
    
endmodule
