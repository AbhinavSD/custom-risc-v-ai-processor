`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2026 17:34:38
// Design Name: 
// Module Name: alu
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


module alu(

    input  wire [31:0] a,
    input  wire [31:0] b,
    input  wire [2:0]  alu_sel,

    output reg  [31:0] result

);

always @(*) begin

    case(alu_sel)

        3'b000: result = a + b;                     // ADD

        3'b001: result = a - b;                     // SUB

        3'b010: result = a & b;                     // AND

        3'b011: result = a | b;                     // OR

        3'b100: result = a ^ b;                     // XOR

        3'b101: result = ($signed(a) < $signed(b))
                          ? 32'd1
                          : 32'd0;                 // SLT

        3'b110: result = ($signed(a) > $signed(b))
                          ? a
                          : b;                     // AIMAX

        default: result = 32'd0;

    endcase

end

endmodule
