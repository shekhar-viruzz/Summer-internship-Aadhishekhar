# 🔍 Sequence Detector (1110) – Verilog HDL

---

## 📌 Overview

This project implements a **Sequence Detector** in Verilog HDL to detect the binary sequence **1110** from a serial input stream.

A **Finite State Machine (FSM)** is used to track the received bits and generate an output when the target sequence is detected.

---

## ⚙️ Features

- Detects the sequence **1110**
- FSM-based implementation
- Synchronous reset
- Serial input processing
- Detection output asserted when sequence is found
- Verified using simulation testbench

---

## 🧠 Working Principle

The detector continuously monitors the serial input (`din`).

The FSM transitions through states as follows:

| State | Meaning |
|---------|---------|
| IDLE | Initial state |
| S1 | Received `1` |
| S2 | Received `11` |
| S3 | Received `111` |

When the FSM is in **S3** and receives a **0**, the sequence **1110** is detected and the output `detected` becomes HIGH.

---
## 🔄 State Transition Diagram

```text
                 din=1
        +-------------------+
        |                   |
        v                   |
     +------+    din=1   +------+
     | IDLE | ---------> |  S1  |
     +------+            +------+
        ^                   |
        |                   | din=1
        |                   v
      din=0              +------+
        |                |  S2  |
        |                +------+
        |                   |
        |                   | din=1
        |                   v
        |                +------+
        +--------------  |  S3  |
          din=0          +------+
                            |
                            | din=0
                            | detected=1
                            v
                         +------+
                         | IDLE |
                         +------+

```

### State Description

| State | Meaning |
|---------|---------|
| IDLE | No matching bits received |
| S1 | Received `1` |
| S2 | Received `11` |
| S3 | Received `111` |

### State Transition Table

| Present State | Input (din) | Next State | Detected |
|---------------|------------|------------|----------|
| IDLE | 0 | IDLE | 0 |
| IDLE | 1 | S1 | 0 |
| S1 | 0 | IDLE | 0 |
| S1 | 1 | S2 | 0 |
| S2 | 0 | IDLE | 0 |
| S2 | 1 | S3 | 0 |
| S3 | 0 | IDLE | 1 |
| S3 | 1 | S3 | 0 |


## 🔌 Inputs and Outputs

### Inputs
- `clk` → Clock signal
- `rst` → Synchronous reset
- `din` → Serial input stream

### Output
- `detected` → Sequence detection output

---

## 🧪 Test Cases

### Test Case 1: Sequence Detected

| Clock Cycle | Input (`din`) | State | Detected |
|------------|--------------|--------|----------|
| 1 | 1 | S1 | 0 |
| 2 | 1 | S2 | 0 |
| 3 | 1 | S3 | 0 |
| 4 | 0 | IDLE | 1 |

Result: **Sequence 1110 detected**

---

### Test Case 2: Incomplete Sequence

| Input Stream |
|-------------|
| 1101 |

Result: **Not Detected**

---

### Test Case 3: No Matching Sequence

| Input Stream |
|-------------|
| 1010 |

Result: **Not Detected**

---

## 📊 Testbench Verification

The testbench applies the sequence:

```text
1 → 1 → 1 → 0
```

Expected output:

```text
detected = 1
```

after the final `0` is received.

---

## 📈 Expected Waveform

```text
clk      _/‾\_/‾\_/‾\_/‾\_/‾\_

din      1    1    1    0

state   IDLE S1   S2   S3  IDLE

detected 0    0    0    1
```

---

## 📊 Waveform Explanation

1. Reset initializes the FSM to **IDLE**.
2. First `1` moves FSM to **S1**.
3. Second `1` moves FSM to **S2**.
4. Third `1` moves FSM to **S3**.
5. Final `0` completes the sequence **1110**.
6. `detected` becomes HIGH for one detection event.

---
<img width="977" height="695" alt="Screenshot 2026-06-10 113121" src="https://github.com/user-attachments/assets/9896982a-448f-4ecd-aa7f-1e53b35442d6" />

