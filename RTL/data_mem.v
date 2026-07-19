`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2026 19:25:30
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

    input wire clk,

    input wire MemRead,
    input wire MemWrite,

    input wire [31:0] addr,
    input wire [31:0] write_data,

    output reg [31:0] read_data

);

    reg [31:0] mem [0:255];

    integer i;

    initial begin

        for(i=0;i<256;i=i+1)
            mem[i] = 32'd0;

    end

    // Write Operation
    always @(posedge clk) begin

        if(MemWrite)
            mem[addr[31:2]] <= write_data;

    end

    // Read Operation
    always @(*) begin

        if(MemRead)
            read_data = mem[addr[31:2]];
        else
            read_data = 32'd0;

    end

endmodule
