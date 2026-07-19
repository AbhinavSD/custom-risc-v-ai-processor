`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2026 23:42:10
// Design Name: 
// Module Name: control_unit_tb
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

module control_unit_tb;

reg [6:0] opcode;

wire RegWrite;
wire ALUSrc;
wire MemRead;
wire MemWrite;
wire MemtoReg;
wire Branch;
wire [1:0] ALUOp;

control_unit DUT(

    .opcode(opcode),

    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .MemtoReg(MemtoReg),
    .Branch(Branch),

    .ALUOp(ALUOp)

);

initial begin

    // R-Type
    opcode = 7'b0110011;
    #10;

    // ADDI
    opcode = 7'b0010011;
    #10;

    // LW
    opcode = 7'b0000011;
    #10;

    // SW
    opcode = 7'b0100011;
    #10;

    // BEQ
    opcode = 7'b1100011;
    #10;

    $finish;

end

initial begin

    $monitor(
    "opcode=%b RegWrite=%b ALUSrc=%b MemRead=%b MemWrite=%b MemtoReg=%b Branch=%b ALUOp=%b",
     opcode, RegWrite, ALUSrc, MemRead,
     MemWrite, MemtoReg, Branch, ALUOp);

end

endmodule
