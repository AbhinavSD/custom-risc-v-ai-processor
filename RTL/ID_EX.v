`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2026 19:59:29
// Design Name: 
// Module Name: ID_EX
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

module ID_EX(

    input wire clk,
    input wire rst,

    // Data Signals
    input wire [31:0] pc_in,
    input wire [31:0] pc_plus4_in,

    input wire [31:0] rs1_data_in,
    input wire [31:0] rs2_data_in,
    input wire [31:0] imm_in,

    input wire [4:0] rs1_addr_in,
    input wire [4:0] rs2_addr_in,

    input wire [4:0] rd_in,

    // New ALU Control Inputs
    input wire [2:0] funct3_in,
    input wire [6:0] funct7_in,
    input wire [6:0] opcode_in,

    // Control Signals
    input wire regwrite_in,
    input wire alusrc_in,
    input wire memread_in,
    input wire memwrite_in,
    input wire memtoreg_in,
    input wire branch_in,
    input wire [1:0] aluop_in,

    // Data Outputs
    output reg [31:0] pc_out,
    output reg [31:0] pc_plus4_out,

    output reg [31:0] rs1_data_out,
    output reg [31:0] rs2_data_out,
    output reg [31:0] imm_out,

    output reg [4:0] rs1_addr_out,
    output reg [4:0] rs2_addr_out,

    output reg [4:0] rd_out,

    // New ALU Control Outputs
    output reg [2:0] funct3_out,
    output reg [6:0] funct7_out,
    output reg [6:0] opcode_out,

    // Control Outputs
    output reg regwrite_out,
    output reg alusrc_out,
    output reg memread_out,
    output reg memwrite_out,
    output reg memtoreg_out,
    output reg branch_out,
    output reg [1:0] aluop_out

);

always @(posedge clk) begin

    if(rst) begin

        pc_out         <= 32'd0;
        pc_plus4_out   <= 32'd0;

        rs1_data_out   <= 32'd0;
        rs2_data_out   <= 32'd0;
        imm_out        <= 32'd0;

        rs1_addr_out   <= 5'd0;
        rs2_addr_out   <= 5'd0;

        rd_out         <= 5'd0;

        funct3_out     <= 3'd0;
        funct7_out     <= 7'd0;
        opcode_out     <= 7'd0;

        regwrite_out   <= 1'b0;
        alusrc_out     <= 1'b0;

        memread_out    <= 1'b0;
        memwrite_out   <= 1'b0;
        memtoreg_out   <= 1'b0;
        branch_out     <= 1'b0;
        aluop_out      <= 2'b00;

    end
    else begin

        pc_out         <= pc_in;
        pc_plus4_out   <= pc_plus4_in;

        rs1_data_out   <= rs1_data_in;
        rs2_data_out   <= rs2_data_in;
        imm_out        <= imm_in;

        rs1_addr_out   <= rs1_addr_in;
        rs2_addr_out   <= rs2_addr_in;

        rd_out         <= rd_in;

        funct3_out     <= funct3_in;
        funct7_out     <= funct7_in;
        opcode_out     <= opcode_in;

        regwrite_out   <= regwrite_in;
        alusrc_out     <= alusrc_in;

        memread_out    <= memread_in;
        memwrite_out   <= memwrite_in;
        memtoreg_out   <= memtoreg_in;
        branch_out     <= branch_in;
        aluop_out      <= aluop_in;

    end

end

endmodule
