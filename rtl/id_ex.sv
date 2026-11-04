`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2026 02:49:35 PM
// Design Name: 
// Module Name: id_ex
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


module id_ex (
    input logic clk, rst, flush,
    input logic regWen_in, bsel_in, memRw_in, pcsel_in, jalr_sel_in, is_branch_in,
    input logic [1:0] asel_in, wbsel_in,
    input logic [3:0] alu_sel_in,
    input logic [2:0] func3_in,
    input logic [31:0] pc_in, data1_in, data2_in, imm_in,
    input logic [4:0] rs1_in, rs2_in, rd_in,
    output logic regWen_out, bsel_out, memRw_out, pcsel_out, jalr_sel_out, is_branch_out,
    output logic [1:0] asel_out, wbsel_out,
    output logic [3:0] alu_sel_out,
    output logic [2:0] func3_out,
    output logic [31:0] pc_out, data1_out, data2_out, imm_out,
    output logic [4:0] rs1_out, rs2_out, rd_out
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst || flush) begin
            regWen_out <= 1'b0;
            bsel_out <= 1'b0;
            memRw_out <= 1'b0;
            pcsel_out <= 1'b0;
            jalr_sel_out <= 1'b0;
            is_branch_out <= 1'b0;
            asel_out <= 2'b00;
            wbsel_out <= 2'b00;
            alu_sel_out <= 4'b0000;
            func3_out <= 3'b000;
            pc_out <= 32'd0;
            data1_out <= 32'd0;
            data2_out <= 32'd0;
            imm_out <= 32'd0;
            rs1_out <= 5'd0;
            rs2_out <= 5'd0;
            rd_out <= 5'd0;
        end else begin
            regWen_out <= regWen_in;
            bsel_out <= bsel_in;
            memRw_out <= memRw_in;
            pcsel_out <= pcsel_in;
            jalr_sel_out <= jalr_sel_in;
            is_branch_out <= is_branch_in;
            asel_out <= asel_in;
            wbsel_out <= wbsel_in;
            alu_sel_out <= alu_sel_in;
            func3_out <= func3_in;
            pc_out <= pc_in;
            data1_out <= data1_in;
            data2_out <= data2_in;
            imm_out <= imm_in;
            rs1_out <= rs1_in;
            rs2_out <= rs2_in;
            rd_out <= rd_in;
        end
    end
endmodule