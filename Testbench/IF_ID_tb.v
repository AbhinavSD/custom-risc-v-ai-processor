`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2026 19:20:01
// Design Name: 
// Module Name: IF_ID_tb
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

module IF_ID_tb;

reg clk;
reg rst;

reg [31:0] pc_in;
reg [31:0] instr_in;

wire [31:0] pc_out;
wire [31:0] instr_out;

IF_ID DUT(

    .clk(clk),
    .rst(rst),

    .pc_in(pc_in),
    .instr_in(instr_in),

    .pc_out(pc_out),
    .instr_out(instr_out)

);

always #5 clk = ~clk;

initial begin

    clk = 0;
    rst = 1;

    pc_in = 0;
    instr_in = 0;

    #10;

    rst = 0;

    pc_in = 32'h00000000;
    instr_in = 32'h00500093;

    #10;

    pc_in = 32'h00000004;
    instr_in = 32'h00700113;

    #10;

    pc_in = 32'h00000008;
    instr_in = 32'h002081B3;

    #20;

    $finish;

end

endmodule
