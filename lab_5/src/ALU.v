`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2018 04:05:48 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input   [3:0] AluOp,
    input   [31:0] A,
    input   [31:0] B,
    output  reg [31:0] result,
    output  reg zero
    );
    
    wire [31:0] AandB;
    wire [31:0] AxorB;
    wire [31:0] AnorB;
    wire [31:0] AorB;
    reg [31:0] logicOut;
    reg [31:0] BB;
    reg [31:0] sum;
    reg [31:0] arithmeticOut;
    
    assign AandB = A & B;
    assign AxorB = A ^ B;
    assign AorB = A | B;
    assign AnorB = ~(A|B);
    
    //Logic Unit
    always@(*)
        case(AluOp[1:0])
            2'b00: logicOut = AandB;
            2'b01: logicOut = AorB;
            2'b10: logicOut = AxorB;
            2'b11: logicOut = AnorB;
        endcase 
        
    //Arithmetic Unit
    always@(*)
        begin
            case(AluOp[1])
                1'b0: BB = B;
                1'b1: BB = ~B;
            endcase
            sum = A + BB + AluOp[1];
        end
    always@(*)
        case(AluOp[3])
            1'b0: arithmeticOut = sum;
            1'b1: arithmeticOut = sum >> 31;    
        endcase
        
    always@(*)
        begin
            case(AluOp[2])
                1'b0: result = arithmeticOut;
                1'b1: result = logicOut;
            endcase
            zero = ~(|result);
        end
endmodule
