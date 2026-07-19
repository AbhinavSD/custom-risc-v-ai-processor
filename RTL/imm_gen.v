`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2026 21:36:42
// Design Name: 
// Module Name: imm_gen
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


module imm_gen(

    input  wire [31:0] instruction,
    output reg  [31:0] imm_out

);

wire [6:0] opcode;

assign opcode = instruction[6:0];

always @(*) begin

    case(opcode)

        // I-Type
        7'b0010011,   // ADDI
        7'b0000011:   // LW
        begin
            imm_out = {{20{instruction[31]}},
                        instruction[31:20]};
        end

        // S-Type
        7'b0100011:   // SW
        begin
            imm_out = {{20{instruction[31]}},
                       instruction[31:25],
                       instruction[11:7]};
        end

        // B-Type
        7'b1100011:   // BEQ
        begin
            imm_out = {{19{instruction[31]}},
                       instruction[31],
                       instruction[7],
                       instruction[30:25],
                       instruction[11:8],
                       1'b0};
        end

        default:
            imm_out = 32'd0;

    endcase

end

endmodule
