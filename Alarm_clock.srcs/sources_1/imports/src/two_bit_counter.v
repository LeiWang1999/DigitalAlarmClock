`timescale 1ns / 1ps

module two_bit_counter(
    input signal,
    output reg [1:0] counter
    );
    
    always@(posedge signal) begin
        counter = counter + 1;
        if(counter == 4)
            counter = 0;
    end
    
endmodule
