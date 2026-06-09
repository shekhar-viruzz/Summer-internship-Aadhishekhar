`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 17:05:48
// Design Name: 
// Module Name: Ripple_carry_adder
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



module Ripple_carry_adder(input [3:0]a_r,
input[3:0]b_r,input cin_r ,output [3:0]s_r,output cout_r
    );
    wire w1,w2,w3;
    fulladder FA1(a_r[0],b_r[0],cin_r,s_r[0],w1);
    fulladder FA2(a_r[1],b_r[1],w1,s_r[1],w2);
    fulladder FA3(a_r[2],b_r[2],w2,s_r[2],w3);
    fulladder FA4(a_r[3],b_r[3],w3,s_r[3],cout_r);
endmodule