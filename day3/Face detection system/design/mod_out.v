`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 15:30:20
// Design Name: 
// Module Name: mod_out
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
module mod_out(
    input clk,
    input rst,
    input [7:0] din,
    output reg [7:0] dout,
    output reg rdenb
);

parameter IDLE = 2'b00;
parameter S1   = 2'b01;
parameter S2   = 2'b10;

reg [1:0] ps,ns;

always @(posedge clk)
begin
    if(rst)
    begin
        ps    <= IDLE;
        dout  <= 8'b0;
        rdenb <= 1'b0;
    end
    else
    begin
        ps <= ns;

        case(ps)

        IDLE:
        begin
            rdenb <= 1'b0;
        end

        S1:
        begin
            rdenb <= 1'b0;
        end

        S2:
        begin
            dout  <= din;
            rdenb <= 1'b1;   // Read next FIFO value
        end

        endcase
    end
end

always @(*)
begin
    case(ps)
        IDLE : ns = S1;
        S1   : ns = S2;
        S2   : ns = IDLE;
        default : ns = IDLE;
    endcase
end

endmodule