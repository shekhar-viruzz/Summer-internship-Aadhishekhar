module Round (
    input wire clk, 
    input wire reset_n,

    input wire         IN_valid,
    input wire [127:0] IN_state,
    input wire [127:0] RoundKey,
    input wire         final_round,   // 1 = bypass MixColumns (round 10), 0 = normal round

    output wire         OUT_valid,
    output wire [127:0] OUT_state
);

    wire SubBytes2AddRoundKey_valid;
    wire [127:0] SubBytes2ShiftRows_state, ShiftRows2Mux_state, MixColumns2Mux_state, Mux2AddRoundKey_state;


    SubBytes SubBytes_inst(
        .clk(clk), 
        .reset_n(reset_n),
        .IN_valid(IN_valid),
        .IN_state(IN_state),
        .OUT_valid(SubBytes2AddRoundKey_valid),
        .OUT_state(SubBytes2ShiftRows_state)
    );

    ShiftRows ShiftRows_inst(
        .IN_state(SubBytes2ShiftRows_state),
        .OUT_state(ShiftRows2Mux_state)
    );

    MixColumns MixColumns_inst(
        .IN_state(ShiftRows2Mux_state),
        .OUT_state(MixColumns2Mux_state)
    );

    // Standard rounds (1-9) use the MixColumns result; the final round
    // (10) skips MixColumns per the AES spec and uses ShiftRows directly.
    assign Mux2AddRoundKey_state = final_round ? ShiftRows2Mux_state : MixColumns2Mux_state;

    AddRoundKey AddRoundKey_inst(
        .clk(clk), 
        .reset_n(reset_n),
        .IN_valid(SubBytes2AddRoundKey_valid),
        .IN_state(Mux2AddRoundKey_state),
        .RoundKey(RoundKey),
        .OUT_valid(OUT_valid),
        .OUT_state(OUT_state)
    );

endmodule
