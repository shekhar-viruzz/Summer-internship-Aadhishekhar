`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 19:17:11
// Design Name: 
// Module Name: top
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
module top(
    input clk,
    input rst,
    input wrenb,
    input rdenb,
    input [7:0] s_in,

    output [7:0] face_out,
    output [7:0] fifo_out,
    output [7:0] final_out,
    output full,
    output empty
);

wire [7:0] face_wire;
wire [7:0] fifo_wire;
wire rdenb_wire;

face_mod U1(
    s_in,
    clk,
    face_wire
);

fifo U2(
    clk,
    rst,
    wrenb,
    rdenb_wire,
    face_wire,
    fifo_wire,
    full,
    empty
);

mod_out U3(
    clk,
    rst,
    fifo_wire,
    final_out,
    rdenb_wire
);

assign face_out = face_wire;
assign fifo_out = fifo_wire;

endmodule
