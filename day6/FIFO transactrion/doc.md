# 📦 FIFO Transaction Class Using SystemVerilog

---

## 📌 Overview

This project demonstrates the creation of a **SystemVerilog Transaction Class** for FIFO verification.

The transaction class is responsible for:

* Generating randomized FIFO transactions
* Applying user-defined constraints
* Controlling read/write operations
* Producing valid stimulus for verification

The class follows a constrained-random verification approach commonly used in modern verification methodologies.

---

## 🏗️ Verification Architecture

```text
                  +------------------+
                  |   Transaction    |
                  |      Class       |
                  +------------------+
                           |
                    Randomization
                           |
                    Constraint Check
                           |
                           v
                  +------------------+
                  | Generated Packet |
                  +------------------+
                           |
                           v
                       FIFO DUT
```

---

## 🔷 Transaction Class

The transaction class models a single FIFO operation.

### Random Variables

| Variable | Width | Description  |
| -------- | ----- | ------------ |
| data_in  | 8-bit | Input data   |
| wr_enb   | 1-bit | Write enable |
| rd_enb   | 1-bit | Read enable  |

---

### Non-Random Variables

| Variable | Description      |
| -------- | ---------------- |
| data_out | FIFO output data |
| full     | FIFO full flag   |
| empty    | FIFO empty flag  |
| min      | Lower boundary   |
| max      | Upper boundary   |

---

## ⚙️ Constraints

### Constraint 1: Data Range

When write is enabled, generated data must remain within user-defined boundaries.

```text
min < data_in < max
```

Example:

```text
min = 0
max = 50
```

Generated values:

```text
12
25
31
47
```

Invalid values:

```text
0
50
75
100
```

---

### Constraint 2: Read and Write Mutual Exclusion

Read and Write cannot occur simultaneously.

```text
wr_enb != rd_enb
```

Valid:

```text
WR=1 RD=0
WR=0 RD=1
```

Invalid:

```text
WR=1 RD=1
```

---

### Constraint 3: Equal Probability Distribution

Both read and write operations have equal probability.

```text
WR Enable : 50%
RD Enable : 50%
```

This ensures balanced FIFO activity.

---

### Constraint 4: Read Transaction Rule

When a read operation occurs:

```text
rd_enb = 1
```

input data is forced to:

```text
data_in = 0
```

This prevents unnecessary randomization of write data during read cycles.

---

## 🧠 User-Defined Boundaries

The transaction class allows dynamic boundary assignment.

Example:

```text
Minimum Value = 0
Maximum Value = 50
```

All generated write data will satisfy:

```text
0 < data_in < 50
```

---

## 🔄 Randomization Flow

```text
Start
  |
  v
Set Boundaries
  |
  v
Apply Constraints
  |
  v
Randomize Variables
  |
  v
Generate Transaction
  |
  v
Display Results
```

---

## 📊 Example Randomized Transactions

```text
Transaction 1
WR=1 RD=0 DATA_IN=12

Transaction 2
WR=0 RD=1 DATA_IN=0

Transaction 3
WR=1 RD=0 DATA_IN=37

Transaction 4
WR=0 RD=1 DATA_IN=0

Transaction 5
WR=1 RD=0 DATA_IN=24
```

---

## 🧪 Sample Output

```text
<img width="1003" height="527" alt="image" src="https://github.com/user-attachments/assets/1da84fcd-13a7-4433-81c0-a41558100325" />

```

---

## 📦 FIFO DUT Overview

The FIFO contains:

| Feature         | Value     |
| --------------- | --------- |
| Data Width      | 8-bit     |
| Depth           | 8 Entries |
| Write Pointer   | 3-bit     |
| Read Pointer    | 3-bit     |
| Full Detection  | Supported |
| Empty Detection | Supported |


---

## ✅ Advantages of Transaction Classes

### Reusability

The same transaction object can be reused across multiple tests.

---

### Constrained Random Verification

Generates legal and meaningful test scenarios automatically.

---

### Scalability

Additional fields and constraints can be added without modifying the DUT.

---

### Better Coverage

Random stimulus helps uncover corner cases that directed testing may miss.






