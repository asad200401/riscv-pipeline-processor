# RISC-V 5-Stage Pipeline Processor (RV32I)

![RISC-V](https://img.shields.io/badge/RISC--V-RV32I-blue)
![SystemVerilog](https://img.shields.io/badge/Language-SystemVerilog-orange)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A complete **5-Stage Pipelined RISC-V RV32I** processor implemented in SystemVerilog.  
This design extends my existing [riscv-single-cycle](https://github.com/asad200401/riscv-single-cycle-processor) processor into a classic 5-stage pipeline architecture.

## Description

A fully functional 5-stage pipelined RISC-V RV32I Processor implemented in SystemVerilog.  
It supports all base integer instructions (R, I, S, B, U, J types) and is built by extending the single-cycle design into a pipelined architecture with hazard detection and forwarding.

## Features

- 32-bit datapath
- 5-stage pipeline architecture (IF, ID, EX, MEM, WB)
- Separate instruction and data memory
- Register file with 32 registers
- ALU supporting arithmetic and logical operations
- Immediate generator for multiple instruction formats
- Control unit for instruction decoding
- Jump and branch support
- Load/store memory interface
- Hazard detection unit
- Data forwarding unit
- Modular SystemVerilog design

## Pipeline Stages

- **IF**  – Instruction Fetch  
- **ID**  – Instruction Decode / Register Read  
- **EX**  – Execute / ALU  
- **MEM** – Memory Access  
- **WB**  – Write Back  

## RISC-V Datapath

<img width="1291" height="625" alt="image" src="https://github.com/user-attachments/assets/fddfcf9b-8e89-4fc2-8544-e45c6243bcb9" />

## Instruction Flow

- PC
- Instruction Fetch (IF)
- Instruction Decode (ID)
- Register Read
- Immediate Generation
- ALU Execution (EX)
- Memory Access (MEM)
- Write Back (WB)
- Next PC Update

## Simulation

**Example Test Program**

- addi x1, x0, 5
- addi x2, x0, 10
- addi x10, x0, 100
- add  x3, x1, x2
- sub  x4, x2, x1
- sw   x3, 0(x10)
- lw   x5, 0(x10)
- beq  x3, x5, label
- jal  x1, target
- label:
- addi x6, x0, 4
- target:
- sub  x7, x6, x1
- lui  x8, 0x12345
- auipc x9, 0x10
- jalr x11, x9, 0

## Simulation Results

<img width="1337" height="577" alt="image" src="https://github.com/user-attachments/assets/7b08cd28-e216-44df-b1cf-88f72f8972c2" />

**Key Observations:**

- Correct execution of arithmetic operations (add, sub, addi)
- Successful Store and Load operations (sw → lw)
- Correct Branch behavior (beq taken)
- Successful execution of Upper Immediate instruction (lui)
- Correct execution of AUIPC instruction
- Successful execution of JALR instruction
- Proper handling of data hazards through forwarding
- Stall insertion when required (load-use hazard)

**Register File after execution:**

| Register | Value |
|:--------:|------:|
| x1  | 5 |
| x2  | 10 |
| x3  | 15 |
| x4  | 5 |
| x5  | 15 |
| x6  | 4 |
| x7  | -1 |
| x8  | 305418240 (`0x12345000`) |
| x9  | 65584 (`0x00010030`) |
| x10 | 100 |
| x11 | 56 (`0x00000038`) |

**Data Memory:**

<img width="261" height="276" alt="image" src="https://github.com/user-attachments/assets/a9a9f38d-0209-4b58-a8ff-0df6001b6910" />

- mem[25] = 15 (value stored by sw at byte address 100 and successfully retrieved by lw).

## Tools Used

- SystemVerilog
- Xilinx Vivado
- Venus RISC-V Simulator

## Related Project

This processor is an extension of my previous single-cycle design:  
**[riscv-single-cycle](https://github.com/asad200401/riscv-single-cycle-processor)**

## Author

**Asad Iqbal**
