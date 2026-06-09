`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 12:40:21
// Design Name: 
// Module Name: sr_ff_tb
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


module sr_ff_tb(

    );
    reg s_tb,r_tb; 
    reg rst_tb;
    reg clk_tb;
    wire q_tb;
    wire qbar_tb;
    
    sr_ff dut(s_tb,r_tb,rst_tb,clk_tb,q_tb,qbar_tb);
    initial 
    begin
    { s_tb,r_tb,rst_tb,clk_tb}=0;
    end                                      
    //for changing clock continuosly
    always #5 clk_tb=~clk_tb;
    initial
    begin
    rst_tb=1;//rst change  in 10 
    #10;
    rst_tb=0;
    s_tb=1'b0;
    r_tb=1'b0;
    #10;
    s_tb=1'b0;
    r_tb=1'b1;
    #10;
    s_tb=1'b1;
    r_tb=1'b0;
    #10;
    s_tb=1'b1;
    r_tb=1'b1;
    #10;
    end
    
endmodule
