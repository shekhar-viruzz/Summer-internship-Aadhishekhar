module aes_assertions(
  input logic clk,
  input logic reset_n,
  input logic OUT_valid,
  input logic [127:0] OUT_state
);

  logic prev_OUT_valid;

  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      prev_OUT_valid <= 1'b0;
    end
    else begin

      if (prev_OUT_valid && OUT_valid) begin
        $error("[ASSERTION FAILED] OUT_valid is high for more than one cycle");
      end

      if (OUT_valid) begin
        if (^OUT_state === 1'bx) begin
          $error("[ASSERTION FAILED] OUT_state contains X when OUT_valid is high");
        end
      end

      prev_OUT_valid <= OUT_valid;
    end
  end

  always @(negedge reset_n) begin
    #1;
    if (OUT_valid !== 1'b0) begin
      $error("[ASSERTION FAILED] OUT_valid not cleared during reset");
    end
  end

endmodule
