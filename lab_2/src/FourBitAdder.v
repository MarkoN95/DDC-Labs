`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2018 23:48:48
// Design Name: 
// Module Name: FourBitAdder
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


module FourBitAdder(
    input [3:0] a, input [3:0] b, output [4:0] s
    );
    
    wire co_0, co_1, co_2;
    
    FullAdder FA0 (a[0], b[0], gnd, s[0], co_0);
    FullAdder FA1 (a[1], b[1], co_0, s[1], co_1);
    FullAdder FA2 (a[2], b[2], co_1, s[2], co_2);
    FullAdder FA3 (a[3], b[3], co_2, s[3], s[4]);
    
endmodule
