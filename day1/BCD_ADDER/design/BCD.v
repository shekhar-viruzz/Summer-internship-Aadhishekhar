`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 17:13:36
// Design Name: 
// Module Name: Bcd_adder
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


module Bcd_adder(input [3:0]a,input [3:0]b, input cin,output [3:0]sum, output cout

    );
    wire [8:1]s;
    wire [4:1]w;
    wire k;
    
    Ripple_carry_adder RC1(a[3:0],b[3:0],cin,s[4:1],s[5]);
    and(s[6],s[4],s[3]);
    and(s[7],s[4],s[2]);
    or(s[8],s[5],s[6],s[7]);
    assign w[1]=1'b0;
    assign w[2]=s[8];
    assign w[3]=s[8];
    assign w[4]=1'b0;
    Ripple_carry_adder RC2(s[4:1],w[4:1],1'b0,sum[3:0],k);
     assign cout=s[8];
endmodule
