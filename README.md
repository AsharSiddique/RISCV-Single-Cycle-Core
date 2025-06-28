## RISC-V Single-Cycle Processor

A Verilog implementation of a RISC-V single-cycle processor supporting the RV32I instruction set, designed and verified using VS Code, Icarus Verilog, and GTKWave.

## Features
- Supports RV32I instruction set.
- Modular design with:
   - ALU
   - Register File
   - Control Unit
   - Program Counter
   - Extend Unit
   - Adders
   - Multiplexers
   - Instruction Memory
   - Data Memory
- Modules integration in Top module.
- Verified with testbenches.

## How to Run
1. Install VS Code, Icarus Verilog and GTKWave.
2. Compile and simulate:

   
   ```bash
   iverilog -o top_sim.vvp Top_tb.v Top.v
   vvp top_sim.vvp
   gtkwave waveform.vcd



<img width="959" alt="image" src="https://github.com/user-attachments/assets/219bd5ef-1932-4be5-99e4-1ed83628a141" />
