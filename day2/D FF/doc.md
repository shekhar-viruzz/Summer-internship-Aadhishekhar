# 🔁 D Flip-Flop (D FF) – Verilog HDL

---

## 📌 Overview

This project implements a **D Flip-Flop (D FF)** using Verilog HDL.  
A D Flip-Flop is a **sequential circuit** that stores a single bit of data on the **rising edge of the clock**.

It is widely used in registers, memory elements, and digital systems.

---

## ⚙️ Features

- Edge-triggered operation (positive edge)
- Synchronous data storage
- Asynchronous reset support
- Outputs Q and Q̅ (complement)
- Verified using testbench simulation

---

## 🧠 Working Principle

At every **positive clock edge**:

- If reset = 1 → Output resets to 0  
- If reset = 0 → Output follows input D  
- Q stores the value of D  
- Q̅ is always complement of Q  

---

## 🔌 Inputs and Outputs

### Inputs
- `d` → Data input  
- `clk` → Clock signal  
- `rst` → Reset signal  

### Outputs
- `q` → Stored output  
- `qbar` → Complement output  

---

## 🧪 Test Cases

| Reset | D | Clock Edge | Q | Q̅ | Description |
|-------|---|-------------|---|----|-------------|
| 1 | X | ↑ | 0 | 1 | Reset active |
| 0 | 0 | ↑ | 0 | 1 | Store 0 |
| 0 | 1 | ↑ | 1 | 0 | Store 1 |
| 0 | 1 → 0 | ↑ | Follows D | Complement | Data change test |
| 0 | X | No edge | Hold previous | Hold | No clock trigger |

---

## 📊 Waveform Explanation

- On **reset = 1**, Q becomes 0 immediately  
- On each **rising clock edge**, Q updates to D  
- Q̅ always remains opposite of Q  
- Between clock edges → output remains stable  

### ⏱ Key Observation:
This is a **sequential circuit**, so output changes only on clock edges, not continuously.

---

## 🔄 Functional Behavior

1. Clock signal runs continuously  
2. At each rising edge:
   - Reset checked first  
   - Then D is sampled  
3. Output Q is updated  
4. Q̅ is generated as complement  

---

## 📂 Project Structure

- D Flip-Flop design module  
- Testbench file  
- Simulation waveform output  
<img width="945" height="420" alt="Screenshot 2026-06-09 220109" src="https://github.com/user-attachments/assets/bfbe6513-09e2-4388-882e-79604aadf268" />

