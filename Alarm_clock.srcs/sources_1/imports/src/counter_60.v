`timescale 1ns / 1ps

module counter_60(
    input rst_n,
    input load,
    input signal,
    output reg [3:0] ones,
    output reg [2:0] tens,
    output reg loop
    );
    
    always@(posedge signal, negedge rst_n) begin
        if(!rst_n) begin
            ones = 0;
            tens = 0;
            loop = 0;
        end
        else if(~load) begin
            loop = 0;
            ones = ones + 1;
            
            if(ones == 10) begin
                ones = 0;
                tens = tens + 1;
            end
            
            if(tens == 6) begin
                tens = 0;
                loop = 1;
            end
        end
    end
    
endmodule
