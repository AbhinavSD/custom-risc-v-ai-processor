`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2026 23:40:56
// Design Name: 
// Module Name: control_unit
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


module control_unit(

    input  wire [6:0] opcode,

    output reg        RegWrite,
    output reg        ALUSrc,
    output reg        MemRead,
    output reg        MemWrite,
    output reg        MemtoReg,
    output reg        Branch,

    output reg [1:0]  ALUOp

);

always @(*) begin

    // Defaults
    RegWrite = 0;
    ALUSrc   = 0;
    MemRead  = 0;
    MemWrite = 0;
    MemtoReg = 0;
    Branch   = 0;
    ALUOp    = 2'b00;

    case(opcode)

        // R-Type
        7'b0110011:
        begin
            RegWrite = 1;
            ALUSrc   = 0;
            ALUOp    = 2'b10;
        end

        // AIMAX (Custom AI Instruction)
        7'b1111011:
        begin
            RegWrite = 1;
            ALUSrc   = 0;
            MemRead  = 0;
            MemWrite = 0;
            MemtoReg = 0;
            Branch   = 0;
            ALUOp    = 2'b10;
        end

        // ADDI
        7'b0010011:
        begin
            RegWrite = 1;
            ALUSrc   = 1;
            ALUOp    = 2'b10;
        end

        // LW
        7'b0000011:
        begin
            RegWrite = 1;
            ALUSrc   = 1;
            MemRead  = 1;
            MemtoReg = 1;
            ALUOp    = 2'b00;
        end

        // SW
        7'b0100011:
        begin
            ALUSrc   = 1;
            MemWrite = 1;
            ALUOp    = 2'b00;
        end

        // BEQ
        7'b1100011:
        begin
            Branch = 1;
            ALUOp  = 2'b01;
        end

    endcase

end

endmodule
