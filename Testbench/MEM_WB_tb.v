`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2026 18:05:56
// Design Name: 
// Module Name: MEM_WB_tb
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


`timescale 1ns/1ps

module MEM_WB_tb;

reg clk;
reg rst;

reg [31:0] mem_data_in;
reg [31:0] alu_result_in;
reg [4:0]  rd_in;

reg regwrite_in;
reg memtoreg_in;

wire [31:0] mem_data_out;
wire [31:0] alu_result_out;
wire [4:0]  rd_out;

wire regwrite_out;
wire memtoreg_out;

MEM_WB DUT(

    .clk(clk),
    .rst(rst),

    .mem_data_in(mem_data_in),
    .alu_result_in(alu_result_in),
    .rd_in(rd_in),

    .regwrite_in(regwrite_in),
    .memtoreg_in(memtoreg_in),

    .mem_data_out(mem_data_out),
    .alu_result_out(alu_result_out),
    .rd_out(rd_out),

    .regwrite_out(regwrite_out),
    .memtoreg_out(memtoreg_out)

);

always #5 clk = ~clk;

initial begin

    clk = 0;
    rst = 1;

    mem_data_in = 0;
    alu_result_in = 0;
    rd_in = 0;

    regwrite_in = 0;
    memtoreg_in = 0;

    #10;
    rst = 0;

    // Example 1 : ADD

    mem_data_in = 0;
    alu_result_in = 32'd12;
    rd_in = 5'd3;

    regwrite_in = 1;
    memtoreg_in = 0;

    #10;

    // Example 2 : LW

    mem_data_in = 32'd55;
    alu_result_in = 32'd100;
    rd_in = 5'd4;

    regwrite_in = 1;
    memtoreg_in = 1;

    #20;

    $finish;

end

initial begin

    $monitor(
    "T=%0t MEM=%d ALU=%d RD=%d RW=%b MTR=%b",
    $time,
    mem_data_out,
    alu_result_out,
    rd_out,
    regwrite_out,
    memtoreg_out
    );
end

endmodule
