`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/12 16:32:39
// Design Name: 
// Module Name: counter_60
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


module counter_60(
    input rst_n,
    input clk,
    input load,
    input set,
    input [1:0] set_id,
    input [3:0] set_num,
    input signal,
    output reg [3:0] ones,
    output reg [2:0] tens,
    output reg loop
    );
    

    /*
        当set信号到来，必须停止计时：
            置位的判别方法：判断set_id:         tens -> 2'b10;   ones -> 2'b01
            当判断到相应的set_id时：            将相应的寄存器赋值
    */
    wire    signal_postick;

    edge_detect signal_edge(
        .clk(clk),
        .rst_n(rst_n),
        .signal(signal),
        .pos_tick(signal_postick)
    );

    always@(posedge clk, negedge rst_n) begin
        if(!rst_n) begin
            ones = 0;
            tens = 0;
            loop = 0;
        end
        else if(set) begin
            case (set_id)
                'b10:   tens    =   set_num;    //  设置 十位
                'b01:   ones    =   set_num;    //  设置 个位
            endcase
        end
        else if(~load && signal_postick) begin
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
