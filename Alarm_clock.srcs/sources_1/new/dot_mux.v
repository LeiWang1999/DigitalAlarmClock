`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/11 17:46:54
// Design Name: 
// Module Name: dot_mux
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


module dot_mux(
        input   [1:0]   select,
        output  reg     dot
    );

    always@(*) begin
        case(select)
            2'b00: dot = 1;
            2'b01: dot = 1;
            2'b10: dot = 0;
            2'b11: dot = 1;
            default: dot = 1;
        endcase
    end
        
endmodule
