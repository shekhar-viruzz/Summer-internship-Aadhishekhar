# 📦 FIFO Verification Using SystemVerilog Interface

---

## 📌 Overview

This project demonstrates the verification of an **8×8 FIFO (First In First Out)** memory using a **SystemVerilog Interface**.

Instead of connecting every signal individually between the testbench and DUT, all FIFO signals are grouped inside a single interface.

This makes the testbench cleaner, easier to maintain, and scalable for larger designs.

---

## 🏗️ Architecture

```text
                 +------------------+
                 |     Testbench    |
                 +------------------+
                           |
                           |
                    FIFO Interface
                           |
      -------------------------------------------------
      |       |       |       |       |       |       |
     clk     rst    wrenb   rdenb   data_in  full   empty
      |       |       |       |       |       |       |
      -------------------------------------------------
                           |
                           |
                    +-------------+
                    |    FIFO     |
                    +-------------+
                           |
                           |
                       data_out
```

---

## 🔷 What is an Interface?

A SystemVerilog Interface is a construct used to bundle multiple signals together into a single object.

Instead of writing:

```systemverilog
fifo dut(
    clk,
    rst,
    wrenb,
    rdenb,
    data_in,
    data_out,
    full,
    empty
);
```

we can group all these signals inside an interface and connect them through a single interface instance.

---

## 🔷 FIFO Interface

```systemverilog
interface fifo_if;

    logic clk;
    logic rst;

    logic wrenb;
    logic rdenb;

    logic [7:0] data_in;
    logic [7:0] data_out;

    logic full;
    logic empty;

endinterface
```

---

## 🧠 Why Use an Interface?

Without Interface:

```text
Testbench
   |
   |-- clk
   |-- rst
   |-- wrenb
   |-- rdenb
   |-- data_in
   |-- data_out
   |-- full
   |-- empty
   |
  DUT
```

Many individual connections must be managed.

---

With Interface:

```text
Testbench
    |
    |---- fifo_if ----|
                      |
                     DUT
```

Only one interface instance manages all FIFO signals.

---

## ⚙️ Interface Instantiation

### Create Interface Object

```systemverilog
fifo_if fif();
```

This creates an interface instance named:

```text
fif
```

All FIFO signals now belong to this object.

Examples:

```systemverilog
fif.clk
fif.rst
fif.wrenb
fif.rdenb
fif.data_in
fif.data_out
```

---

## 🔌 DUT Connection Through Interface

```systemverilog
fifo dut(
    fif.clk,
    fif.rst,
    fif.wrenb,
    fif.rdenb,
    fif.data_in,
    fif.data_out,
    fif.full,
    fif.empty
);
```

The DUT accesses all signals directly from the interface.

---

## ⏰ Clock Generation Using Interface

Clock is generated through the interface signal:

```systemverilog
initial begin
    fif.clk = 0;

    forever
        #5 fif.clk = ~fif.clk;
end
```

Clock period:

```text
10 ns
```

Frequency:

```text
100 MHz
```

---

## 🧪 Test Scenario

### Step 1: Reset FIFO

```text
rst = 1
```

FIFO memory cleared.

---

### Step 2: Write Data

Enable write:

```text
wrenb = 1
```

Data written:

| Cycle | Data |
| ----- | ---- |
| 1     | 00   |
| 2     | 11   |
| 3     | 22   |
| 4     | 33   |
| 5     | 44   |
| 6     | 55   |
| 7     | 66   |
| 8     | 77   |

---

### Step 3: Read Data

Enable read:

```text
rdenb = 1
```

Expected output sequence:

```text
00
11
22
33
44
55
66
```

FIFO returns data in the same order it was written.

---

## 📊 Interface Signal Flow

```text
             Testbench

                  |
                  |
           +-------------+
           |  fifo_if    |
           +-------------+
            |   |   |
            |   |   |
            v   v   v

          +---------+
          |  FIFO   |
          +---------+

            ^
            |
         data_out
```

The interface acts as a communication bridge between the testbench and the FIFO.

---

## ✅ Advantages of Using Interfaces

### Reduced Connections

Instead of managing many signals separately:

```text
clk
rst
wrenb
rdenb
data_in
data_out
full
empty
```

all signals are grouped into:

```text
fifo_if
```

---

### Better Readability

Cleaner testbench code.

---

### Easier Maintenance

Adding a new signal requires modification only inside the interface.

---

### Reusability

The same interface can be reused in:

* Testbenches
* Drivers
* Monitors
* UVM Environments
* Scoreboards

---
<img width="1172" height="277" alt="Screenshot 2026-06-14 130515" src="https://github.com/user-attachments/assets/ff84e713-f0b6-4523-927e-3bf19716eb90" />


