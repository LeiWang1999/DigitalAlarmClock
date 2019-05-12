`timescale 1ns / 1ps

module seven_seg_decoder(
    input [3:0] ones,
    input [2:0] tens,
    output reg [6:0] seg_ones,
    output reg [6:0] seg_tens
    );
    
    always@(*) begin
        case(ones)
            1: seg_ones = 7'b100_1111;
            2: seg_ones = 7'b001_0010;
            3: seg_ones = 7'b000_0110;
            4: seg_ones = 7'b100_1100;
            5: seg_ones = 7'b010_0100;
            6: seg_ones = 7'b010_0000;
            7: seg_ones = 7'b000_1111;
            8: seg_ones = 7'b000_0000;
            9: seg_ones = 7'b000_0100;
            default: seg_ones = 8'b1000_0001;
        endcase
        
        case(tens) 
            1: seg_tens = 7'b100_1111;
            2: seg_tens = 7'b001_0010;
            3: seg_tens = 7'b000_0110;
            4: seg_tens = 7'b100_1100;
            5: seg_tens = 7'b010_0100;
            default: seg_tens = 8'b1000_0001;
        endcase
    end
    
endmodule