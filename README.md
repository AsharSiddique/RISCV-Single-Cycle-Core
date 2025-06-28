# ✅ RISC-V Single-Cycle Processor

- A Verilog implementation of a RISC-V single-cycle processor supporting the RV32I instruction set, designed and verified using VS Code, Icarus Verilog, and GTKWave. This project demonstrates a modular, extendable architecture with comprehensive testbenches for functional verification. 📡

# 🎯 Features

- RV32I Instruction Set: Implements the complete RV32I base instruction set for robust functionality. ✅
- Modular Architecture: Designed for scalability and ease of extension, including:
  - 🔢 ALU: Handles arithmetic and logical operations.
  - 📚 Register File: Manages 32 registers for data storage.
  - 🕹️ Control Unit: Orchestrates instruction execution.
  - ⏱️ Program Counter: Tracks instruction addresses.
  - 🔄 Extend Unit: Handles immediate value extensions.
  - ➕ Adders: Supports address calculations.
  - 🔀 Multiplexers: Routes data paths efficiently.
  - 💾 Instruction Memory: Stores program instructions.
  - 📦 Data Memory: Manages data read/write operations.
- Top-Level Integration: Seamlessly connects all modules in a cohesive top module. 🛠️
- Verification: Comprehensive testbenches ensure functional correctness, validated via Icarus Verilog and GTKWave. 🧪


# 🚀 Getting Started
Follow these steps to run the RISC-V single-cycle processor on your machine:

- Prerequisites
  - VS Code ✍️: For editing Verilog files (recommended with Verilog-HDL extension).
  - Icarus Verilog 🖥️: For compiling and simulating Verilog code.
  - GTKWave 📊: For waveform visualization.

- Setup
  ```bash
    git clone https://github.com/AsharSiddique/RISCV-Single-Cycle-Core.git
    cd RISCV-Single-Cycle-Core

- Compile and Simulate
  ```bash
    iverilog -o top_sim.vvp Top.v Top_tb.v
    vvp top_sim.vvp

- View Waveform
  ```bash
    gtkwave waveform.vcd

# 🌊 Example Waveform

- <img width="600" alt="GTKWave Waveform" src="https://github.com/user-attachments/assets/219bd5ef-1932-4be5-99e4-1ed83628a141">

# 📜 License
- This project is licensed under the MIT License – free to use, modify, and share! 😊

# 🙌 Acknowledgments
- Built with ❤️ by Ashar.
- Powered by the RISC-V open-source ISA and Verilog’s flexibility.

# 📢 Stay Tuned!

- Exciting updates are on the way as this project evolves with new features and optimizations. Follow the repository for the latest developments!
