`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2026 09:01:32 PM
// Design Name: 
// Module Name: reg_file
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


module reg_file(
    input logic clk, rst,
    input logic [4:0] rs1, rs2, rd,
    input logic [31:0] dataW,
    input logic regWen,
    output logic [31:0] data1, data2
);

    logic [31:0] reg_file [0:31];
    integer i;

    // read data (comb)
    always_comb begin
        // x0 always reads as zero
        if(rs1 == 5'd0)
            data1 = 32'd0;
        else
            data1 = reg_file[rs1];
        if(rs2 == 5'd0)
            data2 = 32'd0;
        else
            data2 = reg_file[rs2];
    end

    // write data (seq)
    always_ff @(negedge clk or posedge rst) begin
        if(rst) begin
            // reset all registers
            for(i = 0; i < 32; i++)
                reg_file[i] <= 32'd0;
        end
        // x0 cannot be written
        else if(regWen && rd != 5'd0) begin
            reg_file[rd] <= dataW;
        end
    end
endmodule
