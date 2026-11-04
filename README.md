# RISC-V 5-Stage Pipeline Processor (RV32I)

![RISC-V](https://img.shields.io/badge/RISC--V-RV32I-blue)
![SystemVerilog](https://img.shields.io/badge/Language-SystemVerilog-orange)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A complete **5-Stage Pipelined RISC-V RV32I** processor implemented in SystemVerilog.  
This design is a direct evolution of **my existing processor** — the Single-Cycle RISC-V RV32I processor.

**Existing Processor (Single-Cycle):**  
[https://github.com/asad200401/riscv-single-cycle-processor](https://github.com/asad200401/riscv-single-cycle-processor)

## Description

This repository contains a fully functional **5-stage pipelined** RISC-V RV32I processor.  
It is designed as an upgrade of **my existing processor** (the single-cycle version).  

All the core modules (ALU, Register File, Immediate Generator, Control Unit, etc.) from **my existing processor** were reused and extended to support pipelining, hazard detection, and forwarding.

The goal of this project is to take **my existing processor** from a single-cycle design to a realistic 5-stage pipeline while keeping the same clean modular SystemVerilog style.
