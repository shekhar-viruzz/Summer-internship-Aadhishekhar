`timescale 1ns/1ps

//=====================================================
// INTERFACE
//=====================================================

interface apb_if(input bit PCLK);

    logic PRESETn;

    logic PSEL;
    logic PENABLE;
    logic PWRITE;

    logic [7:0]  PADDR;
    logic [31:0] PWDATA;

    logic [31:0] PRDATA;
    logic PREADY;
    logic PSLVERR;

endinterface


//=====================================================
// TRANSACTION
//=====================================================

class apb_transaction;

    rand bit [7:0] addr;
    rand bit [31:0] wdata;
    rand bit write;

    bit [31:0] rdata;

    function void display(string tag="TRANS");

        $display("[%s] addr=%0h write=%0b wdata=%0h rdata=%0h",
                  tag, addr, write, wdata, rdata);

    endfunction

endclass


//=====================================================
// GENERATOR
//=====================================================

class generator;

    mailbox #(apb_transaction) gen2drv;

    int count;

    function new(mailbox #(apb_transaction) gen2drv);

        this.gen2drv = gen2drv;

    endfunction

    task run();

        apb_transaction wr;
        apb_transaction rd;

        repeat(count)
        begin

            // WRITE

            wr = new();

            wr.addr  = $urandom_range(0,255);
            wr.wdata = $urandom;
            wr.write = 1;

            gen2drv.put(wr);

            wr.display("GEN_WRITE");

            // READ SAME ADDRESS

            rd = new();

            rd.addr  = wr.addr;
            rd.write = 0;

            gen2drv.put(rd);

            rd.display("GEN_READ");

        end

    endtask

endclass


//=====================================================
// DRIVER
//=====================================================

class driver;

    virtual apb_if vif;

    mailbox #(apb_transaction) gen2drv;

    function new(
        mailbox #(apb_transaction) gen2drv,
        virtual apb_if vif
    );

        this.gen2drv = gen2drv;
        this.vif     = vif;

    endfunction

    task reset();

        vif.PSEL    <= 0;
        vif.PENABLE <= 0;
        vif.PWRITE  <= 0;
        vif.PADDR   <= 0;
        vif.PWDATA  <= 0;

        wait(vif.PRESETn);

    endtask

    task run();

        apb_transaction tr;

        forever
        begin

            gen2drv.get(tr);

            @(posedge vif.PCLK);

            // SETUP

            vif.PSEL    <= 1;
            vif.PENABLE <= 0;

            vif.PWRITE  <= tr.write;
            vif.PADDR   <= tr.addr;
            vif.PWDATA  <= tr.wdata;

            @(posedge vif.PCLK);

            // ACCESS

            vif.PENABLE <= 1;

            wait(vif.PREADY);

            @(posedge vif.PCLK);

            vif.PSEL    <= 0;
            vif.PENABLE <= 0;

        end

    endtask

endclass


//=====================================================
// MONITOR
//=====================================================

class monitor;

    virtual apb_if vif;

    mailbox #(apb_transaction) mon2scb;

    function new(
        mailbox #(apb_transaction) mon2scb,
        virtual apb_if vif
    );

        this.mon2scb = mon2scb;
        this.vif     = vif;

    endfunction

    task run();

        apb_transaction tr;

        forever
        begin

            @(posedge vif.PCLK);

            if(vif.PSEL && vif.PENABLE && vif.PREADY)
            begin

                tr = new();

                tr.addr  = vif.PADDR;
                tr.write = vif.PWRITE;

                if(vif.PWRITE)
                begin
                    tr.wdata = vif.PWDATA;
                end
                else
                begin
                    tr.rdata = vif.PRDATA;
                end

                mon2scb.put(tr);

                tr.display("MON");

            end

        end

    endtask

endclass


//=====================================================
// SCOREBOARD
//=====================================================

class scoreboard;

    mailbox #(apb_transaction) mon2scb;

    bit [31:0] ref_mem[256];

    int pass_count;
    int fail_count;

    function new(
        mailbox #(apb_transaction) mon2scb
    );

        this.mon2scb = mon2scb;

    endfunction

    task run();

        apb_transaction tr;

        forever
        begin

            mon2scb.get(tr);

            if(tr.write)
            begin

                ref_mem[tr.addr] = tr.wdata;

                $display("[SCB] WRITE addr=%0h data=%0h",
                          tr.addr,
                          tr.wdata);

            end
            else
            begin

                if(ref_mem[tr.addr] == tr.rdata)
                begin

                    pass_count++;

                    $display("[SCB] PASS addr=%0h exp=%0h got=%0h",
                              tr.addr,
                              ref_mem[tr.addr],
                              tr.rdata);

                end
                else
                begin

                    fail_count++;

                    $display("[SCB] FAIL addr=%0h exp=%0h got=%0h",
                              tr.addr,
                              ref_mem[tr.addr],
                              tr.rdata);

                end

            end

        end

    endtask

endclass


//=====================================================
// ENVIRONMENT
//=====================================================

class environment;

    generator  gen;
    driver     drv;
    monitor    mon;
    scoreboard scb;

    mailbox #(apb_transaction) gen2drv;
    mailbox #(apb_transaction) mon2scb;

    virtual apb_if vif;

    function new(virtual apb_if vif);

        this.vif = vif;

        gen2drv = new();
        mon2scb = new();

        gen = new(gen2drv);
        drv = new(gen2drv,vif);
        mon = new(mon2scb,vif);
        scb = new(mon2scb);

    endfunction

    task run();

        drv.reset();

        fork
            gen.run();
            drv.run();
            mon.run();
            scb.run();
        join_none

    endtask

endclass


//=====================================================
// TEST
//=====================================================

class test;

    environment env;

    virtual apb_if vif;

    function new(virtual apb_if vif);

        this.vif = vif;

        env = new(vif);

    endfunction

    task run();

        env.gen.count = 10;

        env.run();

        #3000;

        $display("--------------------------------");
        $display("PASS COUNT = %0d",
                  env.scb.pass_count);

        $display("FAIL COUNT = %0d",
                  env.scb.fail_count);

        $display("--------------------------------");

        $finish;

    endtask

endclass


//=====================================================
// PROGRAM
//=====================================================

program apb_program(apb_if vif);

    test t;

    initial
    begin
        t = new(vif);
        t.run();
    end

endprogram


//=====================================================
// TOP
//=====================================================

module tb;

    bit PCLK;

    initial
        PCLK = 0;

    always #5 PCLK = ~PCLK;

    apb_if intf(PCLK);

    apb_slave dut(

        .PCLK    (PCLK),
        .PRESETn (intf.PRESETn),

        .PSEL    (intf.PSEL),
        .PENABLE (intf.PENABLE),
        .PWRITE  (intf.PWRITE),

        .PADDR   (intf.PADDR),
        .PWDATA  (intf.PWDATA),

        .PRDATA  (intf.PRDATA),
        .PREADY  (intf.PREADY),
        .PSLVERR (intf.PSLVERR)

    );

    initial
    begin

        intf.PRESETn = 0;

        #20;

        intf.PRESETn = 1;

    end

    apb_program p(intf);
  initial begin
   $dumpfile("dump.vcd"); 
  $dumpvars;
  end 

endmodule
