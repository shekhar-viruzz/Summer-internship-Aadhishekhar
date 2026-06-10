`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 11:20:01
// Design Name: 
// Module Name: seq_det_1110_tb
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


module seq_det_1110_tb(

    );
     reg clk_tb;
     reg rst_tb;
     reg din_tb;
    wire detected_tb;
    sq_det_1110 dut(clk_tb,rst_tb,din_tb,detected_tb);
    initial
    begin
    {clk_tb,rst_tb,din_tb}=0;//concadination
    end
    always #5 clk_tb=~clk_tb;
    initial
    begin
    rst_tb=1;
    #10;//after one clock period rst=0
    rst_tb=0;
    #10;
    din_tb=1;//1110
    #10;
    din_tb=1;
    #10;
    din_tb=1;
    #10;
    din_tb=0;
    #20;
    $finish;
    end
endmodule



