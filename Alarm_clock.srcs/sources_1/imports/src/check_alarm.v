`timescale 1ns / 1ps

module check_alarm(
    input [3:0] minutes_ones, load_minutes_ones,
    input [2:0] minutes_tens, load_minutes_tens, 
    input load_SW, alarm_off_SW, 
    output reg play_sound
    );
    
    always@(*) begin
        play_sound = 0;
        if(~load_SW && ~alarm_off_SW)
            if(minutes_ones == load_minutes_ones && minutes_tens == load_minutes_tens)
                play_sound = 1;
    end
    
endmodule
