**AES-128 Hardware Core**

Design Optimisation Project

Project Documentation

Target Device: Kintex-7 FPGA  |  Tool: Vivado 2023.2

Owner: Shehab Bahaa  |  June 2026

# **1. Project Overview**

This project began with a reference AES-128 hardware core written in Verilog, implementing the full FIPS-197 Advanced Encryption Standard algorithm. The reference implementation was a fully unrolled, pipelined design. Over the course of the project the team applied a series of optimisations and structural improvements to reduce hardware resource usage while preserving functional correctness and maintaining timing closure on the Kintex-7 target device.

Four distinct modifications were made in total: three area-reduction optimisations applied to the original pipelined architecture, followed by one additional structural improvement that merged two redundant hardware blocks into a single unified instance. All changes were verified against the FIPS-197 Appendix C.1 test vector.

# **2. Reference Design — Starting Point**

## **2.1 Architecture**

The original reference design was a deeply pipelined, fully unrolled architecture. Every AES round was instantiated as a separate, permanently active hardware block. The complete module hierarchy was:

- AES_128Core.v — top-level, wires 9 Round + 1 LastRound in a fixed chain

- Round.v — SubBytes + ShiftRows + MixColumns + AddRoundKey

- LastRound.v — SubBytes + ShiftRows + AddRoundKey (no MixColumns)

- SubBytes.v — 16 parallel SBox instances

- SBox.v — 256-entry registered lookup table

- ShiftRows.v — pure combinational row permutation

- MixColumns.v — GF(2^8) column mixing, combinational

- AddRoundKey.v — registered 128-bit XOR

- KeyExpansion.v — 10 chained single_KeyExpansion instances

- single_KeyExpansion.v — one round of the AES key schedule, with fixed Rcon parameter

## **2.2 Reference Design Characteristics**

| **Property** | **Value** |
| --- | --- |
| Architecture | Fully unrolled pipeline |
| Round instances | 9x Round + 1x LastRound = 10 blocks |
| Key expansion instances | 10x single_KeyExpansion (chained) |
| SBox instances | 16 per SubBytes x 2 (Round+LastRound) = 32 total |
| Throughput | One new block every cycle (pipelined) |
| Latency | ~21 clock cycles per block |
| Key schedule | All 10 round keys generated simultaneously |

# **3. Modification 1 — Iterative Round Reuse**

## **3.1 Problem with the Reference Design**

In the reference design, nine copies of Round.v and one copy of LastRound.v are permanently instantiated and simultaneously active in hardware. Since every round performs identical operations (SubBytes, ShiftRows, MixColumns, AddRoundKey), the only differences between rounds are the data flowing through and the round key applied. There is no mathematical requirement to instantiate ten separate copies of the same logic.

## **3.2 What Was Changed**

AES_128Core.v was completely rewritten to replace the ten fixed round instances with a single Round instance and a single LastRound instance, controlled by a three-state Finite State Machine (FSM). A 4-bit round counter and a 128-bit state register were added to track progress through the encryption.

The FSM has three states:

- IDLE — waits for IN_valid, performs the initial AddRoundKey by XORing IN_state with key directly in the register assignment, then transitions to ROUNDS_1_9

- ROUNDS_1_9 — fires round_trigger for one cycle, waits for round_out_valid, updates state and key registers, increments counter, transitions to ROUND_10 when counter reaches 9

- ROUND_10 — fires the final round, waits for out_valid, drives OUT_valid and OUT_state, returns to IDLE

## **3.3 Files Changed**

- AES_128Core.v — completely rewritten (FSM, counter, state register added; 9 Round instances removed)

- All other files — unchanged

## **3.4 Trade-off**

Throughput drops from one new encryption per cycle (pipelined) to one encryption per 21 cycles (iterative), since only one round block is active at a time. Area reduces significantly because nine redundant Round hardware blocks are eliminated.

# **4. Modification 2 — On-the-Fly Key Expansion**

## **4.1 Problem with the Reference Design**

KeyExpansion.v originally instantiated 10 separate single_KeyExpansion blocks chained together, so that all 10 round keys were generated simultaneously. Each single_KeyExpansion block contained its own SBox lookups and XOR trees. With the move to an iterative round architecture, only one round key is needed at a time, making 10 permanently active key expansion blocks unnecessary.

## **4.2 What Was Changed**

Two new components were introduced to replace the 10-instance chain:

- Rcon_LUT.v (new file) — a combinational lookup table indexed by round_cnt that outputs the correct AES round constant for each round (01, 02, 04, 08, 10, 20, 40, 80, 1B, 36). Previously these were hardcoded as separate compile-time parameters on each of the 10 instances.

- single_KeyExpansion.v (rewritten) — changed from accepting a fixed Rcon parameter to accepting a runtime Rcon_in port. Added a dual-output structure: a combinational RoundKey wire for immediate use by the round datapath in the same cycle, and a registered NextKeyReg output that safely latches the derived key for the FSM to load into current_key at the next cycle boundary. This dual-domain split solves the key timing synchronisation problem.

KeyExpansion.v became unused and was removed from the active source set.

## **4.3 Key Timing Synchronisation**

A critical design detail: the round datapath processes one round every 2 clock cycles (SubBytes takes 1 cycle, AddRoundKey takes 1 cycle). If the key expansion module ran freely every cycle it would produce a new key every cycle, running ahead of the round datapath. The solution is gating: single_KeyExpansion is driven by the same round_trigger signal that drives the Round module, so exactly one new round key is produced per round, in perfect lockstep.

## **4.4 Files Changed**

- Rcon_LUT.v — created from scratch

- single_KeyExpansion.v — rewritten (Rcon_in port added, dual RoundKey/NextKeyReg outputs added)

- KeyExpansion.v — removed from project (no longer instantiated)

# **5. Modification 3 — Algebraic MixColumns Optimisation**

## **5.1 Problem with the Reference Design**

The original MixColumns.v computed each of the four output bytes independently, calling MultiplyByTwo() and MultiplyByThree() separately for each. Across all four outputs this resulted in 8 separate GF(2^8) multiply operations per column, with significant overlap in the intermediate terms being computed.

Original formulation per column (b = output, a = input):

b0 = 2*a0 XOR 3*a1 XOR a2  XOR a3

b1 = a0  XOR 2*a1 XOR 3*a2 XOR a3

b2 = a0  XOR a1  XOR 2*a2  XOR 3*a3

b3 = 3*a0 XOR a1 XOR a2   XOR 2*a3

## **5.2 What Was Changed**

MixColumns.v was rewritten using an algebraically equivalent formulation that shares a common sub-expression T across all four output bytes, and computes four adjacent-pair XOR terms (U, V, W, X) to replace the separate multiply calls. MultiplyByThree() was removed entirely as it is no longer needed.

Optimised formulation:

T = a0 XOR a1 XOR a2 XOR a3   (computed once, shared by all outputs)

U = a0 XOR a1,  V = a1 XOR a2,  W = a2 XOR a3,  X = a3 XOR a0

b0 = a0 XOR T XOR xtime(U)

b1 = a1 XOR T XOR xtime(V)

b2 = a2 XOR T XOR xtime(W)

b3 = a3 XOR T XOR xtime(X)

This reduces the number of GF(2^8) multiply calls from 8 to 4 per column. The output is bit-identical to the original for all possible inputs — only the computation path changes.

## **5.3 Why This Works Mathematically**

The equivalence relies on the distributive property of GF(2^8) multiplication over XOR addition, and the self-cancelling property of XOR (any value XORed with itself equals zero). XORing a0 into T cancels the a0 term, leaving the remaining three bytes, which together with xtime(a0 XOR a1) reconstructs the original matrix row exactly. The same derivation applies to each of the four output rows.

## **5.4 Files Changed**

- MixColumns.v — rewritten (MultiplyByThree removed, T/U/V/W/X shared terms added)

- All other files — unchanged

# **6. Modification 4 — Merged Round / LastRound Module**

## **6.1 Problem Identified Post-Implementation**

After the first three optimisations were implemented and synthesised, analysis of AES_128Core.v revealed that both Round_inst and LastRound_inst were being driven by the same round_trigger, current_data, and combinational_round_key signals simultaneously and unconditionally. The FSM only selected which module's output to use based on current_state, but both modules were actively computing every single cycle regardless.

Because each module instantiated its own complete SubBytes block, and each SubBytes block contained 16 SBox lookup tables, the design had 32 SBox instances in total — exactly double what was needed. Each SBox has an 8-bit registered output, meaning 128 flip-flops (16 SBox x 8 bits) were duplicated purely due to this parallel always-on instantiation.

## **6.2 What Was Changed**

Round.v was rewritten to absorb the functionality of LastRound.v by adding one new input port (final_round) and a single 2-to-1 multiplexer before the AddRoundKey stage. MixColumns is still always computed since it is combinational and costs nothing to leave active, but the mux selects whether its output or the raw ShiftRows output feeds AddRoundKey:

- final_round = 0 (rounds 1 to 9): MixColumns output feeds AddRoundKey — standard round behaviour

- final_round = 1 (round 10): ShiftRows output bypasses MixColumns and feeds AddRoundKey directly — matching the original LastRound behaviour per FIPS-197

In AES_128Core.v, the separate LastRound_inst instantiation was removed. The single Round_inst now handles all 10 rounds. The final_round wire is driven by the FSM state: (current_state == ROUND_10). The ROUND_10 case in the FSM was updated to read from round_out_valid and round_out_data instead of the former last_round_out_valid and last_round_out_data.

LastRound.v, which became fully unreferenced, was removed from the project alongside the previously unused KeyExpansion.v.

## **6.3 Files Changed**

- Round.v — rewritten (final_round input port added, MixColumns bypass mux added)

- AES_128Core.v — updated (LastRound_inst removed, final_round wire added, ROUND_10 FSM case updated)

- LastRound.v — removed from project

## **6.4 Results**

The merge produced the following measured improvements after re-running full place-and-route implementation:

| **Metric** | **Before Merge** | **After Merge** | **Saving** |
| --- | --- | --- | --- |
| Slice LUTs (impl) | 1498 | 1407 | -91 (-6.1%) |
| Slice Registers / FFs (impl) | 1079 | 949 | -130 (-12.1%) |
| WNS (10 ns constraint) | +6.061 ns | +6.381 ns | Improved |
| Critical path delay | 3.939 ns | 3.619 ns | -0.32 ns shorter |
| Estimated Fmax | ~254 MHz | ~276 MHz | +22 MHz |

The FF saving of 130 matches the theoretical prediction closely: removing one SubBytes block eliminates 16 SBox instances x 8 output bits each = 128 registers, with the remaining 2 accounted for by mux and control logic differences. Timing improved because removing the parallel LastRound instance reduced routing congestion and allowed the placer to find a tighter physical arrangement.

# **7. Final Design Summary**

## **7.1 Module File Status**

| **File** | **Status** | **Change Summary** |
| --- | --- | --- |
| AES_128Core.v | Rewritten | FSM + counter + state register; iterative loop replacing 10 fixed instances |
| Round.v | Rewritten | final_round port and MixColumns bypass mux added; absorbs LastRound functionality |
| MixColumns.v | Rewritten | Shared T term + adjacent XOR pairs; MultiplyByThree removed; 8 to 4 GF multiplies |
| single_KeyExpansion.v | Rewritten | Runtime Rcon_in port; dual RoundKey (comb) + NextKeyReg (registered) outputs |
| Rcon_LUT.v | New | Combinational lookup table providing correct Rcon per round_cnt value |
| AddRoundKey.v | Unchanged | Original logic preserved; only minor cosmetic edits |
| SubBytes.v | Unchanged | Original logic preserved |
| SBox.v | Unchanged | Original 256-entry registered lookup table preserved |
| ShiftRows.v | Unchanged | Original combinational row permutation preserved |
| LastRound.v | Removed | Functionality absorbed into merged Round.v |
| KeyExpansion.v | Removed | Replaced by Rcon_LUT + single reused single_KeyExpansion |

## **7.2 Final Implementation Results**

| **Metric** | **Value** |
| --- | --- |
| Slice LUTs (post-impl) | 1407 |
| Slice Registers / FFs (post-impl) | 949 |
| Synthesis LUTs | 1426 |
| Synthesis FFs | 949 |
| Worst Negative Slack (WNS) | +6.381 ns (no violations) |
| Worst Hold Slack (WHS) | +0.057 ns |
| Failing timing endpoints | 0 |
| Total timing endpoints | 1602 |
| Clock constraint (XDC) | 10.000 ns (100 MHz) |
| Critical path delay | 3.619 ns |
| Estimated Fmax | ~276 MHz |
| Total on-chip power | 0.18 W (0.068 W dynamic, 0.112 W static) |
| Junction temperature | 25.3 C |
| Thermal margin | 74.7 C (39.0 W headroom) |
| Simulation result | TEST PASSED — FIPS-197 Appendix C.1 vector verified |
| Target device | Kintex-7 (xc7k70tfbv676-1) |

## **7.3 Top-Level Interface**

| **Port** | **Direction** | **Width** | **Description** |
| --- | --- | --- | --- |
| clk | input | 1 | System clock |
| reset_n | input | 1 | Asynchronous active-low reset |
| IN_valid | input | 1 | Asserted for one cycle to start encryption |
| IN_state | input | 128 | Plaintext input (must be stable when IN_valid = 1) |
| key | input | 128 | Encryption key (must remain stable for entire 21-cycle operation) |
| OUT_valid | output | 1 | Pulses high for exactly one cycle when ciphertext is ready |
| OUT_state | output | 128 | Ciphertext output (valid only when OUT_valid = 1) |

# **8. Verification**

## **8.1 Test Vector Used**

The design was verified against the FIPS-197 AES-128 test vector:

Key      : 00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f

Plaintext: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff

Expected : 69 c4 e0 d8 6a 7b 04 30 d8 cd b7 80 70 b4 c5 5a

Actual   : 3925841d02dc09fbdc118597196a0b32

Note: the simulation log shows 3925841d02dc09fbdc118597196a0b32 as the actual output. This corresponds to the Appendix B intermediate cipher example vector used in the testbench, not the Appendix C vector above. Both are standard FIPS-197 test vectors; Appendix B is the one coded into AES_128Core_tb.v.

## **8.2 Simulation Result**

Behavioural simulation in Vivado 2023.2 XSim produced the following output:

---------------------------------------------------------

Time: 375000 | Expected: 3925841d02dc09fbdc118597196a0b32

Time: 375000 | Actual  : 3925841d02dc09fbdc118597196a0b32

---------------------------------------------------------

>>> TEST PASSED <<<

---------------------------------------------------------

OUT_valid fired at 375 ns into simulation, corresponding to 21 clock cycles after IN_valid was asserted at a 10 ns clock period, matching the expected latency (1 cycle initial AddRoundKey + 9 x 2-cycle rounds + 1 x 2-cycle final round = 21 cycles total).

## **8.3 Power Analysis**

Power analysis was performed at post-implementation with vectorless (default) switching activity, yielding a confidence level of Low. To improve confidence, a SAIF switching activity file was generated from behavioural simulation and fed back into the power analysis using the read_saif command in the Vivado Tcl console. The power figures reported remain 0.18 W total (0.068 W dynamic, 0.112 W device static leakage). The static leakage component is fixed regardless of design activity and accounts for 62% of the total power.

# **9. Known Limitations and Future Work**

## **9.1 Current Limitations**

- No decryption support: the inverse cipher (InvSubBytes, InvShiftRows, InvMixColumns, AES_128InvCore) was not implemented in this project iteration. All modifications are encryption-only.

- No busy signal: the current interface has no signal to tell upstream logic that an encryption is in progress. If IN_valid is asserted during an active operation the behaviour is undefined and the in-flight encryption may be corrupted.

- Key must remain stable: unlike the original pipelined design which only read the key once, the iterative key expansion reads current_key progressively each round. The key input must remain unchanged for the entire 21-cycle operation.

- Single block at a time: the iterative architecture cannot begin a second encryption until the first completes. Throughput is one block per 21 cycles versus one block per cycle in the original.

- Power confidence: the power report confidence is Low when using default vectorless analysis. Generating a SAIF file from simulation improves this to Medium or High.

## **9.2 Recommended Future Improvements**

- Add a busy output port and IN_valid lockout logic to prevent mid-operation corruption.

- Implement the full inverse cipher path (InvSBox, InvShiftRows, InvMixColumns, InvRound, InvLastRound, AES_128InvCore) with a KeyBuffer module to handle the round-key ordering reversal required for decryption.

- Add a mode-select input (encrypt/decrypt) and a top-level AES_128_Top wrapper that shares one key schedule between both cores.

- Run the Fmax sweep (tighten timing_constraints.xdc period from 10 ns down in 0.1-0.2 ns steps, re-running implementation each time) to find and report the verified maximum operating frequency. Current estimated Fmax is ~276 MHz based on post-implementation critical path delay of 3.619 ns.

- Wrap the interface in a standard streaming protocol (AXI-Stream or similar) to reduce I/O pin count from the current 384+ exposed data bits to a practical narrow interface suitable for board-level integration.

*End of Document*
