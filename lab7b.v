`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2025 03:57:38 PM
// Design Name: 
// Module Name: lab7b
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


module lab7b(
input CLK100MHZ,
output [5:0] LED,
output [4:1] JA
    );
    wire khz10_clock;
    create_10khz_clock(CLK100MHZ, khz10_clock);
    assign LED[0] = khz10_clock;
    assign LED[1] = CLK100MHZ;
    assign LED[2] = 1'b1;
    assign JA[1] = khz10_clock;
endmodule

module create_10khz_clock (input CLK100MHZ, output reg clk_10khz = 1'b0);
    reg [14:0] cnt = 0;
    always @ (posedge CLK100MHZ) begin
        if (cnt == 4_999) begin
            clk_10khz <= 1'b0;
            cnt <= cnt + 1;
        end else if (cnt == 9_999) begin
            clk_10khz <= 1'b1;
            cnt <= 0;
        end else begin
            cnt <= cnt + 1;
        end
    end
endmodule
