`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2026 16:54:26
// Design Name: 
// Module Name: reg_file_tb
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

module reg_file_tb;

    reg clk;
    reg we;

    reg [4:0] rs1;
    reg [4:0] rs2;

    reg [4:0] rd;
    reg [31:0] wd;

    wire [31:0] rd1;
    wire [31:0] rd2;

    reg_file DUT (
        .clk(clk),
        .we(we),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .wd(wd),
        .rd1(rd1),
        .rd2(rd2)
    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        we  = 0;

        rs1 = 0;
        rs2 = 0;
        rd  = 0;
        wd  = 0;

        // Write 25 into x1
        #10;
        we = 1;
        rd = 5'd1;
        wd = 32'd25;

        #10;

        // Write 40 into x2
        rd = 5'd2;
        wd = 32'd40;

        #10;

        we = 0;

        // Read x1 and x2
        rs1 = 5'd1;
        rs2 = 5'd2;

        #10;

        // Try writing to x0
        we = 1;
        rd = 5'd0;
        wd = 32'd999;

        #10;

        we = 0;
        rs1 = 5'd0;

        #20;

        $finish;

    end

    initial begin
        $monitor("Time=%0t rs1=%d rd1=%d rs2=%d rd2=%d",
                  $time, rs1, rd1, rs2, rd2);
    end

endmodule
