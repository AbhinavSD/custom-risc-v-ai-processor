`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2026 20:34:06
// Design Name: 
// Module Name: pc_tb
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

module pc_tb;

reg clk;
reg rst;
wire [31:0] pc_out;

pc DUT (
    .clk(clk),
    .rst(rst),
    .pc_out(pc_out)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;

    #10;
    rst = 0;

    #100;

    $finish;
end

initial begin
    $monitor("Time=%0t  PC=%0d", $time, pc_out);
end

endmodule
