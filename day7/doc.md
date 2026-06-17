# 🔷 APB Slave Verification Using SystemVerilog

---

## 📌 Overview

This project verifies an APB (Advanced Peripheral Bus) Slave using a layered SystemVerilog testbench architecture.

The verification environment consists of:

- Interface
- Transaction
- Generator
- Driver
- Monitor
- Scoreboard
- Environment
- Test
- Program Block

The testbench automatically generates APB write and read transactions, drives them to the DUT, monitors bus activity, and checks correctness using a reference model.

---

# 🏗️ Verification Architecture

```text
                   +-------------+
                   |    TEST     |
                   +-------------+
                          |
                          v
                   +-------------+
                   | ENVIRONMENT |
                   +-------------+
                    |    |    |
                    |    |    |
                    v    v    v

              +------+ +------+ +------+
              | GEN  | | DRV  | | MON  |
              +------+ +------+ +------+
                  |       |        |
                  |       |        |
                  v       v        v

               gen2drv   APB IF  mon2scb
                  |       |        |
                  +-------+--------+
                          |
                          v

                     +---------+
                     | APB DUT |
                     +---------+
                          |
                          v

                     +---------+
                     | SCOREBD |
                     +---------+
```

---

# 🔹 APB Interface

The interface bundles all APB signals together.

```text
Signals Included:

PCLK
PRESETn

PSEL
PENABLE
PWRITE

PADDR
PWDATA

PRDATA
PREADY
PSLVERR
```

### Purpose

- Reduces connection complexity
- Provides a common communication channel
- Simplifies driver and monitor coding

---

# 🔹 Transaction Class

The transaction class represents a single APB transfer.

### Random Variables

| Variable | Description |
|-----------|-------------|
| addr | APB Address |
| wdata | Write Data |
| write | Read/Write Control |

### Non-Random Variables

| Variable | Description |
|-----------|-------------|
| rdata | Read Data |

### Example Transaction

### Write Transaction

```text
Address = 0x25
Write   = 1
Data    = 0x12345678
```

### Read Transaction

```text
Address = 0x25
Write   = 0
```

---

# 🔹 Generator

The generator creates transactions and sends them to the driver using a mailbox.

### Functionality

For each iteration:

1. Generate a WRITE transaction
2. Generate a READ transaction for the same address
3. Send both transactions to the driver

### Example

```text
WRITE  Addr=25 Data=12345678

READ   Addr=25
```

This allows immediate checking of data integrity.

---

# 🔹 Driver

The driver converts transactions into APB protocol signals.

### APB Write Sequence

```text
Clock 1

PSEL    = 1
PENABLE = 0

(SETUP PHASE)
```

```text
Clock 2

PSEL    = 1
PENABLE = 1

(ACCESS PHASE)
```

```text
Wait for

PREADY = 1
```

Transaction completes.

---

### Driver Flow

```text
Receive Transaction
        |
        v
Setup Phase
        |
        v
Access Phase
        |
        v
Wait PREADY
        |
        v
Finish Transfer
```

---

# 🔹 Monitor

The monitor observes APB bus activity.

### Capture Condition

```text
PSEL    = 1
PENABLE = 1
PREADY  = 1
```

When all are active:

- Capture address
- Capture write/read information
- Capture write data or read data

Then send transaction to scoreboard.

---

# 🔹 Scoreboard

The scoreboard acts as a reference model.

### Reference Memory

```text
ref_mem[256]
```

Stores expected values.

---

### Write Checking

When write occurs:

```text
ref_mem[address] = data
```

---

### Read Checking

Compare:

```text
Expected = ref_mem[address]

Actual   = DUT Read Data
```

---

### PASS Example

```text
Expected = 12345678

Received = 12345678

PASS
```

---

### FAIL Example

```text
Expected = 12345678

Received = ABCDEF00

FAIL
```

---

# 🔹 Environment

The environment connects all verification components.

### Components Created

```text
Generator
Driver
Monitor
Scoreboard
```

### Mailboxes Created

```text
gen2drv
mon2scb
```

### Responsibilities

- Construct components
- Connect mailboxes
- Start execution

---

# 🔹 Test

The test controls the overall simulation.

### Configuration

```text
Transaction Count = 10
```

### Flow

```text
Create Environment
        |
        v
Set Count
        |
        v
Run Environment
        |
        v
Wait
        |
        v
Print Results
```

---

# 🔹 Program Block

The program block creates the test and starts execution.

```text
Create Test
      |
      v
Run Test
```

---

# 🔹 APB Slave DUT

The DUT implements a basic APB Slave.

### Internal Memory

```text
256 Locations

Address Range:
0x00 - 0xFF
```

### Supported Operations

- Write
- Read
- Ready Response
- Error Response

---

# 🔹 APB State Machine

```text
            +------+
            | IDLE |
            +------+
                |
                | PSEL
                v

           +--------+
           | SETUP  |
           +--------+
                |
                v

          +---------+
          | ACCESS  |
          +---------+
                |
         PREADY=1
                |
       +--------+--------+
       |                 |
       v                 v

    IDLE             SETUP
```

---

# 🔹 Expected Simulation Flow

```text
RESET

↓

WRITE Address A

↓

READ Address A

↓

Monitor Captures Transaction

↓

Scoreboard Checks Data

↓

PASS / FAIL

↓

Repeat 10 Times
```

---

# 📊 Example Output

```text
[GEN_WRITE] addr=25 write=1 wdata=12345678

[GEN_READ ] addr=25 write=0

[MON] addr=25 write=1 wdata=12345678

[SCB] WRITE addr=25 data=12345678

[MON] addr=25 write=0 rdata=12345678

[SCB] PASS addr=25 exp=12345678 got=12345678
```

---

# 📈 Final Results

```text
--------------------------------
PASS COUNT = 10
FAIL COUNT = 0
--------------------------------
```

---
<img width="1807" height="290" alt="Screenshot 2026-06-17 185140" src="https://github.com/user-attachments/assets/ee8edd36-7734-4ca0-96f0-a0bfcfd96e52" />
<img width="638" height="640" alt="Screenshot 2026-06-17 185257" src="https://github.com/user-attachments/assets/20f6fd9d-2731-4617-bb61-19864277e66b" />

