`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2026 20:32:54
// Design Name: 
// Module Name: pc
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


module pc(

    input wire clk,
    input wire rst,

    input wire pc_write,

    input wire [31:0] pc_next,

    output reg [31:0] pc

);

always @(posedge clk) begin

    if(rst)
        pc <= 32'd0;

    else if(pc_write)
        pc <= pc_next;

end

endmodule