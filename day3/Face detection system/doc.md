# 😊 Face Detection System Using FIFO and FSM (Verilog HDL)

---

## 📌 Overview

This project implements a simplified Face Detection Data Processing System using Verilog HDL.

The design consists of three modules:

* **Face Module (`face_mod`)** – Receives and forwards input data.
* **FIFO (`fifo`)** – Stores incoming data temporarily.
* **Output Controller (`mod_out`)** – Uses an FSM to read data from FIFO and generate the final output.

The modules are integrated using a top-level module named `top`.

---

## 🏗️ Block Diagram

```text
          +------------+
s_in ---->| face_mod   |
          +------------+
                 |
                 v
          +------------+
          |    FIFO    |
          +------------+
                 |
                 v
          +------------+
          |  mod_out   |
          +------------+
                 |
                 v
             final_out
```

---

## ⚙️ Features

* Modular Verilog design
* FIFO-based data buffering
* FSM-controlled output transfer
* Full and Empty FIFO flags
* Synchronous operation
* Easy integration with larger image-processing systems

---

## 🧠 Module Description

### 1. Face Module

The face module receives the input data stream and forwards it to the FIFO.

```text
s_in → face_out
```

---

### 2. FIFO Module

The FIFO stores incoming data sequentially.

#### Write Operation

Data is written when:

```text
wrenb = 1
```

#### Read Operation

Data is read when:

```text
rdenb = 1
```

#### FIFO Flags

| Signal | Description   |
| ------ | ------------- |
| full   | FIFO is full  |
| empty  | FIFO is empty |

---

### 3. Output Controller (FSM)

The output controller uses a three-state FSM.

#### States

| State | Function                    |
| ----- | --------------------------- |
| IDLE  | Waiting state               |
| S1    | Delay state                 |
| S2    | Read FIFO and update output |

---

## 🔄 FSM State Transition Diagram

```text
         +------+
         | IDLE |
         +------+
             |
             v
         +------+
         |  S1  |
         +------+
             |
             v
         +------+
         |  S2  |
         +------+
             |
             v
         +------+
         | IDLE |
         +------+
```

The FSM continuously cycles through:

```text
IDLE → S1 → S2 → IDLE → ...
```

---

## ⏱️ Output Timing

The final output is updated only during state **S2**.

Therefore, after reset:

| Positive Edge | State | final_out |
| ------------- | ----- | --------- |
| 1             | IDLE  | No Change |
| 2             | S1    | No Change |
| 3             | S2    | Updated   |
| 4             | IDLE  | Hold      |
| 5             | S1    | Hold      |
| 6             | S2    | Updated   |
| 7             | IDLE  | Hold      |
| 8             | S1    | Hold      |
| 9             | S2    | Updated   |

Thus, a new output value appears every third positive edge of the clock.

---

## 🔌 Inputs and Outputs

### Inputs

| Signal | Width | Description       |
| ------ | ----- | ----------------- |
| clk    | 1     | System clock      |
| rst    | 1     | Reset             |
| wrenb  | 1     | FIFO write enable |
| rdenb  | 1     | FIFO read enable  |
| s_in   | 8     | Input data        |

### Outputs

| Signal    | Width | Description            |
| --------- | ----- | ---------------------- |
| face_out  | 8     | Face module output     |
| fifo_out  | 8     | FIFO output            |
| final_out | 8     | Final processed output |
| full      | 1     | FIFO full flag         |
| empty     | 1     | FIFO empty flag        |

---

## 🧪 Test Cases

### Input Sequence

```text
11
22
33
44
55
66
77
```

### FIFO Contents

```text
[11] [22] [33] [44] [55] [66] [77]
```

### Expected Final Output

```text
11 → 22 → 33 → 44 → 55 → 66 → 77
```

Each value appears at `final_out` once every three clock cycles.

---

## 📈 Expected Waveform

```text
clk        ↑    ↑    ↑    ↑    ↑    ↑    ↑    ↑    ↑

state    IDLE  S1   S2  IDLE  S1   S2  IDLE  S1   S2

fifo      11   11   11   22   22   22   33   33   33

final      0    0   11   11   11   22   22   22   33
```



<img width="1571" height="832" alt="Screenshot 2026-06-10 211127" src="https://github.com/user-attachments/assets/69462d80-78be-40ea-ba9b-024a324864ce" />


