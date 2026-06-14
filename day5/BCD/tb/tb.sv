interface bcd_if;
  logic [3:0]a;
  logic [3:0]b;
  logic cin;
  logic [3:0]sum;
  logic cout;
endinterface

module tb;
  bcd_if bif();
  Bcd_adder dut(bif.a,bif.b,bif.cin,bif.sum,bif.cout);
  initial
       begin
       bif.a=4'b0000;
       bif.b=4'b0000;
       bif.cin=1'b0;
       #1;
       bif.a=4'b0001;
       bif.b=4'b0010;
       bif.cin=1'b0;
       #1;
       bif.a=4'b0101;
       bif.b=4'b0011;
       bif.cin=1'b0;
       #1;
       bif.a=4'b0100;
       bif.b=4'b0101;
       bif.cin=1'b0;
       #1;
       bif.a=4'b0101;
       bif.b=4'b0101;
       bif.cin=1'b0;
       #1;
       bif.a=4'b0110;
       bif.b=4'b0101;
       bif.cin=1'b0;
        #1;
       bif.a=4'b1001;
       bif.b=4'b1001;
       bif.cin=1'b0;
         #1;
       end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
  initial begin
$monitor("T=%0t : %0d + %0d + %0d = %0d%0d",
         $time,
         bif.a,
         bif.b,
         bif.cin,
         bif.cout,
         bif.sum);
    #10;
    $finish();

    end
    
    
    
endmodule

