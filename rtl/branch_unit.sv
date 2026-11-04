`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2026 02:45:26 PM
// Design Name: 
// Module Name: branch_unit
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


module branch_unit(
    input logic Eq, Lt,
    input logic [2:0] func3,
    input logic is_branch,
    output logic BrUn,
    output logic branch_taken
);

    always_comb begin
        BrUn = 1'b0;
        branch_taken = 1'b0;
        
        if (is_branch) begin
            case(func3)
                3'b000: branch_taken = Eq;       // BEQ
                3'b001: branch_taken = ~Eq;      // BNE
                3'b100: branch_taken = Lt;       // BLT
                3'b101: branch_taken = ~Lt;      // BGE
                3'b110: begin                   // BLTU
                    BrUn = 1'b1; branch_taken = Lt;
                end
                3'b111: begin                   // BGEU
                    BrUn = 1'b1; branch_taken = ~Lt;
                end
                default: ;
            endcase
        end
    end
endmodule