🔢 4-to-2 Encoder (Verilog HDL)
📌 Overview

This project implements a 4-to-2 Encoder using Verilog HDL.
An encoder converts one-hot input data (4-bit) into a 2-bit binary output, reducing multiple input lines into fewer output lines.

Only one input line is assumed to be HIGH at a time.

⚙️ Features
4-to-2 binary encoding
One-hot input support
Combinational logic design
Priority-free basic encoder (valid for single active input)
Simulation verified using testbench
🧠 Working Principle

The encoder maps active input lines to binary outputs:

Input (d)	Output (b)
0001	00
0010	01
0100	10
1000	11
Key idea:
Only one input should be active at a time
Output represents the binary position of active input
🔌 Inputs and Outputs
Inputs:
d[3:0] → One-hot input signal
Outputs:
b[1:0] → Encoded binary output
🧪 Test Cases
Test Case	Input d	Output b	Description
TC1	0001	00	First input active
TC2	0010	01	Second input active
TC3	0100	10	Third input active
TC4	1000	11	Fourth input active
TC5	0000	00	Default case
TC6	Invalid (multiple 1s)	00	Undefined behavior handled by default
📈 Output Waveform (Simulation Results)
📊 Waveform Explanation

During simulation:

TC1 (0001) → Output = 00
TC2 (0010) → Output = 01
TC3 (0100) → Output = 10
TC4 (1000) → Output = 11
Default case (0000 or invalid) → Output = 00
⏱ Key Observation:

The output changes immediately with input since this is a combinational circuit (no clock required).

🔄 Functional Behavior
Input is applied on d[3:0]
Case decoding logic checks active line
Corresponding binary value is assigned to output
Output updates instantly (no delay logic except simulation delay)<img width="1293" height="852" alt="Screenshot 2026-06-09 215155" src="https://github.com/user-attachments/assets/47ac15f3-5e74-42e5-b6bb-e05c7c71e58c" />

