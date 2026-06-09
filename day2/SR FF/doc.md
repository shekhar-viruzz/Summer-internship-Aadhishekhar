# 🔁 SR Flip-Flop (SR FF) – Verilog HDL

---

## 📌 Overview

This project implements an **SR Flip-Flop (Set-Reset Flip-Flop)** using Verilog HDL.  
It is a **sequential memory element** that stores 1-bit data based on **Set (S)** and **Reset (R)** inputs at the rising edge of the clock.

---

## ⚙️ Features

- Positive edge-triggered operation
- Synchronous behavior
- Asynchronous reset support
- Set, Reset, Hold, and Invalid states
- Complement output (Q̅)
- Verified using testbench simulation

---

## 🧠 Working Principle

At every **positive clock edge**:

- If `rst = 1` → Output resets (Q = 0)
- If `S = 0, R = 0` → Hold previous state
- If `S = 1, R = 0` → Set state (Q = 1)
- If `S = 0, R = 1` → Reset state (Q = 0)
- If `S = 1, R = 1` → Invalid state (Q = X)

---

## 🔌 Inputs and Outputs

### Inputs
- `S` → Set input  
- `R` → Reset input  
- `clk` → Clock signal  
- `rst` → Reset signal  

### Outputs
- `Q` → Output state  
- `Q̅` → Complement output  

---

## 🧪 Test Cases

| Reset | S | R | Clock Edge | Q | Q̅ | Description |
|------|---|---|-------------|---|----|-------------|
| 1 | X | X | ↑ | 0 | 1 | Reset active |
| 0 | 0 | 0 | ↑ | Hold | Hold | Memory state |
| 0 | 1 | 0 | ↑ | 1 | 0 | Set operation |
| 0 | 0 | 1 | ↑ | 0 | 1 | Reset operation |
| 0 | 1 | 1 | ↑ | X | X | Invalid state |

---


## 📊 Waveform Explanation

- When `rst = 1` → Q forced to 0  
- At `S = 1, R = 0` → Q becomes 1  
- At `S = 0, R = 1` → Q becomes 0  
- At `S = 0, R = 0` → Q holds previous value  
- At `S = 1, R = 1` → output becomes undefined (X state)  

### ⏱ Key Observation:
The SR Flip-Flop stores data only on **clock edge transitions**, making it a sequential memory element.

---

## 🔄 Functional Behavior

1. Clock runs continuously  
2. At each rising edge:
   - Reset checked first  
   - Then S and R inputs evaluated  
3. Output Q updates accordingly  
4. Q̅ always remains complement  

---

## 📂 Project Structure

- SR Flip-Flop design module  
- Testbench file  
- Simulation waveform output  

---
<img width="1037" height="647" alt="Screenshot 2026-06-09 220616" src="https://github.com/user-attachments/assets/7e514403-9838-4ad5-9736-4c1479133c67" />
