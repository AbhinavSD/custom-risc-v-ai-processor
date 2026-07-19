`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2026 19:13:01
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit(

    input wire [4:0] idex_rs1,
    input wire [4:0] idex_rs2,

    input wire [4:0] exmem_rd,
    input wire       exmem_regwrite,

    input wire [4:0] memwb_rd,
    input wire       memwb_regwrite,

    output reg [1:0] forwardA,
    output reg [1:0] forwardB

);

always @(*) begin

    // Default
    forwardA = 2'b00;
    forwardB = 2'b00;

    //------------------------------------------------
    // EX Hazard
    //------------------------------------------------

    if(exmem_regwrite &&
       (exmem_rd != 5'd0) &&
       (exmem_rd == idex_rs1))
        forwardA = 2'b10;

    if(exmem_regwrite &&
       (exmem_rd != 5'd0) &&
       (exmem_rd == idex_rs2))
        forwardB = 2'b10;

    //------------------------------------------------
    // MEM Hazard
    //------------------------------------------------

    if(memwb_regwrite &&
       (memwb_rd != 5'd0) &&
       !(exmem_regwrite &&
         (exmem_rd != 5'd0) &&
         (exmem_rd == idex_rs1)) &&
       (memwb_rd == idex_rs1))
        forwardA = 2'b01;

    if(memwb_regwrite &&
       (memwb_rd != 5'd0) &&
       !(exmem_regwrite &&
         (exmem_rd != 5'd0) &&
         (exmem_rd == idex_rs2)) &&
       (memwb_rd == idex_rs2))
        forwardB = 2'b01;

end

endmodule
