`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2025 02:27:17 PM
// Design Name: 
// Module Name: lab8a
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


module lab8a(
input CLK100MHZ,
input [1:0] SW,
input BTNC,
output CA,
output CB,
output CC,
output CD,
output CE,
output CF,
output CG,
output reg [7:0] AN
    );
    wire khz10_clock;
    create_10khz_clock(CLK100MHZ, khz10_clock);
    wire hz50_clock;
    create_50hz_clock(CLK100MHZ, hz50_clock);
    reg [31:0] count = 0;
    reg [2:0] mode = 0;
    reg [3:0] digit;
    set_Cs decoder(
        .num(digit),
        .CA(CA), .CB(CB), .CC(CC),
        .CD(CD), .CE(CE), .CF(CF), .CG(CG)
    );
    
    always @(posedge hz50_clock) begin
        if (BTNC == 1'b1) begin
            count <= count + 1'b1;
        end
        if (SW[0] == 1'b1) begin
            count <= 0;
        end
    end
    always @ (posedge khz10_clock) begin
        if (mode == 3'b111) begin
            mode <= 3'b000;
        end else begin
            mode <= mode + 3'b001;
        end
        case (mode) 
            3'b000: begin 
                digit <= (count % 10); 
                AN <= 8'b1111_1110; 
            end
            3'b001: begin
                digit <= ((count / 10) % 10);
                AN <= 8'b1111_1101;
            end
            3'b010: begin
                digit <= ((count / 100) % 10);
                AN <= 8'b1111_1011;
            end
            3'b011: begin
                digit <= ((count / 1_000) % 10);
                AN <= 8'b1111_0111;
            end
            3'b100: begin
                digit <= ((count / 10_000) % 10);
                AN <= 8'b1110_1111;
            end
            3'b101: begin
                digit <= ((count / 100_000) % 10);
                AN <= 8'b1101_1111;
            end
            3'b110: begin
                digit <= ((count / 1_000_000) % 10);
                AN <= 8'b1011_1111;
            end
            3'b111: begin
                digit <= ((count / 10_000_000) % 10);
                AN <= 8'b0111_1111;
            end
            default: begin AN <= 8'b1111_1111; digit <= 4'h0; end
        endcase
        
    end
    
endmodule

module set_Cs (input[3:0] num, output reg CA, output reg CB, output reg CC, output reg CD, output reg CE, output reg CF, output reg CG);
    always@(*) begin
        case (num)
            4'h0: {CA, CB, CC, CD, CE, CF, CG} = 7'b0000001;
            4'h1: {CA, CB, CC, CD, CE, CF, CG} = 7'b1001111;
            4'h2: {CA, CB, CC, CD, CE, CF, CG} = 7'b0010010;
            4'h3: {CA, CB, CC, CD, CE, CF, CG} = 7'b0000110;
            4'h4: {CA, CB, CC, CD, CE, CF, CG} = 7'b1001100;
            4'h5: {CA, CB, CC, CD, CE, CF, CG} = 7'b0100100;
            4'h6: {CA, CB, CC, CD, CE, CF, CG} = 7'b0100000;
            4'h7: {CA, CB, CC, CD, CE, CF, CG} = 7'b0001111;
            4'h8: {CA, CB, CC, CD, CE, CF, CG} = 7'b0000000;
            4'h9: {CA, CB, CC, CD, CE, CF, CG} = 7'b0000100;
            default: {CA, CB, CC, CD, CE, CF, CG} = 7'b1111111;
        endcase
    end
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

module create_50hz_clock (input CLK100MHZ, output reg clk_50hz = 1'b0);
    reg [31:0] cnt = 31'd0;
    always @ (posedge CLK100MHZ) begin
        if (cnt == 31'd999_999) begin
            clk_50hz <= 1'b0;
            cnt <= cnt + 1;
        end else if (cnt == 31'd1_999_998) begin
            clk_50hz <= 1'b1;
            cnt <= 0;
        end else begin
            cnt <= cnt + 1;
        end
    end
endmodule