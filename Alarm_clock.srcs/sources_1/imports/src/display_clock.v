`timescale 1ns / 1ps

module display_clock(
    input                               load, 
    input                               set,
    input       [3:0]                   set_id,
    input       [3:0]                   set_num,
    input       [3:0]                   seconds_ones, minutes_ones, load_minutes_ones,
    input       [2:0]                   seconds_tens, minutes_tens, load_minutes_tens,
    output reg  [3:0]                   out_seconds_ones, out_minutes_ones, 
    output reg  [2:0]                   out_seconds_tens, out_minutes_tens
    );
    

    /*
            Define
    */
    
    reg         [3:0]                   set_seconds_ones_r = 4'b0000;
    reg         [3:0]                   set_minutes_ones_r = 4'b0000;
    reg         [3:0]                   set_seconds_tens_r = 4'b0000;
    reg         [3:0]                   set_minutes_tens_r = 4'b0000;


    /*

        # 假设设置时钟的优先级低于Load


        1. 如果是set,则进入时钟的时间设置
                输入信号有 set_num、set_id


        2. 如果是Load，则进入闹钟设置
                **已完成**

    */
    
    always@(*) begin
        if  (set)   begin
            case (set_id)
                'b1000:     begin
                    out_minutes_tens = 0;
                    out_minutes_ones = 0;
                    out_seconds_tens = 0;
                    out_seconds_ones = set_minutes_tens_r;
                end
                'b0100:     begin
                    out_minutes_tens = 0;
                    out_minutes_ones = 0;
                    out_seconds_tens = set_minutes_tens_r;
                    out_seconds_ones = set_minutes_ones_r;
                end
                'b0010:     begin
                    out_minutes_tens = 0;
                    out_minutes_ones = set_minutes_tens_r;
                    out_seconds_tens = set_minutes_ones_r;
                    out_seconds_ones = set_seconds_tens_r;                  
                end 
                'b0001:     begin
                    out_minutes_tens = set_minutes_tens_r;
                    out_minutes_ones = set_minutes_ones_r;
                    out_seconds_tens = set_seconds_tens_r;
                    out_seconds_ones = set_seconds_ones_r;  
                end
            endcase
        end
        else if(load) begin
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

    always @(*) begin
            case (set_id)
                'b1000:     begin
                    set_minutes_tens_r = set_num;
                end
                'b0100:     begin
                    set_minutes_ones_r = set_num;
                end
                'b0010:     begin
                    set_seconds_tens_r = set_num;                 
                end 
                'b0001:     begin   
                    set_seconds_ones_r = set_num;
                end
                default:    begin
                    set_minutes_tens_r = set_minutes_tens_r;
                    set_minutes_ones_r = set_minutes_ones_r;
                    set_seconds_tens_r = set_seconds_tens_r;
                    set_seconds_ones_r = set_seconds_ones_r;    
                    end                                                                            
            endcase

    end

    
endmodule
