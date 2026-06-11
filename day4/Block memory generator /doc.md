# 🗄️ Block Memory Generator (8×8 RAM) – Verilog HDL

---

## 📌 Overview

This project implements an **8×8 Block Memory Generator** using Verilog HDL.

The memory consists of:

* 8 memory locations
* 8-bit data width
* Asynchronous active-low reset
* Synchronous read and write operations

The design allows storing and retrieving data using separate write and read addresses.

---

## ⚙️ Features

* 8-bit data width
* 8 memory locations
* Independent read and write addresses
* Asynchronous active-low reset
* Synchronous write operation
* Synchronous read operation
* Simulation verified using testbench

---

## 🏗️ Architecture

```text
                   +------------------+
                   | Block Memory Gen |
                   |     (8 × 8)      |
                   +------------------+
                          |
      +-------------------+-------------------+
      |                   |                   |
      v                   v                   v

  wraddress         rdaddress           data_in
      |                   |                   |
      +-------------------+-------------------+
                          |
                          v
                     Memory Array
                     8 Locations
                     8 Bits Each
                          |
                          v
                      data_out
```

---

## 🧠 Working Principle

### Reset Operation

When:

```text
arstn = 0
```

All memory locations are cleared.

```text
mem[0] = 00
mem[1] = 00
...
mem[7] = 00
```

---

### Write Operation

When:

```text
wrenb = 1
```

Data is written into the selected address on the positive edge of the clock.

```text
mem[wraddress] ← data_in
```

---

### Read Operation

When:

```text
wrenb = 0
```

Data is read from the selected address on the positive edge of the clock.

```text
data_out ← mem[rdaddress]
```

---

## 🔌 Inputs and Outputs

### Inputs

| Signal    | Width | Description                   |
| --------- | ----- | ----------------------------- |
| clk       | 1     | System clock                  |
| arstn     | 1     | Active-low asynchronous reset |
| wrenb     | 1     | Write enable                  |
| wraddress | 3     | Write address                 |
| rdaddress | 3     | Read address                  |
| data_in   | 8     | Input data                    |

### Outputs

| Signal   | Width | Description |
| -------- | ----- | ----------- |
| data_out | 8     | Output data |

---

## 🧪 Test Cases

### Write Operations

| Address | Data Written |
| ------- | ------------ |
| 0       | 11           |
| 1       | 22           |
| 2       | 33           |
| 3       | 44           |
| 4       | 55           |
| 5       | 66           |
| 6       | 77           |
| 7       | 88           |

---

### Memory Contents After Write

```text
Address   Data
----------------
0         11
1         22
2         33
3         44
4         55
5         66
6         77
7         88
```

---

### Read Operations

| Read Address | Expected Output |
| ------------ | --------------- |
| 0            | 11              |
| 1            | 22              |
| 2            | 33              |
| 3            | 44              |
| 4            | 55              |
| 5            | 66              |
| 6            | 77              |
| 7            | 88              |

---

## 📊 Data Flow Example

### Write Phase

```text
Address 0 ← 11
Address 1 ← 22
Address 2 ← 33
Address 3 ← 44
Address 4 ← 55
Address 5 ← 66
Address 6 ← 77
Address 7 ← 88
```

### Read Phase

```text
Read Address 0 → 11
Read Address 1 → 22
Read Address 2 → 33
Read Address 3 → 44
Read Address 4 → 55
Read Address 5 → 66
Read Address 6 → 77
Read Address 7 → 88
```

---

## 📈 Expected Waveform

```text
clk        ↑    ↑    ↑    ↑    ↑    ↑    ↑    ↑

wrenb      1    1    1    1    1    1    1    1

wraddr     0    1    2    3    4    5    6    7

data_in   11   22   33   44   55   66   77   88


clk        ↑    ↑    ↑    ↑    ↑    ↑    ↑    ↑

wrenb      0    0    0    0    0    0    0    0

rdaddr     0    1    2    3    4    5    6    7

data_out  11   22   33   44   55   66   77   88
```

<img width="1508" height="838" alt="Screenshot 2026-06-11 155622" src="https://github.com/user-attachments/assets/a4450d81-3d24-48a6-bcd1-ee43c15b1701" />

---
GitHub: https://github.com/yourusername

