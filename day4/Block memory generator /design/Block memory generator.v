`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2026 14:09:13
// Design Name: 
// Module Name: Block_memory_gen
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


module block_memory_gen(
    input clk,
    input arstn,
    input wrenb,
    input [2:0] wraddress,
    input [2:0] rdaddress,
    input [7:0] data_in,
    output reg [7:0] data_out
);

reg [7:0] mem[7:0];
integer i;

always @(posedge clk or negedge arstn)
begin
    if(!arstn)
    begin
        for(i=0;i<8;i=i+1)
            mem[i] <= 8'b0;

        data_out <= 8'b0;
    end
    else
    begin
        if(wrenb)
            mem[wraddress] <= data_in;
        else
            data_out <= mem[rdaddress];
    end
end

endmodule
