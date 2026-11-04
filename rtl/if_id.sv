`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2026 02:49:22 PM
// Design Name: 
// Module Name: if_id
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


module if_id (
    input logic clk, rst, flush, stall,
    input logic [31:0] pc_in, inst_in,
    output logic [31:0] pc_out, inst_out
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst || flush) begin
            pc_out   <= 32'd0;
            inst_out <= 32'h00000013; // nop (addi x0, x0, 0)
        end else if (!stall) begin
            pc_out   <= pc_in;
            inst_out <= inst_in;
        end
    end
endmodule
