`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2026 02:50:01 PM
// Design Name: 
// Module Name: mem_wb
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


module mem_wb (
    input logic clk, rst,
    input logic regWen_in,
    input logic [1:0] wbsel_in,
    input logic [31:0] dmem_read_data_in, alu_result_in, pc_plus_4_in,
    input logic [4:0] rd_in,
    output logic regWen_out,
    output logic [1:0] wbsel_out,
    output logic [31:0] dmem_read_data_out, alu_result_out, pc_plus_4_out,
    output logic [4:0] rd_out
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            regWen_out <= 1'b0;
            wbsel_out <= 2'b00;
            dmem_read_data_out <= 32'd0;
            alu_result_out <= 32'd0;
            pc_plus_4_out <= 32'd0;
            rd_out <= 5'd0;
        end else begin
            regWen_out <= regWen_in;
            wbsel_out <= wbsel_in;
            dmem_read_data_out <= dmem_read_data_in;
            alu_result_out <= alu_result_in;
            pc_plus_4_out <= pc_plus_4_in;
            rd_out <= rd_in;
        end
    end
endmodule
