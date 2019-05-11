`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/07 13:57:09
// Design Name: 
// Module Name: alarm_clock_top
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


module alarm_clock_top(
    input clk, 
    input rst_n, load_SW, fastfwd_SW, alarm_off_SW, set_SW,
    input moveRight_BTN, moveLeft_BTN, increment_BTN, decrement_BTN,
    output outsignal_counter, outsignal_time,
    output [7:0] timer_seven_seg, AN,
    output audioOut, aud_sd,
    output  [7:0]   test_leds
    );


    //  Signal  Define
    
    wire [3:0] seconds_ones, minutes_ones, load_minutes_ones;
    wire [2:0] seconds_tens, minutes_tens, load_minutes_tens;
    
    wire [3:0] out_seconds_ones, out_minutes_ones;
    wire [2:0] out_seconds_tens, out_minutes_tens;
    
    wire [7:0] timer_seconds_ones, timer_seconds_tens, timer_minutes_ones, timer_minutes_tens;
    
    wire [1:0] two_bit_count;
    wire [3:0] enable_signal;
    wire moveRight_BTN_t, moveLeft_BTN_t, increment_BTN_t, decrement_BTN_t;


    wire    [3:0]   set_num;
    wire    [3:0]   set_id;
    /*******************************************************************
            Main    Code
    *******************************************************************/
 
    /******************************************************
           按键消抖
    ********************************************************/

    debounce    right_key(
        .clk(clk),
        .rst_n(rst_n),
        .key_in(moveRight_BTN),
        .key_out(moveRight_BTN_t)
    );

    debounce    left_key(
        .clk(clk),
        .rst_n(rst_n),
        .key_in(moveLeft_BTN),
        .key_out(moveLeft_BTN_t)
    );

    debounce    incre_key(
        .clk(clk),
        .rst_n(rst_n),
        .key_in(increment_BTN),
        .key_out(increment_BTN_t)
    );

    debounce    decre_key(
        .clk(clk),
        .rst_n(rst_n),
        .key_in(decrement_BTN),
        .key_out(decrement_BTN_t)
    );



    /******************************************************
           时钟产生电路
    ********************************************************/

    clock_generator clk_module(
        .clk(clk),
        .rst_n(rst_n), 
        .fastFwd(fastfwd_SW), 
        .outsignal_1(outsignal_counter),    //  分频成闹钟工作的时钟
                                            //  当Fast按键按下，则为五倍速速模式，用于调试
        .outsignal_400(outsignal_time)      //  分频出400HZ的时钟       
    );
    

    //  产生用于数码管段选的信号    采用计数时钟的四分频  00 01 10 11 作为四个状态
    two_bit_counter two_counter(outsignal_time, two_bit_count);
    //  利用2——4译码器产生高电平有效的段选信号
    two_four_decoder two_decoder(two_bit_count, enable_signal);



    /******************************************************
            计数电路
    ********************************************************/
 
    //  计数模块
    counter_60 second_counter(
        .clk(clk),
        .rst_n(rst_n), 
        .load(load_SW),             //   如果有效，保持原来的状态，计时停止 
        .set(set_SW),
        .set_id(set_id[1:0]),
        .set_num(set_num),
        .signal(outsignal_counter), 
        .ones(seconds_ones), 
        .tens(seconds_tens), 
        .loop(min)                  //   loop信号为产生60次加法后的计数
        );

     counter_60 minutes_counter(
        .clk(clk),
        .rst_n(rst_n), 
        .load(load_SW),             //   如果有效，保持原来的状态，计时停止 
        .set(set_SW),
        .set_id(set_id[3:2]),
        .set_num(set_num),
        .signal(min), 
        .ones(minutes_ones), 
        .tens(minutes_tens), 
        .loop(hour)                  //   loop信号为产生60次加法后的计数
        );


    
    /******************************************************
            设置时间
    ********************************************************/
    

    set_time set_time_module(
        .clk(clk),
        .set(set_SW),            //  设置模式使能
        .rst_n(rst_n),
        .incrementBtn(increment_BTN_t), 
        .decrementBtn(decrement_BTN_t),
        .enterBtn(moveRight_BTN_t),
        .set_num(set_num),
        .set_id(set_id)
    );
    


    /******************************************************
            设置闹钟
    ********************************************************/
 
    //  test_signal 表示任意按键被按下
    wire test_signal = moveRight_BTN_t | moveLeft_BTN_t | increment_BTN_t | decrement_BTN_t;
    set_alarm set_alarm_module(
        .signal(test_signal), 
        .load(load_SW), 
        .moveRightBtn(moveRight_BTN), 
        .moveLeftBtn(moveLeft_BTN),
        .incrementBtn(increment_BTN), 
        .decrementBtn(decrement_BTN), 
        .load_seconds(load_minutes_ones), 
        .load_minutes(load_minutes_tens)
    );


    /******************************************************
            时钟显示选择模块
    ********************************************************/
 

    // display clock or set alarm
    //  如果set有效，则显示
    //  如果load有效，则显示闹钟设置
    //  其他，则显示计时器
    display_clock clock_alarm(
        .load(load_SW),
        .set(set_SW),
        .set_id(set_id),
        .set_num(set_num), 
        .seconds_ones(seconds_ones), 
        .minutes_ones(minutes_ones), 
        .load_minutes_ones(load_minutes_ones),
        .seconds_tens(seconds_tens), 
        .minutes_tens(minutes_tens), 
        .load_minutes_tens(load_minutes_tens),
        .out_seconds_ones(out_seconds_ones), 
        .out_minutes_ones(out_minutes_ones), 
        .out_seconds_tens(out_seconds_tens), 
        .out_minutes_tens(out_minutes_tens)
    );
    
    /******************************************************
           数码管显示部分
    ********************************************************/
 

    // seven segment decoder
    seven_seg_decoder seconds_decoder(out_seconds_ones, out_seconds_tens, timer_seconds_ones, timer_seconds_tens);
    seven_seg_decoder minutes_decoder(out_minutes_ones, out_minutes_tens, timer_minutes_ones, timer_minutes_tens);
    
    // four to one multiplexer
    //  设置位选
    
    four_one_mux four_mux(timer_seconds_ones, timer_seconds_tens, timer_minutes_ones, timer_minutes_tens, two_bit_count, timer_seven_seg);

  
    // seven segment display

    //  设置段选    100hz切换一次
    seven_seg_display display(enable_signal, AN);

    /******************************************************
            蜂鸣器部分
    ********************************************************/
 

    check_alarm check_alarm_module(minutes_ones, load_minutes_ones, minutes_tens, load_minutes_tens, load_SW, alarm_off_SW, play_sound);
    song_player song_player_module(clk, rst_n, play_sound, audioOut, aud_sd);
    
    assign  test_leds[3:0]  =   set_num;
    assign  test_leds[7:4]  =   set_id;
endmodule