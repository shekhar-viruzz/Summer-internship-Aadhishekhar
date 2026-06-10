`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 15:32:00
// Design Name: 
// Module Name: mod_out_tb
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
//////////////////////////////////////////////////////////////////////////////////end

module mod_out_tb();

reg clk_tb;
reg rst_tb;
reg [7:0] din_tb;

wire [7:0] dout_tb;

mod_out dut(
    clk_tb,
    rst_tb,
    din_tb,
    dout_tb
);

initial
begin
    clk_tb = 0;
end

always #5 clk_tb = ~clk_tb;

initial
begin
    rst_tb = 1;
    din_tb = 8'h11;

    #10;
    rst_tb = 0;

    // Keep each value for 3 clock cycles
    din_tb = 8'h11; #30;
    din_tb = 8'h22; #30;
    din_tb = 8'h33; #30;
    din_tb = 8'h44; #30;

    #20;
    $finish;
end

endmodule
