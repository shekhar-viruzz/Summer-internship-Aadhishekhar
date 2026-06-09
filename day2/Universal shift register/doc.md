# 🔄 Universal Shift Register (4-bit) – Verilog HDL

---

## 📌 Overview

This project implements a **4-bit Universal Shift Register** using Verilog HDL.  
It is a **multi-mode sequential circuit** capable of performing:

- SISO (Serial In Serial Out)  
- SIPO (Serial In Parallel Out)  
- PISO (Parallel In Serial Out)  
- PIPO (Parallel In Parallel Out)  

The operation is controlled using a **2-bit mode selector**.

---

## ⚙️ Features

- 4-bit register design
- Supports all shift register types
- Mode-based operation control
- Serial and parallel data handling
- Clock-driven sequential circuit
- Reset support

---

## 🧠 Working Principle

The register operates based on `mod[1:0]`:

| Mode | Operation |
|------|----------|
| 00 | SISO |
| 01 | SIPO |
| 10 | PISO |
| 11 | PIPO |

Each mode defines how data is shifted or loaded:

- Shift operation moves bits right
- Load operation stores or outputs data
- Serial input enters via `sin`
- Parallel input enters via `pin`

---

## 🔌 Inputs and Outputs

### Inputs
- `clk` → Clock signal  
- `rst` → Reset  
- `sin` → Serial input  
- `shift` → Shift enable  
- `load` → Load enable  
- `pin[3:0]` → Parallel input  
- `mod[1:0]` → Mode select  

### Outputs
- `sout` → Serial output  
- `pout[3:0]` → Parallel output  

---

## 🧪 Test Cases

| Mode | Operation | Input Type | Output | Description |
|------|----------|------------|--------|-------------|
| 00 | SISO | Serial | Serial | Bit shifted out serially |
| 01 | SIPO | Serial | Parallel | Serial data stored in register |
| 10 | PISO | Parallel | Serial | Parallel load then shift out |
| 11 | PIPO | Parallel | Parallel | Direct parallel transfer |

---

## 📊 Simulation Scenarios

### 🔹 SISO Mode (00)
- Serial bits shifted in one by one
- Output observed at `sout`

### 🔹 SIPO Mode (01)
- Serial input stored in register
- Final value appears on `pout`

### 🔹 PISO Mode (10)
- Parallel data loaded
- Shifted out serially via `sout`

### 🔹 PIPO Mode (11)
- Parallel input directly transferred to output

---

## 📈 Output Waveform


::contentReference[oaicite:0]{index=0}


---

## 📊 Waveform Explanation

- **Reset phase** → All outputs become 0  
- **Mode 00 (SISO)** → Serial bits shift out sequentially  
- **Mode 01 (SIPO)** → Serial input builds parallel output  
- **Mode 10 (PISO)** → Parallel load then serial shift-out  
- **Mode 11 (PIPO)** → Direct parallel transfer  

### ⏱ Key Observation:
Each mode behaves independently based on `mod` selection, making this a **multi-functional register system**.

---

## 🔄 Functional Behavior

1. Clock triggers state changes  
2. Reset initializes register  
3. Mode selects operation type  
4. Shift/load controls data movement  
5. Outputs update accordingly  

---

## 📂 Project Structure

- Universal Shift Register design module  
- Testbench file  
- Simulation waveform output  

---

<img width="1336" height="570" alt="Screenshot 2026-06-09 221148" src="https://github.com/user-attachments/assets/b48504c1-9a0a-4a57-8eab-6913da98596c" />

