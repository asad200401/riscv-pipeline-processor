`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2026 11:00:16 PM
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input logic [6:0] opcode,
    input logic [2:0] func3,
    input logic func7,
    input logic branch_taken,
    output logic [3:0] AluSel,
    output logic regWen,
    output logic bsel, memRw, pcsel, jalr_sel,
    output logic [1:0] asel,
    output logic [1:0] wbsel,
    output logic [2:0] imm_sel,
    output logic is_branch      
);

    always_comb begin
        regWen = 1'b0;
        AluSel = 4'b0000;
        bsel = 1'b0;
        memRw = 1'b0;
        pcsel = 1'b0;
        jalr_sel = 1'b0;
        asel = 2'b00;
        wbsel = 2'b00;
        imm_sel = 3'b000;
        is_branch = 1'b0;

            case(opcode)
                7'b0110011: begin // R-type
                    regWen = 1'b1;
                    AluSel = {func7, func3};
                    bsel = 1'b0;
                    asel = 2'b00;
                    wbsel = 2'b01;
                end
                7'b0010011: begin // I-type
                    regWen = 1'b1;
                    AluSel = ((func3 == 3'b101) || (func3 == 3'b001)) ? {func7, func3} : {1'b0, func3};
                    bsel = 1'b1;
                    asel = 2'b00;
                    wbsel = 2'b01;
                    imm_sel = 3'b000;
                end
                7'b0000011: begin // Load
                    regWen = 1'b1;
                    AluSel = 4'b0000;
                    bsel = 1'b1;
                    memRw = 1'b0;
                    wbsel = 2'b00;
                    imm_sel = 3'b000;
                end
                7'b0100011: begin // Store
                    regWen = 1'b0;
                    AluSel = 4'b0000;
                    bsel = 1'b1;
                    memRw = 1'b1;
                    imm_sel = 3'b001;
                end
                7'b1101111: begin // JAL
                    regWen = 1'b1;
                    AluSel = 4'b0000;
                    bsel = 1'b1;
                    asel = 2'b01;
                    wbsel = 2'b10;
                    imm_sel = 3'b010;
                    pcsel = 1'b1;
                end
                7'b1100111: begin // JALR
                    if(func3 == 3'b000) begin
                        regWen = 1'b1;
                        AluSel = 4'b0000;
                        bsel = 1'b1;
                        asel = 2'b00;
                        wbsel = 2'b10;
                        imm_sel = 3'b000;
                        pcsel = 1'b1;
                        jalr_sel = 1'b1;
                    end
                end
                7'b1100011: begin // Branch
                    regWen = 1'b0;
                    AluSel = 4'b0000;
                    bsel = 1'b1;
                    asel = 2'b01;
                    imm_sel = 3'b011;
                    is_branch = 1'b1; 
                end
                7'b0110111: begin // LUI
                    regWen = 1'b1;
                    AluSel = 4'b0000;
                    bsel = 1'b1;
                    asel = 2'b10;
                    wbsel = 2'b01;
                    imm_sel = 3'b100;
                end
                7'b0010111: begin // AUIPC
                    regWen = 1'b1;
                    AluSel = 4'b0000;
                    bsel = 1'b1;
                    asel = 2'b01;
                    wbsel = 2'b01;
                    imm_sel = 3'b100;
                end
                default: begin
                end
            endcase
    end
endmodule


