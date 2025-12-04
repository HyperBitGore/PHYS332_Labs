`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2025 05:11:22 PM
// Design Name: 
// Module Name: lab7d
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


module lab7d(
input CLK100MHZ,
input [11:0] SW,
output [1:0] LED,
output reg LED16_B,
output reg LED16_G,
output reg LED16_R
    );
    wire clk_10khz;
    create_10khz_clock (CLK100MHZ, clk_10khz);
    reg [4:0] cnt = 5'd0;
    always @(posedge clk_10khz) begin
        if (cnt == 5'b1_1111) begin
            cnt <= 5'd0;
        end else begin
            cnt <= cnt + 5'd1;
        end
    end
    always @(posedge cnt) begin
        if (cnt == 5'b1_1111) begin
            LED16_R <= 1'b1;
            LED16_G <= 1'b1;
            LED16_B <= 1'b1;
        end else if (cnt <= 5'b0_1111) begin
            if (SW[3:0] > cnt) begin
                LED16_R <= 1'b1;
            end else begin
                LED16_R <= 1'b0;
            end
            if (SW[7:4] > cnt) begin
                LED16_G <= 1'b1;
            end else begin
                LED16_G <= 1'b0;
            end
            if (SW[11:8] > cnt) begin
                LED16_B <= 1'b1;
            end else begin
                LED16_B <= 1'b0;
            end
        end else begin
            LED16_R <= 1'b0;
            LED16_G <= 1'b0;
            LED16_B <= 1'b0;
        end
    end
endmodule
