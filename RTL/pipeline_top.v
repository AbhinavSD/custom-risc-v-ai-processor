`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2026 18:33:18
// Design Name: 
// Module Name: pipeline_top
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

module pipeline_top(

    input wire clk,
    input wire rst

);

//=====================================================
// IF STAGE
//=====================================================

wire [31:0] pc_current;
wire [31:0] pc_next;

assign pc_next =
       (branch_taken)
       ? branch_target
       : (pc_current + 32'd4);

pc PC(

    .clk(clk),
    .rst(rst),

    .pc_write(pc_write),

    .pc_next(pc_next),

    .pc(pc_current)

);

wire [31:0] instruction;

instr_mem IMEM(

    .addr(pc_current),
    .instruction(instruction)

);

//=====================================================
// IF/ID
//=====================================================

wire [31:0] ifid_pc;
wire [31:0] ifid_instr;
wire [31:0] ifid_pc_plus4;

assign ifid_pc_plus4 =
       ifid_pc + 32'd4;
IF_ID IFID(

    .clk(clk),
    .rst(rst),

    .ifid_write(ifid_write),
    .flush(branch_taken),
    .pc_in(pc_current),
    .instr_in(instruction),

    .pc_out(ifid_pc),
    .instr_out(ifid_instr)

);

//=====================================================
// ID STAGE
//=====================================================

wire [4:0] rs1;
wire [4:0] rs2;
wire [4:0] rd;

assign rs1 = ifid_instr[19:15];
assign rs2 = ifid_instr[24:20];
assign rd  = ifid_instr[11:7];
wire [2:0] funct3;
wire [6:0] funct7;
wire [6:0] opcode;

assign funct3 = ifid_instr[14:12];
assign funct7 = ifid_instr[31:25];
assign opcode = ifid_instr[6:0];
hazard_detection HDU(

    .idex_memread(idex_memread),
    .idex_rd(idex_rd),

    .ifid_rs1(rs1),
    .ifid_rs2(rs2),

    .pc_write(pc_write),
    .ifid_write(ifid_write),
    .control_flush(control_flush)

);
//-----------------------------------------------------
// Writeback signals
//-----------------------------------------------------

wire        wb_regwrite;
wire [4:0]  wb_rd;
wire [31:0] wb_data;

//-----------------------------------------------------
// Register File
//-----------------------------------------------------

wire [31:0] rd1;
wire [31:0] rd2;

reg_file RF(

    .clk(clk),
    .we(wb_regwrite),

    .rs1(rs1),
    .rs2(rs2),

    .rd(wb_rd),
    .wd(wb_data),

    .rd1(rd1),
    .rd2(rd2)

);

//-----------------------------------------------------
// Immediate Generator
//-----------------------------------------------------

wire [31:0] imm_out;

imm_gen IMM(

    .instruction(ifid_instr),
    .imm_out(imm_out)

);

//-----------------------------------------------------
// Control Unit
//-----------------------------------------------------

wire RegWrite;
wire ALUSrc;
wire MemRead;
wire MemWrite;
wire MemtoReg;
wire Branch;

wire [1:0] ALUOp;
//-----------------------------------------------------
// Hazard Detection Signals
//-----------------------------------------------------

wire pc_write;
wire ifid_write;
wire control_flush;
control_unit CTRL(

    .opcode(ifid_instr[6:0]),

    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .MemtoReg(MemtoReg),
    .Branch(Branch),

    .ALUOp(ALUOp)

);

//=====================================================
// ID/EX
//=====================================================

wire [31:0] idex_pc;
wire [31:0] idex_pc_plus4;
wire [31:0] idex_rs1;
wire [31:0] idex_rs2;
wire [31:0] idex_imm;

wire [4:0] idex_rs1_addr;
wire [4:0] idex_rs2_addr;

wire [4:0] idex_rd;
wire [2:0] idex_funct3;
wire [6:0] idex_funct7;
wire [6:0] idex_opcode;
wire idex_regwrite;
wire idex_alusrc;
wire idex_memread;
wire idex_memwrite;
wire idex_memtoreg;
wire idex_branch;
wire [1:0] idex_aluop;

ID_EX IDEX(

    .clk(clk),
    .rst(rst),

    .pc_in(ifid_pc),
    .pc_plus4_in(ifid_pc_plus4),
    .rs1_data_in(rd1),
    .rs2_data_in(rd2),

    .imm_in(imm_out),

    .rs1_addr_in(rs1),
    .rs2_addr_in(rs2),

    .rd_in(rd),
    .funct3_in(funct3),
    .funct7_in(funct7),
    .opcode_in(opcode),
    .regwrite_in(control_flush ? 1'b0 : RegWrite),
    .alusrc_in(control_flush ? 1'b0 : ALUSrc),

    .memread_in(control_flush ? 1'b0 : MemRead),
    .memwrite_in(control_flush ? 1'b0 : MemWrite),
    .memtoreg_in(control_flush ? 1'b0 : MemtoReg),

    .branch_in(control_flush ? 1'b0 : Branch),

    .aluop_in(control_flush ? 2'b00 : ALUOp),

    .pc_out(idex_pc),
    .pc_plus4_out(idex_pc_plus4),
    .rs1_data_out(idex_rs1),
    .rs2_data_out(idex_rs2),

    .imm_out(idex_imm),

    .rs1_addr_out(idex_rs1_addr),
    .rs2_addr_out(idex_rs2_addr),

    .rd_out(idex_rd),
    .funct3_out(idex_funct3),
    .funct7_out(idex_funct7),
    .opcode_out(idex_opcode),
    .regwrite_out(idex_regwrite),
    .alusrc_out(idex_alusrc),

    .memread_out(idex_memread),
    .memwrite_out(idex_memwrite),
    .memtoreg_out(idex_memtoreg),
    .branch_out(idex_branch),

    .aluop_out(idex_aluop)

);
//=====================================================
// FORWARDING UNIT
//=====================================================

wire [1:0] forwardA;
wire [1:0] forwardB;

forwarding_unit FU(

    .idex_rs1(idex_rs1_addr),
    .idex_rs2(idex_rs2_addr),

    .exmem_rd(exmem_rd),
    .exmem_regwrite(exmem_regwrite),

    .memwb_rd(memwb_rd),
    .memwb_regwrite(memwb_regwrite),

    .forwardA(forwardA),
    .forwardB(forwardB)

);
//=====================================================
// EX STAGE
//=====================================================
//-----------------------------------------------------
// Branch Target Calculation
//-----------------------------------------------------

wire [31:0] branch_target;

assign branch_target =
       idex_pc + idex_imm;
//-----------------------------------------------------
// Branch Comparator
//-----------------------------------------------------

wire branch_equal;

assign branch_equal =
       (alu_in1 == alu_in2);
 //-----------------------------------------------------
// Branch Decision
//-----------------------------------------------------

wire branch_taken;

assign branch_taken =
       idex_branch & branch_equal;      
//-----------------------------------------------------
// ALU CONTROL
//-----------------------------------------------------

wire [2:0] alu_sel;

alu_control ALUCTRL(

    .funct3(idex_funct3),
    .funct7(idex_funct7),
    .opcode(idex_opcode),

    .alu_op(idex_aluop),

    .alu_sel(alu_sel)

);

//-----------------------------------------------------
// Forwarding Muxes
//-----------------------------------------------------

wire [31:0] alu_in1;
wire [31:0] alu_in2;

assign alu_in1 =
       (forwardA == 2'b00) ? idex_rs1 :
       (forwardA == 2'b10) ? exmem_alu_result :
       (forwardA == 2'b01) ? wb_data :
                             idex_rs1;

assign alu_in2 =
       (forwardB == 2'b00) ? idex_rs2 :
       (forwardB == 2'b10) ? exmem_alu_result :
       (forwardB == 2'b01) ? wb_data :
                             idex_rs2;

//-----------------------------------------------------
// ALU Source Mux
//-----------------------------------------------------

wire [31:0] alu_b;

assign alu_b =
       (idex_alusrc)
       ? idex_imm
       : alu_in2;

//-----------------------------------------------------
// ALU
//-----------------------------------------------------

wire [31:0] alu_result;

alu ALU(

    .a(alu_in1),
    .b(alu_b),

    .alu_sel(alu_sel),

    .result(alu_result)

);

//=====================================================
// EX/MEM
//=====================================================

wire [31:0] exmem_alu_result;
wire [31:0] exmem_write_data;
wire [31:0] exmem_pc_plus4;
wire [4:0] exmem_rd;

wire exmem_memread;
wire exmem_memwrite;
wire exmem_regwrite;
wire exmem_memtoreg;
wire exmem_branch;
EX_MEM EXMEM(

    .clk(clk),
    .rst(rst),

    .alu_result_in(alu_result),
    .write_data_in(alu_in2),
    .pc_plus4_in(idex_pc_plus4),
    .rd_in(idex_rd),

    .memread_in(idex_memread),
    .memwrite_in(idex_memwrite),
    .regwrite_in(idex_regwrite),
    .memtoreg_in(idex_memtoreg),

    .branch_in(idex_branch),

    .alu_result_out(exmem_alu_result),
    .write_data_out(exmem_write_data),
    .pc_plus4_out(exmem_pc_plus4),
    .rd_out(exmem_rd),

    .memread_out(exmem_memread),
    .memwrite_out(exmem_memwrite),
    .regwrite_out(exmem_regwrite),
    .memtoreg_out(exmem_memtoreg),

    .branch_out(exmem_branch)

);

//=====================================================
// MEM STAGE
//=====================================================

wire [31:0] mem_read_data;

data_mem DMEM(

    .clk(clk),

    .MemRead(exmem_memread),
    .MemWrite(exmem_memwrite),

    .addr(exmem_alu_result),
    .write_data(exmem_write_data),

    .read_data(mem_read_data)

);

//=====================================================
// MEM/WB
//=====================================================

wire [31:0] memwb_mem_data;
wire [31:0] memwb_alu_result;
wire [31:0] memwb_pc_plus4;
wire [4:0] memwb_rd;

wire memwb_regwrite;
wire memwb_memtoreg;
wire memwb_jal;

MEM_WB MEMWB(

    .clk(clk),
    .rst(rst),

    .mem_data_in(mem_read_data),
    .alu_result_in(exmem_alu_result),
    .pc_plus4_in(exmem_pc_plus4),
    .rd_in(exmem_rd),

    .regwrite_in(exmem_regwrite),
    .memtoreg_in(exmem_memtoreg),

    .mem_data_out(memwb_mem_data),
    .alu_result_out(memwb_alu_result),
    .pc_plus4_out(memwb_pc_plus4),
    .rd_out(memwb_rd),

    .regwrite_out(memwb_regwrite),
    .memtoreg_out(memwb_memtoreg)

);

//=====================================================
// WB STAGE
//=====================================================
assign memwb_jal = 1'b0;
assign wb_regwrite = memwb_regwrite;

assign wb_rd = memwb_rd;

assign wb_data =
        (memwb_jal)
        ? memwb_pc_plus4
        :
        (memwb_memtoreg)
        ? memwb_mem_data
        : memwb_alu_result;

endmodule
