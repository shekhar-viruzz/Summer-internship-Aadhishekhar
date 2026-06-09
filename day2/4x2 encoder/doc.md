# 🔢 4-to-2 Encoder (Verilog HDL)

---

## 📌 Overview

This project implements a **4-to-2 Encoder** using Verilog HDL.  
It converts a **one-hot 4-bit input** into a **2-bit binary output**.

Only one input line is assumed to be HIGH at a time.

---

## ⚙️ Features

- 4-to-2 binary encoding
- Combinational logic design
- One-hot input support
- Simple case-based implementation
- Verified using testbench simulation

---

## 🧠 Working Principle

The encoder maps active input lines to a binary output:

- 0001 → 00  
- 0010 → 01  
- 0100 → 10  
- 1000 → 11  

If no input is active, output defaults to 00.

---

## 🔌 Inputs and Outputs

### Inputs
- `d[3:0]` → One-hot input

### Outputs
- `b[1:0]` → Encoded binary output

---

## 🧪 Test Cases

| Input (d) | Output (b) | Description |
|-----------|------------|-------------|
| 0001      | 00         | First input active |
| 0010      | 01         | Second input active |
| 0100      | 10         | Third input active |
| 1000      | 11         | Fourth input active |
| 0000      | 00         | Default case |

---


## 📊 Waveform Explanation

- Input `0001` → Output `00`  
- Input `0010` → Output `01`  
- Input `0100` → Output `10`  
- Input `1000` → Output `11`  

The output changes immediately because this is a **combinational circuit**.

---


## 📜 License

This project is licensed under the MIT License.
Output updates instantly (no delay logic except simulation delay)<img width="1293" height="852" alt="Screenshot 2026-06-09 215155" src="https://github.com/user-attachments/assets/47ac15f3-5e74-42e5-b6bb-e05c7c71e58c" />

