`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2026 19:18:30
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(

    input wire clk,
    input wire rst,

    input wire ifid_write,
    input wire flush,
    input wire [31:0] pc_in,
    input wire [31:0] instr_in,

    output reg [31:0] pc_out,
    output reg [31:0] instr_out

);

always @(posedge clk) begin

    if(rst) begin

        pc_out    <= 32'd0;
        instr_out <= 32'd0;

    end

    else if(flush)
begin
    pc_out    <= 32'd0;
    instr_out <= 32'h00000013;   // NOP
end
else if(ifid_write)
begin
    pc_out    <= pc_in;
    instr_out <= instr_in;
end

end

endmodule
