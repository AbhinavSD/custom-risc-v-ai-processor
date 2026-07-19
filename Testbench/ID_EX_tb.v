`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2026 20:01:01
// Design Name: 
// Module Name: ID_EX_tb
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

module ID_EX_tb;

reg clk;
reg rst;

// Data Inputs
reg [31:0] pc_in;
reg [31:0] rs1_data_in;
reg [31:0] rs2_data_in;
reg [31:0] imm_in;
reg [4:0]  rd_in;

// Control Inputs
reg regwrite_in;
reg alusrc_in;
reg memread_in;
reg memwrite_in;
reg memtoreg_in;
reg [1:0] aluop_in;

// Data Outputs
wire [31:0] pc_out;
wire [31:0] rs1_data_out;
wire [31:0] rs2_data_out;
wire [31:0] imm_out;
wire [4:0]  rd_out;

// Control Outputs
wire regwrite_out;
wire alusrc_out;
wire memread_out;
wire memwrite_out;
wire memtoreg_out;
wire [1:0] aluop_out;

// DUT
ID_EX DUT(

    .clk(clk),
    .rst(rst),

    .pc_in(pc_in),
    .rs1_data_in(rs1_data_in),
    .rs2_data_in(rs2_data_in),
    .imm_in(imm_in),
    .rd_in(rd_in),

    .regwrite_in(regwrite_in),
    .alusrc_in(alusrc_in),
    .memread_in(memread_in),
    .memwrite_in(memwrite_in),
    .memtoreg_in(memtoreg_in),
    .aluop_in(aluop_in),

    .pc_out(pc_out),
    .rs1_data_out(rs1_data_out),
    .rs2_data_out(rs2_data_out),
    .imm_out(imm_out),
    .rd_out(rd_out),

    .regwrite_out(regwrite_out),
    .alusrc_out(alusrc_out),
    .memread_out(memread_out),
    .memwrite_out(memwrite_out),
    .memtoreg_out(memtoreg_out),
    .aluop_out(aluop_out)

);

// Clock Generation
always #5 clk = ~clk;

// Stimulus
initial begin

    clk = 0;
    rst = 1;

    pc_in = 0;
    rs1_data_in = 0;
    rs2_data_in = 0;
    imm_in = 0;
    rd_in = 0;

    regwrite_in = 0;
    alusrc_in   = 0;
    memread_in  = 0;
    memwrite_in = 0;
    memtoreg_in = 0;
    aluop_in    = 2'b00;

    // Reset active
    #10;
    rst = 0;

    // ------------------------
    // Test Case 1 : SW Type
    // ------------------------

    pc_in        = 32'h00000000;
    rs1_data_in  = 32'd5;
    rs2_data_in  = 32'd7;
    imm_in       = 32'd12;
    rd_in        = 5'd3;

    regwrite_in  = 1'b0;
    alusrc_in    = 1'b1;

    memread_in   = 1'b0;
    memwrite_in  = 1'b1;
    memtoreg_in  = 1'b0;

    aluop_in     = 2'b00;

    #10;

    // ------------------------
    // Test Case 2 : LW Type
    // ------------------------

    pc_in        = 32'h00000004;
    rs1_data_in  = 32'd10;
    rs2_data_in  = 32'd20;
    imm_in       = 32'd100;
    rd_in        = 5'd4;

    regwrite_in  = 1'b1;
    alusrc_in    = 1'b1;

    memread_in   = 1'b1;
    memwrite_in  = 1'b0;
    memtoreg_in  = 1'b1;

    aluop_in     = 2'b00;

    #10;

    // ------------------------
    // Test Case 3 : R-Type ADD
    // ------------------------

    pc_in        = 32'h00000008;
    rs1_data_in  = 32'd15;
    rs2_data_in  = 32'd25;
    imm_in       = 32'd0;
    rd_in        = 5'd5;

    regwrite_in  = 1'b1;
    alusrc_in    = 1'b0;

    memread_in   = 1'b0;
    memwrite_in  = 1'b0;
    memtoreg_in  = 1'b0;

    aluop_in     = 2'b10;

    #20;

    $finish;

end

// Monitor

initial begin

    $monitor(
    "T=%0t | PC=%h | RS1=%d | RS2=%d | IMM=%d | RD=%d | RW=%b | AS=%b | MR=%b | MW=%b | MTR=%b | ALUOP=%b",
    $time,
    pc_out,
    rs1_data_out,
    rs2_data_out,
    imm_out,
    rd_out,
    regwrite_out,
    alusrc_out,
    memread_out,
    memwrite_out,
    memtoreg_out,
    aluop_out
    );

end

endmodule
