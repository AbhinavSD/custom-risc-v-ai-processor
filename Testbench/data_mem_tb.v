`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2026 19:26:53
// Design Name: 
// Module Name: data_mem_tb
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

module data_mem_tb;

reg clk;

reg MemRead;
reg MemWrite;

reg [31:0] addr;
reg [31:0] write_data;

wire [31:0] read_data;

data_mem DUT(

    .clk(clk),

    .MemRead(MemRead),
    .MemWrite(MemWrite),

    .addr(addr),
    .write_data(write_data),

    .read_data(read_data)

);

always #5 clk = ~clk;

initial begin

    clk = 0;

    MemRead = 0;
    MemWrite = 0;

    addr = 0;
    write_data = 0;

    //----------------------------------
    // Write 123 into address 0
    //----------------------------------

    #10;

    MemWrite = 1;
    addr = 32'd0;
    write_data = 32'd123;

    #10;

    MemWrite = 0;

    //----------------------------------
    // Read address 0
    //----------------------------------

    MemRead = 1;
    addr = 32'd0;

    #10;

    //----------------------------------
    // Write 456 into address 4
    //----------------------------------

    MemRead = 0;

    addr = 32'd4;
    write_data = 32'd456;

    MemWrite = 1;

    #10;

    MemWrite = 0;

    //----------------------------------
    // Read address 4
    //----------------------------------

    MemRead = 1;

    #10;

    $finish;

end

initial begin

    $monitor(
    "T=%0t Addr=%0d Write=%0d Read=%0d",
     $time, addr, write_data, read_data);

end

endmodule
