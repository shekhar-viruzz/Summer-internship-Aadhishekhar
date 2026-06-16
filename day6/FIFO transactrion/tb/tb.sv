
//fifo transaction
class fifo_transaction;
  
  rand bit [7:0] data_in;
  rand bit wr_enb;
  rand bit rd_enb;
  
  bit [7:0] data_out;
  bit empty;
  bit full;
  
  int min;
  int max;
  
  // User-defined data boundary constraint
 constraint c_1 {
  if(wr_enb) {
    data_in > min;
    data_in < max;
  }
}
  
  
  // Prevents simultaneous read and write
  constraint c_2 { 
     wr_enb != rd_enb;
  }
  
  // Ensures active reading and writing
  constraint c_3 {
    wr_enb dist {1 := 50, 0 := 50};
    rd_enb dist {1 := 50, 0 := 50};
  }
  
constraint c_4 {
  rd_enb -> (data_in == 0);
}
  
  function void set_boundaries(int min_value, int max_value);
    this.min = min_value;
    this.max = max_value;
  endfunction
    
  function void post_randomize();
    $display("Transaction Randomized -> WR: %0b | RD: %0b | DATA_IN: %0d", 
              wr_enb, rd_enb, data_in);
  endfunction
    
  function void display(string s = "FIFO_TRANS");
    $display("[%s] WR=%0b RD=%0b DIN=%0d DOUT=%0d FULL=%0b EMPTY=%0b", 
              s, wr_enb, rd_enb, data_in, data_out, full, empty);
  endfunction  
    
endclass

module tb;
  
  fifo_transaction tx;

  initial begin
    tx = new();
    tx.set_boundaries(0, 50);

	for (int i = 0; i < 10; i++) begin
      if (tx.randomize())
        $display("Value of wr_enb is %0b, rd_enb is %0b, data_in is %0d", 			tx.wr_enb, tx.rd_enb, tx.data_in);
      else
        $display("Randomization failed");
    end
      
  end

endmodule
