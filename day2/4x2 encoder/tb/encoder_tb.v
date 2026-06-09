`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 10:52:54
// Design Name: 
// Module Name: encoder_tb
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


module encoder_tb(

    );
    reg [3:0]d_tb;
    wire [1:0]b_tb;
    encoder dut (d_tb,b_tb);
    initial
    begin
    d_tb=4'b0001;
    #10;
    d_tb=4'b0010;
    #10;
    d_tb=4'b0100;
    #10;
    d_tb=4'b1000;
    #10;
    $monitor("the value of d_tb is %b the value of b_tb is %b",d_tb,b_tb);
    
    end
    
endmodule
