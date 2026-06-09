4-bit Ripple Carry Adder (Verilog HDL)
📌 Overview

This project implements a 4-bit Ripple Carry Adder using Verilog HDL.
It performs binary addition of two 4-bit operands along with an input carry, producing a 4-bit sum and a final carry-out.

The design is built using full adders connected in series, where carry output from each stage propagates to the next stage.

⚙️ Features
4-bit binary addition
Carry-in support
Full carry propagation (ripple effect)
Modular full adder-based design
Verified using testbench simulation
Waveform-based validation
🧠 Working Principle
Each full adder adds:
One bit from A
One bit from B
Carry from previous stage
Carry “ripples” from LSB → MSB
Final stage produces cout

This causes a small delay due to sequential carry propagation.

🔌 Inputs and Outputs
Inputs
A[3:0] → First operand
B[3:0] → Second operand
Cin → Input carry
Outputs
S[3:0] → Sum output
Cout → Final carry output
🧪 Test Cases
Test Case	A (a_r)	B (b_r)	Cin	Expected Sum	Cout	Description
TC1	0000	0000	0	0000	0	Reset / idle case
TC2	0010	0100	0	0110	0	Simple addition
TC3	0010	0100	1	0111	0	Addition with carry-in
TC4	1110	0110	1	0111	1	Overflow case
TC5	0011	1100	1	0000	1	Maximum carry propagation
📈 Output Waveform (Simulation Results)
🔹 Ripple Carry Propagation Visualization
4
📊 Waveform Explanation

During simulation:

At TC1 → All outputs are 0 (reset state)
At TC2 → Sum updates immediately with no carry delay
At TC3 → Carry-in affects LSB addition
At TC4 → Carry propagates through all stages
At TC5 → Full carry chain activates (maximum propagation delay visible)
⏱ Key Observation:

The carry signal does not update instantly; it propagates sequentially from bit 0 → bit 3.

🔄 Functional Behavior Summary
Inputs A and B are applied
LSB full adder computes first sum + carry
Carry propagates through intermediate stages
MSB produces final sum and carry-out
Outputs stabilize after ripple delay
