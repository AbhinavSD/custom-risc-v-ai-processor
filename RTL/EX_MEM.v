
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2026 20:37:48
// Design Name: 
// Module Name: EX_MEM
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

module EX_MEM(

    input wire clk,
    input wire rst,

    // Inputs from EX stage
    input wire [31:0] alu_result_in,
    input wire [31:0] write_data_in,
    input wire [31:0] pc_plus4_in,

    input wire [4:0]  rd_in,

    input wire memread_in,
    input wire memwrite_in,
    input wire regwrite_in,
    input wire memtoreg_in,

    input wire branch_in,

    // Outputs to MEM stage
    output reg [31:0] alu_result_out,
    output reg [31:0] write_data_out,
    output reg [31:0] pc_plus4_out,

    output reg [4:0]  rd_out,

    output reg memread_out,
    output reg memwrite_out,
    output reg regwrite_out,
    output reg memtoreg_out,

    output reg branch_out

);

always @(posedge clk) begin

    if(rst) begin

        alu_result_out <= 32'd0;
        write_data_out <= 32'd0;
        pc_plus4_out   <= 32'd0;

        rd_out         <= 5'd0;

        memread_out    <= 1'b0;
        memwrite_out   <= 1'b0;
        regwrite_out   <= 1'b0;
        memtoreg_out   <= 1'b0;

        branch_out     <= 1'b0;

    end
    else begin

        alu_result_out <= alu_result_in;
        write_data_out <= write_data_in;
        pc_plus4_out   <= pc_plus4_in;

        rd_out         <= rd_in;

        memread_out    <= memread_in;
        memwrite_out   <= memwrite_in;
        regwrite_out   <= regwrite_in;
        memtoreg_out   <= memtoreg_in;

        branch_out     <= branch_in;

    end

end

endmodule
