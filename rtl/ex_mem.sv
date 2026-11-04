`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2026 02:49:48 PM
// Design Name: 
// Module Name: ex_mem
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


module ex_mem (
    input logic clk, rst,
    input logic regWen_in, memRw_in,
    input logic [1:0] wbsel_in,
    input logic [2:0] func3_in,
    input logic [31:0] alu_result_in, data2_in, pc_plus_4_in,
    input logic [4:0] rd_in,
    output logic regWen_out, memRw_out,
    output logic [1:0] wbsel_out,
    output logic [2:0] func3_out,
    output logic [31:0] alu_result_out, data2_out, pc_plus_4_out,
    output logic [4:0] rd_out
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            regWen_out <= 1'b0;
            memRw_out <= 1'b0;
            wbsel_out <= 2'b00;
            func3_out <= 3'b000;
            alu_result_out <= 32'd0;
            data2_out <= 32'd0;
            pc_plus_4_out <= 32'd0;
            rd_out <= 5'd0;
        end else begin
            regWen_out <= regWen_in;
            memRw_out <= memRw_in;
            wbsel_out <= wbsel_in;
            func3_out <= func3_in;
            alu_result_out <= alu_result_in;
            data2_out <= data2_in;
            pc_plus_4_out <= pc_plus_4_in;
            rd_out <= rd_in;
        end
    end
endmodule
