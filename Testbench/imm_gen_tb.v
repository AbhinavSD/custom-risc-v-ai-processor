`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2026 21:38:16
// Design Name: 
// Module Name: imm_gen_tb
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

module imm_gen_tb;

reg [31:0] instruction;
wire [31:0] imm_out;

imm_gen DUT(
    .instruction(instruction),
    .imm_out(imm_out)
);

initial begin

    // ADDI x1,x0,5
    instruction = 32'h00500093;
    #10;

    // SW x1,8(x2)
    instruction = 32'h00112423;
    #10;

    // BEQ sample
    instruction = 32'h00208463;
    #10;

    $finish;

end

initial begin
    $monitor("Time=%0t Instruction=%h Imm=%d",
             $time, instruction, imm_out);
end

endmodule
