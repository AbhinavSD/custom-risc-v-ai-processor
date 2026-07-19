`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2026 20:14:18
// Design Name: 
// Module Name: single_cycle_top
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


module single_cycle_top(

    input wire clk,
    input wire rst,

    // Debug Outputs
    output wire [31:0] debug_pc,
    output wire [31:0] debug_instr,
    output wire [31:0] debug_alu

);

    //--------------------------------------------------
    // PC
    //--------------------------------------------------

    wire [31:0] pc;
    wire [31:0] pc_next;

    assign pc_next = pc + 32'd4;

    pc pc_inst(
        .clk(clk),
        .rst(rst),
        .pc_next(pc_next),
        .pc(pc)
    );

    //--------------------------------------------------
    // Instruction Memory
    //--------------------------------------------------

    wire [31:0] instruction;

    instr_mem imem(
        .addr(pc),
        .instruction(instruction)
    );

    //--------------------------------------------------
    // Instruction Decode Fields
    //--------------------------------------------------

    wire [6:0] opcode;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;
    wire [2:0] funct3;
    wire [6:0] funct7;

    assign opcode = instruction[6:0];
    assign rd     = instruction[11:7];
    assign funct3 = instruction[14:12];
    assign rs1    = instruction[19:15];
    assign rs2    = instruction[24:20];
    assign funct7 = instruction[31:25];

    //--------------------------------------------------
    // Control Unit
    //--------------------------------------------------

    wire RegWrite;
    wire ALUSrc;
    wire MemRead;
    wire MemWrite;
    wire MemtoReg;
    wire Branch;

    wire [1:0] ALUOp;

    control_unit CU(

        .opcode(opcode),

        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .Branch(Branch),

        .ALUOp(ALUOp)

    );

    //--------------------------------------------------
    // Register File
    //--------------------------------------------------

    wire [31:0] rd1;
    wire [31:0] rd2;

    wire [31:0] write_back_data;

    reg_file RF(

        .clk(clk),
        .we(RegWrite),

        .rs1(rs1),
        .rs2(rs2),

        .rd(rd),
        .wd(write_back_data),

        .rd1(rd1),
        .rd2(rd2)

    );

    //--------------------------------------------------
    // Immediate Generator
    //--------------------------------------------------

    wire [31:0] imm_out;

    imm_gen IMM(

        .instruction(instruction),
        .imm_out(imm_out)

    );

    //--------------------------------------------------
    // ALU Control
    //--------------------------------------------------

    wire [2:0] alu_sel;

    alu_control ALUCTRL(

        .funct3(funct3),
        .funct7(funct7),
        .opcode(opcode),      // Added for ADDI fix
        .alu_op(ALUOp),

        .alu_sel(alu_sel)

    );

    //--------------------------------------------------
    // ALU Operand MUX
    //--------------------------------------------------

    wire [31:0] alu_b;

    assign alu_b = (ALUSrc) ? imm_out : rd2;

    //--------------------------------------------------
    // ALU
    //--------------------------------------------------

    wire [31:0] alu_result;

    alu ALU(

        .a(rd1),
        .b(alu_b),

        .alu_sel(alu_sel),

        .result(alu_result)

    );

    //--------------------------------------------------
    // Data Memory
    //--------------------------------------------------

    wire [31:0] mem_data;

    data_mem DMEM(

        .clk(clk),

        .MemRead(MemRead),
        .MemWrite(MemWrite),

        .addr(alu_result),
        .write_data(rd2),

        .read_data(mem_data)

    );

    //--------------------------------------------------
    // Write Back MUX
    //--------------------------------------------------

    assign write_back_data =
            (MemtoReg) ? mem_data :
                         alu_result;

    //--------------------------------------------------
    // Debug Outputs
    //--------------------------------------------------

    assign debug_pc    = pc;
    assign debug_instr = instruction;
    assign debug_alu   = alu_result;

endmodule
