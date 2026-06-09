🔢 BCD Adder (Binary Coded Decimal Adder) – Verilog HDL
📌 Overview

This project implements a BCD Adder using Verilog HDL.
A BCD adder performs addition of two 4-bit BCD numbers (0–9) and corrects the result if it exceeds 9 by adding a correction factor of 0110 (6).

The design uses a Ripple Carry Adder for binary addition, followed by correction logic to ensure valid BCD output.

⚙️ Features
4-bit BCD addition
Ripple carry adder-based binary addition
Automatic correction for invalid BCD results (>9)
Carry detection logic
Modular design using reusable full adder blocks
Verified using structured testbench
🧠 Working Principle

The BCD adder works in two stages:

🔹 Stage 1: Binary Addition
Adds two 4-bit BCD inputs using a ripple carry adder
Produces intermediate sum and carry
🔹 Stage 2: Correction Logic

Correction is required when:

Sum > 9 OR carry is generated

Condition detected using logic:

Carry-out OR invalid sum pattern

If correction is needed:

Add 0110 (decimal 6) to the intermediate sum
🔌 Inputs and Outputs
Inputs:
a[3:0] → First BCD digit
b[3:0] → Second BCD digit
cin → Input carry
Outputs:
sum[3:0] → Corrected BCD sum
cout → Carry to next BCD digit
🔄 Design Flow
Add a and b using Ripple Carry Adder
Generate intermediate binary sum
Detect invalid BCD condition
If invalid → add 0110 correction
Output corrected BCD sum and carry
🧪 Test Cases
Test Case	A (a_tb)	B (b_tb)	Cin	Raw Sum	Correction	Final Sum	Cout	Description
TC1	0000	0000	0	0000	No	0000	0	Reset case
TC2	0001	0010	0	0011	No	0011	0	Simple BCD addition
TC3	0101	0011	0	1000	No	1000	0	Valid BCD
TC4	0100	0101	0	1001	No	1001	0	Edge valid case
TC5	0101	0101	0	1010	Yes	0000	1	Correction triggered
TC6	0110	0101	0	1011	Yes	0001	1	Correction + carry
TC7	1001	1001	0	10010	Yes	1001	1	Maximum BCD overflow
📈 Output Waveform (Simulation Results)
📊 Waveform Explanation

During simulation:

TC1–TC2 → Direct binary addition, no correction needed
TC3–TC4 → Valid BCD results remain unchanged
TC5–TC6 → Sum exceeds 9 → correction (0110) applied
TC7 → Maximum overflow, carry generated to next digit
⏱ Key Observation:

Whenever the raw sum exceeds 1001 (9), the circuit automatically corrects it by adding 0110.

🔍 Correction Logic Summary

Correction is triggered when:

Carry-out = 1 OR
Sum > 9 (invalid BCD range)

Then:

Add 0110 to intermediate sum
Produce valid BCD output
📂 Project Structure
BCD Adder Module
Ripple Carry Adder Dependency
Testbench File
Simulation Waveform Output<img width="1512" height="832" alt="Screenshot 2026-06-09 214656" src="https://github.com/user-attachments/assets/c0d5c671-e2c4-43c6-8d47-d5546b3b3787" />

