`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/07 19:56:28
// Design Name: 
// Module Name: set_time
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


module set_time(
        input               clk,         //  100Mhz输入时钟
        input               rst_n,
        input               set,            //  设置模式使能
        input               incrementBtn, decrementBtn,
        input               enterBtn,
        output      [3:0]   set_num,
        output      [3:0]   set_id
    );

    /*
        parameter / wire /reg Define 
    */

    localparam  ID_MINUTES_TEN = 'b1000,
                ID_MINUTES_ONE = 'b0100,
                ID_SECONDS_TEN = 'b0010,
                ID_SECONDS_ONE = 'b0001;

    reg     [3:0]   set_id_r   = 4'b0001;
    reg     [3:0]   set_num_r  = 4'b0000;
    wire            enterBtn_pos;
    wire            incrementBtn_pos;
    wire            decrementBtn_pos;
    reg     [3:0]   current_state,next_state;





    /*
                Main    Code
    */

    edge_detect enterBtn_pos_edge_detect(
        .clk(clk),
        .rst_n(rst_n),
        .signal(enterBtn),
        .pos_tick(enterBtn_pos)
    );  //  检测确定按键的上升沿

    edge_detect incrementBtn_pos_edge_detect(
        .clk(clk),
        .rst_n(rst_n),
        .signal(incrementBtn),
        .pos_tick(incrementBtn_pos)
    );  //  检测确定按键的上升沿

    edge_detect decrementBtn_pos_edge_detect(
        .clk(clk),
        .rst_n(rst_n),
        .signal(decrementBtn),
        .pos_tick(decrementBtn_pos)
    );  //  检测确定按键的上升沿




    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state   <=  ID_MINUTES_TEN;   
        else 
            if(enterBtn_pos)
            current_state   <=  next_state;
        end


    always @(*) begin
        next_state = current_state;
        case (current_state)
            ID_MINUTES_TEN: next_state = ID_MINUTES_ONE;
            ID_MINUTES_ONE: next_state = ID_SECONDS_TEN;
            ID_SECONDS_TEN: next_state = ID_SECONDS_ONE;
            ID_SECONDS_ONE: next_state = ID_MINUTES_TEN;
            default: next_state = ID_MINUTES_ONE;
        endcase        
    end


    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            set_num_r <= 0;
        else if(set)
           if(current_state == ID_MINUTES_ONE || current_state == ID_SECONDS_ONE) begin

                if(incrementBtn_pos) begin
                    if(set_num_r == 9)
                        set_num_r = 0;
                    else
                        set_num_r = set_num_r + 1;
                end
                if(decrementBtn_pos) begin
                    if(set_num_r == 0)
                        set_num_r = 9;
                    else
                        set_num_r = set_num_r - 1;
                end
            end
            else if(current_state == ID_MINUTES_TEN || current_state == ID_SECONDS_TEN) begin
                if(incrementBtn_pos) begin
                    if(set_num_r == 5)
                        set_num_r = 0;
                    else
                        set_num_r = set_num_r + 1;
                end
                if(decrementBtn_pos) begin
                    if(set_num_r == 0)
                        set_num_r = 5;
                    else
                        set_num_r = set_num_r - 1;
                end    
            end
        end




    assign  set_num = set_num_r;
    assign  set_id  = current_state;

endmodule
