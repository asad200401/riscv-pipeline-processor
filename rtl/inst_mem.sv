`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2026 08:02:41 PM
// Design Name: 
// Module Name: inst_mem
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


module inst_mem(
    input logic [31:0] addr,
    output logic [31:0] instr
);

    logic [31:0] imem [0:511];

    initial begin
        $readmemh("inst_mem.mem", imem);
    end

    assign instr = imem[addr[31:2]];    // Fetch instruction (word-aligned access)

endmodule