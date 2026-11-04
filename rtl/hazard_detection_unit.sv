`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2026 02:50:32 PM
// Design Name: 
// Module Name: hazard_detection_unit
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


module hazard_detection_unit (
    input logic [4:0] id_ex_rd,
    input logic [1:0] id_ex_wbsel, // 2'b00 indicates load instruction (dmem read)
    input logic [4:0] if_id_rs1,
    input logic [4:0] if_id_rs2,
    input logic branch_taken,
    output logic pc_write,
    output logic if_id_write,
    output logic id_ex_flush
);

    // detect load-use hazard: if id/ex is a load (wbsel == 2'b00 and regWen) and its destination matches current rs1 or rs2
    // (note: we check if wbsel == 2'b00 which is dmem read)
    logic load_use_hazard;
    always_comb begin
        load_use_hazard = (id_ex_rd != 5'd0) && (id_ex_rd == if_id_rs1 || id_ex_rd == if_id_rs2) && (id_ex_wbsel == 2'b00);
        if (load_use_hazard || branch_taken) begin
            pc_write = 1'b0;
            if_id_write = 1'b0;
            id_ex_flush = 1'b1;
        end else begin
            pc_write = 1'b1;
            if_id_write = 1'b1;
            id_ex_flush = 1'b0;
        end
    end
endmodule
