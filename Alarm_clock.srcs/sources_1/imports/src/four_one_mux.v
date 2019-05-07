`timescale 1ns / 1ps

module four_one_mux(
    input [7:0] x0,
    input [7:0] x1,
    input [7:0] x2,
    input [7:0] x3,
    input [1:0] select,
    output reg [7:0] y
    );
    
    always@(*) begin
        case(select)
            2'b00: y = x0;
            2'b01: y = x1;
            2'b10: y = x2;
            2'b11: y = x3;
            default: y = 8'b0000_0001;
        endcase
    end
     
endmodule
