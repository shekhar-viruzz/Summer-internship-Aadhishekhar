class generator;

  mailbox #(aes_transaction) gen2drv;

  function new(input mailbox #(aes_transaction) gen2drv);
    this.gen2drv = gen2drv;
  endfunction

  task send_test(
      input string name,
      input bit [127:0] pt,
      input bit [127:0] ky,
      input bit [127:0] ct
  );
    aes_transaction tr;

    tr = new();
    tr.test_name = name;
    tr.plaintext = pt;
    tr.key = ky;
    tr.expected_ciphertext = ct;

    gen2drv.put(tr);
    tr.display("GENERATOR");
  endtask

  task run();

    send_test("AES Appendix B",
      128'h3243f6a8885a308d313198a2e0370734,
      128'h2b7e151628aed2a6abf7158809cf4f3c,
      128'h3925841d02dc09fbdc118597196a0b32);

    send_test("FIPS AES-128",
      128'h00112233445566778899aabbccddeeff,
      128'h000102030405060708090a0b0c0d0e0f,
      128'h69c4e0d86a7b0430d8cdb78070b4c55a);

    send_test("All Zero PT and Key",
      128'h00000000000000000000000000000000,
      128'h00000000000000000000000000000000,
      128'h66e94bd4ef8a2c3b884cfa59ca342b2e);

    send_test("All Ones PT and Key",
      128'hffffffffffffffffffffffffffffffff,
      128'hffffffffffffffffffffffffffffffff,
      128'hbcbf217cb280cf30b2517052193ab979);

    send_test("Zero PT All Ones Key",
      128'h00000000000000000000000000000000,
      128'hffffffffffffffffffffffffffffffff,
      128'ha1f6258c877d5fcd8964484538bfc92c);

    send_test("All Ones PT Zero Key",
      128'hffffffffffffffffffffffffffffffff,
      128'h00000000000000000000000000000000,
      128'h3f5b8cc9ea855a0afa7347d23e8d664e);

    send_test("NIST Block 1",
      128'h6bc1bee22e409f96e93d7e117393172a,
      128'h2b7e151628aed2a6abf7158809cf4f3c,
      128'h3ad77bb40d7a3660a89ecaf32466ef97);

    send_test("NIST Block 2",
      128'hae2d8a571e03ac9c9eb76fac45af8e51,
      128'h2b7e151628aed2a6abf7158809cf4f3c,
      128'hf5d3d58503b9699de785895a96fdbaaf);

    send_test("NIST Block 3",
      128'h30c81c46a35ce411e5fbc1191a0a52ef,
      128'h2b7e151628aed2a6abf7158809cf4f3c,
      128'h43b1cd7f598ece23881b00e3ed030688);

    send_test("NIST Block 4",
      128'hf69f2445df4f9b17ad2b417be66c3710,
      128'h2b7e151628aed2a6abf7158809cf4f3c,
      128'h7b0c785e27e8ad3f8223207104725dd4);

  endtask

endclass
