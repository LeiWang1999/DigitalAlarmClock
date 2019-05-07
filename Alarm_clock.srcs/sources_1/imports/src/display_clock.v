`timescale 1ns / 1ps

module display_clock(
    input load, 
    input [3:0] seconds_ones, minutes_ones, load_minutes_ones,
    input [2:0] seconds_tens, minutes_tens, load_minutes_tens,
    output reg [3:0] out_seconds_ones, out_minutes_ones, 
    output reg [2:0] out_seconds_tens, out_minutes_tens
    );
    
    always@(*) begin
        if(load) begin
            out_seconds_ones = 0;
            out_seconds_tens = 0;
            out_minutes_ones = load_minutes_ones;
            out_minutes_tens = load_minutes_tens;
        end
        else begin
            out_seconds_ones = seconds_ones;
            out_seconds_tens = seconds_tens;
            out_minutes_ones = minutes_ones;
            out_minutes_tens = minutes_tens;
        end
    end
    
endmodule
