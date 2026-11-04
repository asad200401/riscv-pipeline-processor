`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2026 02:50:17 PM
// Design Name: 
// Module Name: forwarding_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module forwarding_unit (
    input logic [4:0] id_ex_rs1,
    input logic [4:0] id_ex_rs2,
    input logic [4:0] ex_mem_rd,
    input logic [4:0] mem_wb_rd,
    input logic ex_mem_regWen,
    input logic mem_wb_regWen,
    output logic [1:0] forward_a,
    output logic [1:0] forward_b
);

    always_comb begin
        forward_a = 2'b00;
        forward_b = 2'b00;
        // ex/mem forwarding (alu Result from previous instruction)
        if (ex_mem_regWen && (ex_mem_rd != 5'd0) && (ex_mem_rd == id_ex_rs1))
            forward_a = 2'b10;
        if (ex_mem_regWen && (ex_mem_rd != 5'd0) && (ex_mem_rd == id_ex_rs2))
            forward_b = 2'b10;
        // mem/wb forwarding (writeback data from 2 instructions ago)
        if (mem_wb_regWen && (mem_wb_rd != 5'd0) && !(ex_mem_regWen && (ex_mem_rd != 5'd0) && (ex_mem_rd == id_ex_rs1)) && (mem_wb_rd == id_ex_rs1))
            forward_a = 2'b01;
        if (mem_wb_regWen && (mem_wb_rd != 5'd0) && !(ex_mem_regWen && (ex_mem_rd != 5'd0) && (ex_mem_rd == id_ex_rs2)) && (mem_wb_rd == id_ex_rs2))
            forward_b = 2'b01;
    end
endmodule
