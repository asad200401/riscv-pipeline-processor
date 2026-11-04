# RISC-V 5-Stage Pipeline Processor (RV32I)

![RISC-V](https://img.shields.io/badge/RISC--V-RV32I-blue)
![SystemVerilog](https://img.shields.io/badge/Language-SystemVerilog-orange)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A complete **5-Stage Pipelined RISC-V RV32I** processor implemented in SystemVerilog.  

**Existing Processor (Single-Cycle):**  
[https://github.com/asad200401/riscv-single-cycle-processor](https://github.com/asad200401/riscv-single-cycle-processor)

## Description

This repository contains a fully functional **5-stage pipelined** RISC-V RV32I processor.  

All the core modules (ALU, Register File, Immediate Generator, Control Unit, etc.) from **my existing single cycle processor** were reused and extended to support pipelining, hazard detection, and forwarding.

The goal of this project is to take **my existing processor** from a single-cycle design to a realistic 5-stage pipeline while keeping the same clean modular SystemVerilog style.

## Features

- 32-bit datapath (same as **my single cycle processor**)
- 5-stage pipeline: IF → ID → EX → MEM → WB
- Hazard Detection Unit
- Data Forwarding Unit
- Pipeline registers between stages
- Separate Instruction and Data Memory (same structure as **my single cycle processor**)
- Full support for R, I, S, B, U, J type instructions
- Modular SystemVerilog design — built directly on top of **my single cycle processor**

## Pipeline Stages

1. **IF**  – Instruction Fetch  
2. **ID**  – Instruction Decode + Register Read  
3. **EX**  – Execute (ALU + Branch decision)  
4. **MEM** – Memory Access  
5. **WB**  – Write Back  

## Tools Used

- SystemVerilog
- Xilinx Vivado
- Venus RISC-V Simulator

## Author

**Asad Iqbal**

