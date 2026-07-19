`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2026 22:58:09
// Design Name: 
// Module Name: alu_control
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


module alu_control(

    input wire [2:0] funct3,
    input wire [6:0] funct7,
    input wire [6:0] opcode,
    input wire [1:0] alu_op,

    output reg [2:0] alu_sel

);

always @(*) begin

    case(alu_op)

        // LW / SW
        2'b00:
            alu_sel = 3'b000; // ADD

        // BEQ
        2'b01:
            alu_sel = 3'b001; // SUB

        // R-Type / I-Type / AI-Type
        2'b10:
        begin

            //-------------------------------------------------
            // AIMAX
            //-------------------------------------------------
            if(opcode == 7'b1111011 &&
               funct3 == 3'b000)
            begin
                alu_sel = 3'b110;
            end

            else begin

                case(funct3)

                    // ADD / SUB / ADDI
                    3'b000:
                    begin

                        if(opcode == 7'b0110011 &&
                           funct7 == 7'b0100000)
                            alu_sel = 3'b001;   // SUB
                        else
                            alu_sel = 3'b000;   // ADD / ADDI

                    end

                    3'b111:
                        alu_sel = 3'b010;       // AND

                    3'b110:
                        alu_sel = 3'b011;       // OR

                    3'b100:
                        alu_sel = 3'b100;       // XOR

                    3'b010:
                        alu_sel = 3'b101;       // SLT

                    default:
                        alu_sel = 3'b000;

                endcase

            end

        end

        default:
            alu_sel = 3'b000;

    endcase

end

endmodule
