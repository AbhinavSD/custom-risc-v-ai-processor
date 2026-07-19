`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2026 20:15:07
// Design Name: 
// Module Name: hazard_detection
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


module hazard_detection(

    input wire        idex_memread,
    input wire [4:0]  idex_rd,

    input wire [4:0]  ifid_rs1,
    input wire [4:0]  ifid_rs2,

    output reg        pc_write,
    output reg        ifid_write,
    output reg        control_flush

);

always @(*) begin

    // Normal operation

    pc_write      = 1'b1;
    ifid_write    = 1'b1;
    control_flush = 1'b0;

    // Load-use hazard

    if(idex_memread &&
      ((idex_rd == ifid_rs1) ||
       (idex_rd == ifid_rs2)) &&
       (idex_rd != 5'd0)) begin

        pc_write      = 1'b0;
        ifid_write    = 1'b0;
        control_flush = 1'b1;

    end

end

endmodule
