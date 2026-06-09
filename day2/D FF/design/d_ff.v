`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 13:35:38
// Design Name: 
// Module Name: d_ff
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


module d_ff(input d,rst,clk, output reg q,qbar

    );
    always @ (posedge clk)
    begin 
    if (clk) begin
    if (rst) begin
    q<=1'b0;
    qbar<=1'b1;
    end
    else if(d==0)begin
    q<=1'b0;
    qbar<=1'b1;
    end
     else if(d==1)begin
    q<=1'b1;
    qbar<=1'b0;
    end
    
    end 
   
    end
endmodule
