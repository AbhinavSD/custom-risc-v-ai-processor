`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2026 17:36:08
// Design Name: 
// Module Name: alu_tb
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

module alu_tb;

reg [31:0] a;
reg [31:0] b;
reg [2:0]  alu_sel;

wire [31:0] result;

alu DUT(
    .a(a),
    .b(b),
    .alu_sel(alu_sel),
    .result(result)
);

initial begin

    // ADD
    a = 20;
    b = 10;
    alu_sel = 3'b000;
    #10;

    // SUB
    alu_sel = 3'b001;
    #10;

    // AND
    alu_sel = 3'b010;
    #10;

    // OR
    alu_sel = 3'b011;
    #10;

    // XOR
    alu_sel = 3'b100;
    #10;

    // SLT
    alu_sel = 3'b101;
    #10;

    $finish;

end

initial begin

    $monitor("Time=%0t ALU_SEL=%b A=%d B=%d RESULT=%d",
              $time, alu_sel, a, b, result);

end

endmodule
