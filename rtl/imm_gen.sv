`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2026 10:56:07 PM
// Design Name: 
// Module Name: imm_gen
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


module imm_gen(
    input logic [31:7] imm_in,
    input logic [2:0] imm_sel,  // 0-> i type , 1-> s type , 2-> j type , 3-> b type , 4-> u type
    output logic [31:0] imm_out
);

    always_comb begin
        case(imm_sel)
            0: imm_out = {{20{imm_in[31]}}, imm_in[31:20]};
            1: imm_out = {{20{imm_in[31]}}, imm_in[31:25], imm_in[11:7]};
            2: imm_out = {{11{imm_in[31]}}, imm_in[31], imm_in[19:12], imm_in[20], imm_in[30:21], 1'b0};
            3: imm_out = {{19{imm_in[31]}}, imm_in[31], imm_in[7], imm_in[30:25], imm_in[11:8], 1'b0};
            4: imm_out = {imm_in[31:12], 12'd0};
            default: imm_out = 32'd0;
        endcase
    end
endmodule