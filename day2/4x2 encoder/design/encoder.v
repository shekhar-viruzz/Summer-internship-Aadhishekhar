`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 10:47:43
// Design Name: 
// Module Name: encoder
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


module encoder(input [3:0]d,output reg [1:0]b

    );
    always@(*)
    begin
    case(d)
   4'b0001:b=2'b00;
    4'b0010:b=2'b01;
    4'b0100:b=2'b10;
      4'b1000:b=2'b11;
       default: b=2'b00;
       endcase
    end
endmodule
