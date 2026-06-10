`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 19:17:48
// Design Name: 
// Module Name: top_tb
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
module top_tb();

reg clk_tb;
reg rst_tb;
reg wrenb_tb;
reg rdenb_tb;
reg [7:0] s_in_tb;

wire [7:0] face_out_tb;
wire [7:0] fifo_out_tb;
wire [7:0] final_out_tb;
wire full_tb;
wire empty_tb;

top dut(
    clk_tb,
    rst_tb,
    wrenb_tb,
    rdenb_tb,
    s_in_tb,
    face_out_tb,
    fifo_out_tb,
    final_out_tb,
    full_tb,
    empty_tb
);

initial
begin
    clk_tb = 0;
end

always #5 clk_tb = ~clk_tb;

initial
begin
    rst_tb   = 1;
    wrenb_tb = 0;
    rdenb_tb = 0;
    s_in_tb  = 8'h00;

    #10;
    rst_tb = 0;

    // Write data through face_mod into FIFO
    wrenb_tb = 1;

    s_in_tb = 8'h11; #10;
    s_in_tb = 8'h22; #10;
    s_in_tb = 8'h33; #10;
    s_in_tb = 8'h44; #10;
    s_in_tb = 8'h55; #10;
    s_in_tb = 8'h66; #10;
    s_in_tb = 8'h77; #10;

    wrenb_tb = 0;

    // Start FIFO reads
    #20;
    rdenb_tb = 1;

    #120;

    rdenb_tb = 0;

    #20;
    $finish;
end

endmodule