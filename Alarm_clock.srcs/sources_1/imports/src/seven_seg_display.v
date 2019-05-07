`timescale 1ns / 1ps

module seven_seg_display(
    input [3:0] enable_input,
    output reg [7:0] AN
    );
    
    always@(enable_input) begin
        case(enable_input)
            4'b0001: AN = 8'b1111_1110;
            4'b0010: AN = 8'b1111_1101;
            4'b0100: AN = 8'b1111_1011;
            4'b1000: AN = 8'b1111_0111;
            default: AN = 0;
        endcase
    end
    
endmodule
