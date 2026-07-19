`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2026 16:29:13
// Design Name: 
// Module Name: instr_mem_tb
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

module instr_mem_tb;

    reg  [31:0] addr;
    wire [31:0] instruction;

    // Instantiate DUT
    instr_mem DUT (
        .addr(addr),
        .instruction(instruction)
    );

    initial begin

        $display("Time\tAddr\tInstruction");
        $monitor("%0t\t%0d\t%h",
                 $time, addr, instruction);

        addr = 32'd0;   // mem[0]
        #10;

        addr = 32'd4;   // mem[1]
        #10;

        addr = 32'd8;   // mem[2]
        #10;

        addr = 32'd12;  // mem[3]
        #10;

        addr = 32'd16;  // mem[4]
        #10;

        $finish;

    end

endmodule
