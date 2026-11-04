`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2026 10:53:00 PM
// Design Name: 
// Module Name: pc_plus_4
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


module pc_plus_4(
    input logic [31:0] pc_in,
    output logic [31:0] pc_out
);

    assign pc_out = pc_in + 32'd4;
    
endmodule