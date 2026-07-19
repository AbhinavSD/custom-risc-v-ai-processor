`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2026 18:02:18
// Design Name: 
// Module Name: pipeline_top_tb
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


`timescale 1ns / 1ps

module pipeline_top_tb;

reg clk;
reg rst;

//=====================================================
// DUT
//=====================================================

pipeline_top DUT (

    .clk(clk),
    .rst(rst)

);

//=====================================================
// Clock Generation
//=====================================================

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

//=====================================================
// Reset
//=====================================================

initial begin
    rst = 1;
    #20;
    rst = 0;
end

//=====================================================
// Console Monitor
//=====================================================

initial begin

    $display("==========================================================================================");
    $display("TIME | A | B | ALUSEL | ALU_RESULT | WB_RD | WB_DATA");
    $display("==========================================================================================");

$monitor(
"%0t | %h | %h | %b | %h | %d | %h",
$time,
DUT.alu_in1,
DUT.alu_in2,
DUT.alu_sel,
DUT.alu_result,
DUT.wb_rd,
DUT.wb_data
);

end

//=====================================================
// Waveform Dump
//=====================================================

initial begin

    $dumpfile("pipeline_top.vcd");
    $dumpvars(0, pipeline_top_tb);

end

//=====================================================
// Simulation Stop
//=====================================================

initial begin

    #300;

    $display("\n====================================");
    $display(" Simulation Completed ");
    $display("====================================");

    $finish;

end

endmodule
