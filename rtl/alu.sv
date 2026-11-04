`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2026 10:22:19 PM
// Design Name: 
// Module Name: alu
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


module alu(
    input logic [31:0] op1, op2,
    input logic [3:0] AluSel,
    output logic [31:0] alu_result
);

    always_comb begin
        case(AluSel)
            4'd0:  alu_result = op1 + op2;  // ADD
            4'd8:  alu_result = op1 - op2;  // SUB
            4'd1:  alu_result = op1 << op2[4:0];  // SLL
            4'd2:  alu_result = {31'b0, ($signed(op1) < $signed(op2))};  //SLT
            4'd3:  alu_result = {31'b0, (op1 < op2)};  //SLTU
            4'd4:  alu_result = op1 ^ op2;  // XOR
            4'd5:  alu_result = op1 >> op2[4:0]; // SRL
            4'd13: alu_result = $signed(op1) >>> op2[4:0];  //SRA
            4'd6:  alu_result = op1 | op2;  // OR
            4'd7:  alu_result = op1 & op2;  // AND
            default: alu_result = 32'd0;
        endcase
    end
endmodule