`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2026 07:49:31 PM
// Design Name: 
// Module Name: program_counter
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


module program_counter(
    input logic clk, rst,
    input logic [31:0] next_pc,
    output logic [31:0] pc
);

    always_ff @(posedge clk or posedge rst) begin
        if(rst)
            pc <= 32'd0;        
        else
            pc <= next_pc;      
    end
endmodule
