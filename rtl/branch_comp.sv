`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2026 01:58:33 PM
// Design Name: 
// Module Name: branch_comp
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


module branch_comp(
    input logic [31:0] data1, data2,
    input logic BrUn,
    output logic Eq, Lt
);

    assign Eq = (data1 == data2);
    assign Lt = BrUn ? ($unsigned(data1) < $unsigned(data2)) : ($signed(data1) < $signed(data2));

endmodule

