`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2026 07:45:39 PM
// Design Name: 
// Module Name: data_mem
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


module data_mem(
    input logic clk,
    input logic [31:0] addr, dataW,
    input logic memRw,
    input logic [2:0] func3,
    output logic [31:0] dataR
);

    logic [31:0] dmem [0:511];
    logic [31:0] data;

    always_comb begin
        if(!memRw)
            data = dmem[addr[31:2]];    // Fetch word from memory
        else
            data = 32'd0;
    end

    // read(domb)
    always_comb begin
        dataR = 32'd0;
        if(!memRw) begin
            case(func3)
                3'b000: begin  // LB
                    case(addr[1:0])
                        2'd0: dataR = {{24{data[7]}}, data[7:0]};
                        2'd1: dataR = {{24{data[15]}}, data[15:8]};
                        2'd2: dataR = {{24{data[23]}}, data[23:16]};
                        2'd3: dataR = {{24{data[31]}}, data[31:24]};
                        default: dataR = 32'd0;
                    endcase
                end
                3'b001: begin  // LH
                    case(addr[1])
                        1'b0: dataR = {{16{data[15]}}, data[15:0]};
                        1'b1: dataR = {{16{data[31]}}, data[31:16]};
                        default: dataR = 32'd0;
                    endcase
                end
                3'b010: dataR = data;  // LW
                3'b100: begin  // LBU
                    case(addr[1:0])
                        2'd0: dataR = {24'd0, data[7:0]};
                        2'd1: dataR = {24'd0, data[15:8]};
                        2'd2: dataR = {24'd0, data[23:16]};
                        2'd3: dataR = {24'd0, data[31:24]};
                        default: dataR = 32'd0;
                    endcase
                end
                3'b101: begin  // LHU
                    case(addr[1])
                        1'b0: dataR = {16'd0, data[15:0]};
                        1'b1: dataR = {16'd0, data[31:16]};
                        default: dataR = 32'd0;
                    endcase
                end
                default: dataR = 32'd0;
            endcase
        end
    end

    // write(seq)
    always_ff @(posedge clk) begin
        if(memRw) begin
            case(func3)
                3'b000: begin  // SB
                    case(addr[1:0])
                        2'd0: dmem[addr[31:2]][7:0]   <= dataW[7:0];
                        2'd1: dmem[addr[31:2]][15:8]  <= dataW[7:0];
                        2'd2: dmem[addr[31:2]][23:16] <= dataW[7:0];
                        2'd3: dmem[addr[31:2]][31:24] <= dataW[7:0];
                        default: ;
                    endcase
                end
                3'b001: begin  // SH
                    case(addr[1])
                        1'b0: dmem[addr[31:2]][15:0]  <= dataW[15:0];
                        1'b1: dmem[addr[31:2]][31:16] <= dataW[15:0];
                        default: ;
                    endcase
                end
                3'b010: dmem[addr[31:2]] <= dataW; // SW
                default: ;
            endcase
        end
    end
endmodule