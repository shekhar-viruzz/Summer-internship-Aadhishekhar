# 🔢 BCD Adder Verification Using SystemVerilog Interface

---

## 📌 Overview

This project demonstrates the verification of a **BCD (Binary Coded Decimal) Adder** using a **SystemVerilog Interface**.

The design consists of:

- Full Adder
- Ripple Carry Adder
- BCD Adder
- SystemVerilog Interface-Based Testbench

The interface groups all DUT signals into a single reusable object, making the testbench cleaner and easier to maintain.

---

## 🏗️ Block Diagram

```text
              +----------------+
              |   Testbench    |
              +----------------+
                      |
                      |
                 +---------+
                 | bcd_if  |
                 +---------+
                      |
                      |
                      v
              +----------------+
              |   BCD Adder    |
              +----------------+
                 |          |
                 v          v
               sum        cout
```

---

## 🔷 What is an Interface?

A SystemVerilog Interface is a container that groups related signals together.

Instead of declaring multiple signals separately:

```systemverilog
logic [3:0] a;
logic [3:0] b;
logic cin;
logic [3:0] sum;
logic cout;
```

all signals are bundled inside a single interface.

---

## 🔷 BCD Interface

```systemverilog
interface bcd_if;
  logic [3:0] a;
  logic [3:0] b;
  logic cin;
  logic [3:0] sum;
  logic cout;
endinterface
```

---

## ⚙️ Interface Instantiation

The interface is instantiated in the testbench:

```systemverilog
bcd_if bif();
```

All signals are now accessed using dot notation:

```systemverilog
bif.a
bif.b
bif.cin
bif.sum
bif.cout
```

---

## 🔌 DUT Connection Through Interface

```systemverilog
Bcd_adder dut(
    bif.a,
    bif.b,
    bif.cin,
    bif.sum,
    bif.cout
);
```

The DUT communicates directly with the interface signals.

---

## 🧠 Working Principle

### Step 1: Binary Addition

The first Ripple Carry Adder performs:

```text
A + B + Cin
```

---

### Step 2: BCD Correction

If the binary sum exceeds 9, the circuit adds:

```text
0110 (Decimal 6)
```

to produce a valid BCD result.

---

### Step 3: Final Output

The corrected BCD sum appears at:

```text
sum
```

and the carry digit appears at:

```text
cout
```

---

## 🧪 Test Cases

| A | B | Cin | Decimal Result | BCD Output |
|---|---|-----|---------------|------------|
| 0000 | 0000 | 0 | 0 | 0000 |
| 0001 | 0010 | 0 | 3 | 0011 |
| 0101 | 0011 | 0 | 8 | 1000 |
| 0100 | 0101 | 0 | 9 | 1001 |
| 0101 | 0101 | 0 | 10 | Cout=1, Sum=0000 |
| 0110 | 0101 | 0 | 11 | Cout=1, Sum=0001 |
| 1001 | 1001 | 0 | 18 | Cout=1, Sum=1000 |

---

## 📊 Expected Results

### Example 1

```text
1 + 2 = 3
```

Output:

```text
cout = 0
sum  = 0011
```

---

### Example 2

```text
5 + 5 = 10
```

Output:

```text
cout = 1
sum  = 0000
```

---

### Example 3

```text
9 + 9 = 18
```

Output:

```text
cout = 1
sum  = 1000
```

---

## 📈 Expected Waveform

```text
Time      A      B    Cin    Cout   Sum
------------------------------------------------
0ns      0000  0000   0       0    0000
1ns      0001  0010   0       0    0011
2ns      0101  0011   0       0    1000
3ns      0100  0101   0       0    1001
4ns      0101  0101   0       1    0000
5ns      0110  0101   0       1    0001
6ns      1001  1001   0       1    1000
```

---

## 🔄 Signal Flow Using Interface

```text
            Testbench
                 |
                 |
             bcd_if
                 |
     -----------------------
     |         |          |
     v         v          v
     A         B         Cin
                 |
                 v
            BCD Adder
                 |
         ----------------
         |              |
         v              v
        Sum           Cout
```

---

## ✅ Advantages of Using Interfaces

### Reduced Connections

Instead of handling multiple individual signals:

```text
a
b
cin
sum
cout
```

all signals are grouped into:

```text
bcd_if
```

---

### Better Readability

Cleaner and more organized testbench code.

---

### Easy Maintenance

Adding or modifying signals requires changes only inside the interface.

---

### Reusability

Interfaces can be reused in:

- Testbenches
- Drivers
- Monitors
- Scoreboards
- UVM Environments
<img width="1843" height="307" alt="Screenshot 2026-06-14 140637" src="https://github.com/user-attachments/assets/990b0d3e-e62a-47d5-91ad-dd326c7d76d4" />
<img width="691" height="250" alt="Screenshot 2026-06-14 140606" src="https://github.com/user-attachments/assets/5f0101a3-d3d7-4cd4-8a43-4d774ea83537" />



GitHub: https://github.com/yourusername
