`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2026 11:09:48 PM
// Design Name: 
// Module Name: top
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


module top (
    input logic clk,
    input logic rst
);

    // if signals
    logic [31:0] pc, next_pc, pc_plus_4;
    logic [31:0] instr_if;
    logic pc_write, if_id_write;
    // if/id signals
    logic [31:0] pc_id, instr_id;
    // id signals
    logic [31:0] data1_id, data2_id, imm_id;
    logic regWen_id, bsel_id, memRw_id, pcsel_id, jalr_sel_id, is_branch_id;
    logic [1:0] asel_id, wbsel_id;
    logic [2:0] imm_sel_id;
    logic [3:0] AluSel_id;
    logic id_ex_flush;
    // id/ex signals
    logic regWen_ex, bsel_ex, memRw_ex, pcsel_ex, jalr_sel_ex, is_branch_ex;
    logic [1:0] asel_ex, wbsel_ex;
    logic [3:0] AluSel_ex;
    logic [2:0] func3_ex;
    logic [31:0] pc_ex, data1_ex, data2_ex, imm_ex;
    logic [4:0] rs1_ex, rs2_ex, rd_ex;
    // ex signals
    logic [1:0] forward_a, forward_b;
    logic [31:0] forward_data1, forward_data2;
    logic [31:0] alu_in1, alu_in2, alu_out_ex;
    logic Eq_ex, Lt_ex, BrUn_ex, branch_taken_ex, take_branch_or_jump;
    logic [31:0] pc_plus_4_ex;
    // ex/mem signals
    logic regWen_mem, memRw_mem;
    logic [1:0] wbsel_mem;
    logic [2:0] func3_mem;
    logic [31:0] alu_out_mem, data2_mem, pc_plus_4_mem;
    logic [4:0] rd_mem;
    // mem signal
    logic [31:0] dataR_mem;
    // mem/wb signals
    logic regWen_wb;
    logic [1:0] wbsel_wb;
    logic [31:0] dataR_wb, alu_out_wb, pc_plus_4_wb;
    logic [4:0] rd_wb;
    // wb signal
    logic [31:0] dataW;

    // if stage
    program_counter PC (.clk(clk), .rst(rst), .next_pc(next_pc), .pc(pc));

    pc_plus_4 PC4 (.pc_in(pc), .pc_out(pc_plus_4));

    // pc mux
    assign next_pc = ~ pc_write ? pc : (take_branch_or_jump ?  (jalr_sel_ex ? {alu_out_ex[31:1], 1'b0} : alu_out_ex) : pc_plus_4);

    inst_mem IM (.addr(pc), .instr(instr_if));

    // if/id
    if_id IFID (.clk(clk), .rst(rst), .flush(take_branch_or_jump), .stall(~if_id_write), .pc_in(pc), .inst_in(instr_if), .pc_out(pc_id), .inst_out(instr_id));

    // id stage
    control_unit CU (.opcode(instr_id[6:0]), .func3(instr_id[14:12]), .func7(instr_id[30]), .branch_taken(1'b0), .AluSel(AluSel_id), .regWen(regWen_id), .bsel(bsel_id), .memRw(memRw_id), .pcsel(pcsel_id), .jalr_sel(jalr_sel_id), .asel(asel_id), .wbsel(wbsel_id), .imm_sel(imm_sel_id), .is_branch(is_branch_id));

    imm_gen IG (.imm_in(instr_id[31:7]), .imm_sel(imm_sel_id), .imm_out(imm_id));

    reg_file RF (.clk(clk), .rst(rst), .rs1(instr_id[19:15]), .rs2(instr_id[24:20]), .rd(rd_wb), .dataW(dataW), .regWen(regWen_wb), .data1(data1_id), .data2(data2_id));

    hazard_detection_unit HDU (.id_ex_rd(rd_ex), .id_ex_wbsel(wbsel_ex), .if_id_rs1(instr_id[19:15]), .if_id_rs2(instr_id[24:20]), .branch_taken(take_branch_or_jump), .pc_write(pc_write), .if_id_write(if_id_write), .id_ex_flush(id_ex_flush));

    // id/ex
    id_ex IDEX (.clk(clk), .rst(rst), .flush(id_ex_flush || take_branch_or_jump), .regWen_in(regWen_id), .bsel_in(bsel_id), .memRw_in(memRw_id), .pcsel_in(pcsel_id), .jalr_sel_in(jalr_sel_id), .is_branch_in(is_branch_id), .asel_in(asel_id), .wbsel_in(wbsel_id), .alu_sel_in(AluSel_id), .func3_in(instr_id[14:12]), .pc_in(pc_id), .data1_in(data1_id), .data2_in(data2_id), .imm_in(imm_id), .rs1_in(instr_id[19:15]), .rs2_in(instr_id[24:20]), .rd_in(instr_id[11:7]), .regWen_out(regWen_ex), .bsel_out(bsel_ex), .memRw_out(memRw_ex), .pcsel_out(pcsel_ex), .jalr_sel_out(jalr_sel_ex), .is_branch_out(is_branch_ex), .asel_out(asel_ex), .wbsel_out(wbsel_ex), .alu_sel_out(AluSel_ex), .func3_out(func3_ex), .pc_out(pc_ex), .data1_out(data1_ex), .data2_out(data2_ex), .imm_out(imm_ex), .rs1_out(rs1_ex), .rs2_out(rs2_ex), .rd_out(rd_ex));

    // ex stage
    forwarding_unit FU (.id_ex_rs1(rs1_ex), .id_ex_rs2(rs2_ex), .ex_mem_rd(rd_mem), .mem_wb_rd(rd_wb), .ex_mem_regWen(regWen_mem), .mem_wb_regWen(regWen_wb), .forward_a(forward_a), .forward_b(forward_b));

    // forwarding mux a
    always_comb begin
        case (forward_a)
            2'b00: forward_data1 = data1_ex;
            2'b01: forward_data1 = dataW;
            2'b10: forward_data1 = alu_out_mem;
            default: forward_data1 = data1_ex;
        endcase
    end

    // forwarding mux b
    always_comb begin
        case (forward_b)
            2'b00: forward_data2 = data2_ex;
            2'b01: forward_data2 = dataW;
            2'b10: forward_data2 = alu_out_mem;
            default: forward_data2 = data2_ex;
        endcase
    end

    branch_unit BU_EX (.Eq(Eq_ex), .Lt(Lt_ex), .func3(func3_ex), .is_branch(is_branch_ex), .BrUn(BrUn_ex), .branch_taken(branch_taken_ex));

    branch_comp BC_EX (.data1(forward_data1), .data2(forward_data2), .BrUn(BrUn_ex), .Eq(Eq_ex), .Lt(Lt_ex));

    assign take_branch_or_jump = pcsel_ex || branch_taken_ex;

    // a mux
    always_comb begin
        case (asel_ex)
            2'b00: alu_in1 = forward_data1;
            2'b01: alu_in1 = pc_ex;
            2'b10: alu_in1 = 32'd0;
            default: alu_in1 = forward_data1;
        endcase
    end

    // b mux
    assign alu_in2 = bsel_ex ? imm_ex : forward_data2;

    alu ALU (.op1(alu_in1), .op2(alu_in2), .AluSel(AluSel_ex), .alu_result(alu_out_ex));

    assign pc_plus_4_ex = pc_ex + 32'd4;

    // ex/mem
    ex_mem EXMEM (.clk(clk), .rst(rst), .regWen_in(regWen_ex), .memRw_in(memRw_ex), .wbsel_in(wbsel_ex), .func3_in(func3_ex), .alu_result_in(alu_out_ex), .data2_in(forward_data2), .pc_plus_4_in(pc_plus_4_ex), .rd_in(rd_ex), .regWen_out(regWen_mem), .memRw_out(memRw_mem), .wbsel_out(wbsel_mem), .func3_out(func3_mem), .alu_result_out(alu_out_mem), .data2_out(data2_mem), .pc_plus_4_out(pc_plus_4_mem), .rd_out(rd_mem));

    // mem stage
    data_mem DM (.clk(clk), .addr(alu_out_mem), .dataW(data2_mem), .memRw(memRw_mem), .func3(func3_mem), .dataR(dataR_mem));

    // mem/wb
    mem_wb MEMWB (.clk(clk), .rst(rst), .regWen_in(regWen_mem), .wbsel_in(wbsel_mem), .dmem_read_data_in(dataR_mem), .alu_result_in(alu_out_mem), .pc_plus_4_in(pc_plus_4_mem), .rd_in(rd_mem), .regWen_out(regWen_wb), .wbsel_out(wbsel_wb), .dmem_read_data_out(dataR_wb), .alu_result_out(alu_out_wb), .pc_plus_4_out(pc_plus_4_wb), .rd_out(rd_wb));

    // wb stage (wb mux)
    always_comb begin
        case (wbsel_wb)
            2'b00: dataW = dataR_wb;
            2'b01: dataW = alu_out_wb;
            2'b10: dataW = pc_plus_4_wb;
            default: dataW = alu_out_wb;
        endcase
    end
endmodule










