`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2026 15:25:43
// Design Name: 
// Module Name: Block_memory_generator_tb
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
module block_memory_gen_tb();

reg clk_tb;
reg arstn_tb;
reg wrenb_tb;
reg [2:0] wraddress_tb;
reg [2:0] rdaddress_tb;
reg [7:0] data_in_tb;

wire [7:0] data_out_tb;

block_memory_gen dut(
    clk_tb,
    arstn_tb,
    wrenb_tb,
    wraddress_tb,
    rdaddress_tb,
    data_in_tb,
    data_out_tb
);

initial
begin
    clk_tb = 0;
end

always #5 clk_tb = ~clk_tb;

initial
begin
    arstn_tb     = 0;
    wrenb_tb     = 0;
    wraddress_tb = 3'b000;
    rdaddress_tb = 3'b000;
    data_in_tb   = 8'h00;

    #10;
    arstn_tb = 1;

  
    wrenb_tb = 1;

    wraddress_tb = 3'd0; data_in_tb = 8'h11; #10;
    wraddress_tb = 3'd1; data_in_tb = 8'h22; #10;
    wraddress_tb = 3'd2; data_in_tb = 8'h33; #10;
    wraddress_tb = 3'd3; data_in_tb = 8'h44; #10;
    wraddress_tb = 3'd4; data_in_tb = 8'h55; #10;
    wraddress_tb = 3'd5; data_in_tb = 8'h66; #10;
    wraddress_tb = 3'd6; data_in_tb = 8'h77; #10;
    wraddress_tb = 3'd7; data_in_tb = 8'h88; #10;

    wrenb_tb = 0;

    rdaddress_tb = 3'd0; #10;
    rdaddress_tb = 3'd1; #10;
    rdaddress_tb = 3'd2; #10;
    rdaddress_tb = 3'd3; #10;
    rdaddress_tb = 3'd4; #10;
    rdaddress_tb = 3'd5; #10;
    rdaddress_tb = 3'd6; #10;
    rdaddress_tb = 3'd7; #10;

    #20;
    $finish;
end

endmodule
