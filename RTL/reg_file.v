`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2026 16:52:51
// Design Name: 
// Module Name: reg_file
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


module reg_file(

    input  wire        clk,
    input  wire        we,

    input  wire [4:0]  rs1,
    input  wire [4:0]  rs2,

    input  wire [4:0]  rd,
    input  wire [31:0] wd,

    output wire [31:0] rd1,
    output wire [31:0] rd2

);

    reg [31:0] regs [0:31];

    integer i;

    initial begin
        for(i=0; i<32; i=i+1)
            regs[i] = 32'd0;
    end

    // Write Port
    always @(posedge clk) begin
        if(we && (rd != 5'd0))
            regs[rd] <= wd;
    end

    // Read Ports
    assign rd1 = (rs1 == 5'd0) ? 32'd0 : regs[rs1];
    assign rd2 = (rs2 == 5'd0) ? 32'd0 : regs[rs2];

endmodule
