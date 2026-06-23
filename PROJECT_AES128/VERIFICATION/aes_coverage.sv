module aes_coverage(
  input logic clk,
  input logic reset_n,
  input logic IN_valid,
  input logic [127:0] IN_state,
  input logic [127:0] key,
  input logic OUT_valid
);

  covergroup aes_cg @(posedge clk);

    coverpoint reset_n {
      bins reset_active  = {0};
      bins reset_release = {1};
    }

    coverpoint IN_valid {
      bins input_seen = {1};
    }

    coverpoint OUT_valid {
      bins output_seen = {1};
    }

    coverpoint IN_state {
      bins all_zero = {128'h00000000000000000000000000000000};
      bins all_ones = {128'hffffffffffffffffffffffffffffffff};
      bins others = default;
    }

    coverpoint key {
      bins all_zero = {128'h00000000000000000000000000000000};
      bins all_ones = {128'hffffffffffffffffffffffffffffffff};
      bins others = default;
    }

  endgroup

  aes_cg cg;

  initial begin
    cg = new();
  end

  final begin
    $display("========================================");
    $display("FUNCTIONAL COVERAGE = %0.2f %%", cg.get_coverage());
    $display("========================================");
  end

endmodule
