`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.03.2018 15:22:44
// Design Name: 
// Module Name: DisplayFourBitSum
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


module DisplayFourBitSum(
    input [3:0] A, 
    input [3:0] B, 
    output [6:0] segs, 
    output overflow, 
    output [3:0] AN
    );
    
    wire [4:0] sum;
    
    FourBitAdder ADDER (A, B, sum);
    Decoder DECODER (sum[3:0], segs);
    
    assign overflow = sum[4];
    
    assign AN[0] = 0;
    assign AN[1] = 1;
    assign AN[2] = 1;
    assign AN[3] = 1;
    
endmodule
