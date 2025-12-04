`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2025 04:48:49 PM
// Design Name: 
// Module Name: lab7c
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


module lab7c(
input CLK100MHZ,
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
    reg [3:0] mode = 0;
    reg [3:0] digit;
    
    set_Cs decoder(
        .num(digit),
        .CA(CA), .CB(CB), .CC(CC),
        .CD(CD), .CE(CE), .CF(CF), .CG(CG)
    );
     always @(posedge khz10_clock) begin
        if (mode == 4'd6)
            mode <= 4'd0;
        else
            mode <= mode + 1'b1;
    end
 
    always @(posedge khz10_clock) begin
        case (mode)
            4'h0: begin AN <= 8'b1011_1111; digit <= 4'h8; end
            4'h1: begin AN <= 8'b1101_1111; digit <= 4'h6; end
            4'h2: begin AN <= 8'b1110_1111; digit <= 4'h7; end
            4'h3: begin AN <= 8'b1111_0111; digit <= 4'h5; end
            4'h4: begin AN <= 8'b1111_1011; digit <= 4'h3; end
            4'h5: begin AN <= 8'b1111_1101; digit <= 4'h0; end
            4'h6: begin AN <= 8'b1111_1110; digit <= 4'h9; end
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