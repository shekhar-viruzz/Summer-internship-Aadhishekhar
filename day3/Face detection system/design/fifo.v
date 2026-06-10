`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 18:56:17
// Design Name: 
// Module Name: fifo
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



module fifo(
    input clk,
    input rst,
    input wrenb,
    input rdenb,
    input [7:0] data_in,
    output reg [7:0] data_out,
    output full,
    output empty
);

reg [7:0] mem [7:0];
reg [2:0] wr_ptr;
reg [2:0] rd_ptr;
integer i;

// Status flags
assign full  = ((wr_ptr + 3'b001) == rd_ptr);
assign empty = (wr_ptr == rd_ptr);

// Sequential logic
always @(posedge clk)
begin
    if(rst)
    begin
        for(i=0;i<8;i=i+1)
            mem[i] <= 8'b0;

        wr_ptr   <= 3'b000;
        rd_ptr   <= 3'b000;
        data_out <= 8'b00000000;
    end
    else
    begin
        // Write
        if(wrenb && !full)
        begin
            mem[wr_ptr] <= data_in;
            wr_ptr <= wr_ptr + 3'b001;
        end

        // Read
        if(rdenb && !empty)
        begin
            data_out <= mem[rd_ptr];
            rd_ptr <= rd_ptr + 3'b001;
        end
    end
end
endmodule

