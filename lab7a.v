`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2025 03:35:47 PM
// Design Name: 
// Module Name: lab7a
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


module lab7a(
    input CLK100MHZ,
    output reg [5:0] LED
    );
    reg [28:0] cnt = 0;
    always @ (posedge CLK100MHZ) begin
        if (cnt <= 200_000_000) begin
            LED[0] <= 1'b1;
        end else begin
            LED[0] <= 1'b0;
        end
        if (cnt == 300_000_000) begin
            cnt <= 0;
        end else begin
            cnt <= cnt + 1;
        end
    end
endmodule
