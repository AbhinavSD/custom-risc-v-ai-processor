`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2026 16:22:44
// Design Name: 
// Module Name: instr_mem
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


module instr_mem (

    input  wire [31:0] addr,
    output wire [31:0] instruction

);

    reg [31:0] mem [0:255];

    integer i;

    initial begin

        //-------------------------------------------------
        // AIMAX Verification Program
        //-------------------------------------------------

        // x1 = 5
        mem[0] = 32'h00500093;   // ADDI x1,x0,5

        // x2 = 7
        mem[1] = 32'h00700113;   // ADDI x2,x0,7

        // AIMAX x5,x1,x2
        mem[2] = 32'h002082FB;

        //-------------------------------------------------
        // NOPs
        //-------------------------------------------------

        for(i = 3; i < 256; i = i + 1)
            mem[i] = 32'h00000013;

    end

    assign instruction = mem[addr[31:2]];

endmodule