`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2026 20:39:45
// Design Name: 
// Module Name: EX_MEM_tb
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

module EX_MEM_tb;

reg clk;
reg rst;

reg [31:0] alu_result_in;
reg [31:0] write_data_in;
reg [4:0]  rd_in;

reg memread_in;
reg memwrite_in;
reg regwrite_in;
reg memtoreg_in;

wire [31:0] alu_result_out;
wire [31:0] write_data_out;
wire [4:0]  rd_out;

wire memread_out;
wire memwrite_out;
wire regwrite_out;
wire memtoreg_out;

EX_MEM DUT(

    .clk(clk),
    .rst(rst),

    .alu_result_in(alu_result_in),
    .write_data_in(write_data_in),
    .rd_in(rd_in),

    .memread_in(memread_in),
    .memwrite_in(memwrite_in),
    .regwrite_in(regwrite_in),
    .memtoreg_in(memtoreg_in),

    .alu_result_out(alu_result_out),
    .write_data_out(write_data_out),
    .rd_out(rd_out),

    .memread_out(memread_out),
    .memwrite_out(memwrite_out),
    .regwrite_out(regwrite_out),
    .memtoreg_out(memtoreg_out)

);

always #5 clk = ~clk;

initial begin

    clk = 0;
    rst = 1;

    alu_result_in = 0;
    write_data_in = 0;
    rd_in = 0;

    memread_in = 0;
    memwrite_in = 0;
    regwrite_in = 0;
    memtoreg_in = 0;

    #10;
    rst = 0;

    // Example 1 : SW
    alu_result_in = 32'd100;
    write_data_in = 32'd55;
    rd_in = 5'd3;

    memread_in = 0;
    memwrite_in = 1;
    regwrite_in = 0;
    memtoreg_in = 0;

    #10;

    // Example 2 : LW
    alu_result_in = 32'd200;
    write_data_in = 32'd0;
    rd_in = 5'd4;

    memread_in = 1;
    memwrite_in = 0;
    regwrite_in = 1;
    memtoreg_in = 1;

    #20;

    $finish;

end

initial begin

    $monitor(
        "T=%0t ALU=%d WD=%d RD=%d MR=%b MW=%b RW=%b MTR=%b",
        $time,
        alu_result_out,
        write_data_out,
        rd_out,
        memread_out,
        memwrite_out,
        regwrite_out,
        memtoreg_out
    );

end

endmodule
