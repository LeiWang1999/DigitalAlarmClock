`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/12 16:31:33
// Design Name: 
// Module Name: two_four_decoder
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


module two_four_decoder(
    input [1:0] x,
    output reg [3:0] y 
    );
    
    always @(x) begin
        case(x)
            0: y = 4'b0001;
            1: y = 4'b0010;
            2: y = 4'b0100;
            3: y = 4'b1000;
        endcase
    end
    
endmodule
