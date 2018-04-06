`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2018 15:58:37
// Design Name: 
// Module Name: FSM
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


module FSM(
    input clk,
    input left,
    input right,
    input reset,
    output reg [2:0] L,
    output reg [2:0] R
    );
    
    reg [2:0] state;
    reg [2:0] nextstate;
    
    wire clk_en;
    clk_div dc (clk, reset, clk_en);
    
    parameter S0 = 3'b000;
    parameter L1 = 3'b001;
    parameter L2 = 3'b011;
    parameter L3 = 3'b111;
    parameter R1 = 3'b100;
    parameter R2 = 3'b110;
    parameter R3 = 3'b010;
    
    always@(posedge clk_en, posedge reset)
        if(reset)
            state <= S0;
        else
            state <= nextstate;
            
    //next state logic        
    always@(*)
        case(state)
            S0:
                begin
                    if(left)
                        nextstate = L1;
                    else if(right)
                        nextstate = R1;
                    else
                        nextstate = S0;
                end
            L1: nextstate = L2;
            L2: nextstate = L3;
            L3: nextstate = S0;
            R1: nextstate = R2;
            R2: nextstate = R3;
            R3: nextstate = S0;
            default: nextstate = S0;
            
        endcase
        
    //output logic
    always@(posedge clk_en)
        case(state)
            S0:
                begin
                    L <= 3'b000;
                    R <= 3'b000;
                end
            L1: L <= 3'b001;
            L2: L <= 3'b011;
            L3: L <= 3'b111;
            R1: R <= 3'b100;
            R2: R <= 3'b110;
            R3: R <= 3'b111;
            
            default:
                begin
                    L <= 3'b000;
                    R <= 3'b000;
                end
        endcase
    
endmodule
