`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/11 16:52:35
// Design Name: 
// Module Name: set_signal_detect
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

/*
    该模块用来检测是否处在set阶段
*/
module set_signal_detect(
        input   wire        clk,
        input   wire        rst_n,
        input   wire        other_btn,
        input   wire        second_clk,
        input   wire        set_btn,
        
        output  reg         set_status  //  检测是否是 set 阶段的输出
    );

    reg                 set_done    =   0;
    reg     [2:0]       fives_count =   0;    
    wire                second_clk_pos;

    //  set_status
    /*
        当 set_done 为高时， 其他时间 set_status 保持
    */
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) set_status <= 0;
        else if (set_btn)   set_status <= 1;
        else if (set_done)  set_status <= 0;
    end

    
    edge_detect second_clk_edge_detect(
        .clk(clk),
        .rst_n(rst_n),
        .signal(second_clk),
        .pos_tick(second_clk_pos)
    );  //  检测1s的上升沿


    //  fives_count
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)  fives_count <= 3'b000;
        else if(set_status  ==  1'b1)   begin
        if (other_btn   ==  'b1) begin
            fives_count <=  3'b000;
        end
        else if(second_clk_pos) fives_count <= fives_count + 1;
        end

        else    fives_count <= 0;

    end


    //  set_done
    /*
        set_done 当 fives_count == 5 时， 产生一个脉冲
    */
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            set_done    <=  0;
        end
        else if (fives_count    ==  3'b101) // count to fives
            set_done    <=  1;
        else    set_done    <= 0;
    end

endmodule
