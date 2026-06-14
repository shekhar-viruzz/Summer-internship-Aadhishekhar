interface fifo_if;
  logic clk;
  logic rst;
  logic wrenb;
  logic rdenb;
  logic [7:0]data_in;
  logic [7:0]data_out;
  logic full;
  logic empty;
 endinterface
module tb;
  fifo_if fif();
  fifo dut(fif.clk,fif.rst,fif.wrenb,fif.rdenb,fif.data_in,fif.data_out,fif.full,fif.empty);

  initial begin
    fif.clk=0;
    forever #5 fif.clk=~fif.clk;
  end
  initial begin
    fif.rst=1;
    fif.wrenb=0;
    fif.rdenb=0;
    fif.data_in=0;
   #20;
    fif.rst=0;
    fif.wrenb=1;
     
    for(int i=0;i<8;i++) begin
      fif.data_in = i * 8'h11;
       @(posedge fif.clk);
    end
    fif.wrenb=0;
    
    fif.rdenb=1;
    repeat(7)
    #10;
   
    fif.rdenb=0;

  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
 initial begin
   $monitor("T=%0t rst=%b wr=%b rd=%b din=%h dout=%h full=%b empty=%b",
           $time,
           fif.rst,
           fif.wrenb,
           fif.rdenb,
           fif.data_in,
           fif.data_out,
           fif.full,
           fif.empty);
   #300;
 $finish();
 end
 endmodule
    
