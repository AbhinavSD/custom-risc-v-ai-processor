`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2026 22:59:20
// Design Name: 
// Module Name: alu_control_tb
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

module alu_control_tb;

reg [2:0] funct3;
reg [6:0] funct7;
reg [1:0] alu_op;

wire [2:0] alu_sel;

alu_control DUT(

    .funct3(funct3),
    .funct7(funct7),
    .alu_op(alu_op),
    .alu_sel(alu_sel)

);

initial begin

    // ADD
    alu_op = 2'b10;
    funct3 = 3'b000;
    funct7 = 7'b0000000;
    #10;

    // SUB
    funct3 = 3'b000;
    funct7 = 7'b0100000;
    #10;

    // AND
    funct3 = 3'b111;
    funct7 = 7'b0000000;
    #10;

    // OR
    funct3 = 3'b110;
    #10;

    // XOR
    funct3 = 3'b100;
    #10;

    // SLT
    funct3 = 3'b010;
    #10;

    $finish;

end

initial begin

    $monitor("Time=%0t funct3=%b funct7=%b alu_sel=%b",
              $time, funct3, funct7, alu_sel);

end

endmodule
