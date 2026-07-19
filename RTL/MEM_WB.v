`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2026 18:04:36
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(

    input wire clk,
    input wire rst,

    input wire [31:0] mem_data_in,
    input wire [31:0] alu_result_in,
    input wire [31:0] pc_plus4_in,

    input wire [4:0] rd_in,

    input wire regwrite_in,
    input wire memtoreg_in,

    output reg [31:0] mem_data_out,
    output reg [31:0] alu_result_out,
    output reg [31:0] pc_plus4_out,

    output reg [4:0] rd_out,

    output reg regwrite_out,
    output reg memtoreg_out

);

always @(posedge clk) begin

    if(rst) begin

        mem_data_out   <= 32'd0;
        alu_result_out <= 32'd0;
        pc_plus4_out   <= 32'd0;

        rd_out         <= 5'd0;

        regwrite_out   <= 1'b0;
        memtoreg_out   <= 1'b0;

    end
    else begin

        mem_data_out   <= mem_data_in;
        alu_result_out <= alu_result_in;
        pc_plus4_out   <= pc_plus4_in;

        rd_out         <= rd_in;

        regwrite_out   <= regwrite_in;
        memtoreg_out   <= memtoreg_in;

    end

end

endmodule
