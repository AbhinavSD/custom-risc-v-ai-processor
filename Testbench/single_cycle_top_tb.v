`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2026 22:24:21
// Design Name: 
// Module Name: single_cycle_top_tb
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

module single_cycle_top_tb;

reg clk;
reg rst;

wire [31:0] debug_pc;
wire [31:0] debug_instr;
wire [31:0] debug_alu;

single_cycle_top DUT(

    .clk(clk),
    .rst(rst),

    .debug_pc(debug_pc),
    .debug_instr(debug_instr),
    .debug_alu(debug_alu)

);

always #5 clk = ~clk;

initial begin

    clk = 0;
    rst = 1;

    #20;
    rst = 0;

    // Run enough cycles
    #150;

    $display("\n=================================");
    $display("FINAL REGISTER VALUES");
    $display("=================================");

    $display("x1 = %0d", DUT.RF.regs[1]);
    $display("x2 = %0d", DUT.RF.regs[2]);
    $display("x3 = %0d", DUT.RF.regs[3]);
    $display("x4 = %0d", DUT.RF.regs[4]);

    $display("\n=================================");
    $display("DATA MEMORY");
    $display("=================================");

    $display("mem[0] = %0d", DUT.DMEM.mem[0]);

    $finish;

end

always @(posedge clk) begin

    if(!rst) begin

        $display(
        "T=%0t PC=%h INSTR=%h ALU=%h",
        $time,
        debug_pc,
        debug_instr,
        debug_alu
        );

    end

end

endmodule
