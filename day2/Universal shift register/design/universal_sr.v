`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 15:49:31
// Design Name: 
// Module Name: universal_sr
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


module universal_sr(
    input clk,
    input rst,
    input sin,
    input shift,
    input load,
    input [3:0] pin,
    input [1:0] mod,
    output reg sout,
    output reg [3:0] pout
);

reg [3:0] temp;

always @(posedge clk)
begin
    if(rst)
    begin
        temp <= 4'b0000;
        sout <= 1'b0;
        pout <= 4'b0000;
    end
    else
    begin
        case(mod)

        2'b00:   // SISO
        begin
            if(shift)
            begin
                temp <= temp >> 1;
                temp[3] <= sin;
            end
            else if(load)
            begin
                sout <= temp[0];
            end
        end

        2'b01:   // SIPO
        begin
            if(shift)
            begin
                temp <= temp >> 1;
                temp[3] <= sin;
            end
            else if(load)
            begin
                pout <= temp;
            end
        end

        2'b10:   // PISO
        begin
            if(shift)
            begin
                temp <= pin;
            end
            else if(load)
            begin
                sout <= temp[0];
                temp <= temp >> 1;
            end
        end

        2'b11:   // PIPO
        begin
            if(shift)
            begin
                temp <= pin;
            end
            else if(load)
            begin
                pout <= temp;
            end
        end

        default:
        begin
            temp <= 4'b0000;
            sout <= 1'b0;
            pout <= 4'b0000;
        end

        endcase
    end
end

endmodule