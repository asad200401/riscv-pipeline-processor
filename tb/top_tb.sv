`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2026 11:22:21 PM
// Design Name: 
// Module Name: top_tb
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


module top_tb;
    logic clk;
    logic rst;

    top dut (.clk(clk),.rst(rst));

    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        rst = 1;
        #20;
        rst = 0;
        #1000;   
        $finish;
    end
endmodule







