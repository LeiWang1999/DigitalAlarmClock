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
        input               signal,
        input               set,            //  设置模式使能
        input               incrementBtn, decrementBtn,
        input               enterBtn,
        output      [3:0]   set_num,
        output      [3:0]   set_id
    );

    /*
        parameter / wire /reg Define 
    */

    localparam  IDLE           = 'b0000,
                ID_MINUTES_TEN = 'b1000,
                ID_MINUTES_ONE = 'b0100,
                ID_SECONDS_TEN = 'b0010,
                ID_SECONDS_ONE = 'b0001;

    reg     [3:0]   set_id_r   = 4'b0001;
    reg     [3:0]   set_num_r  = 4'b0000;




    /*
                Main    Code
    */

    always @(posedge signal) begin
        if (set) begin
            if(set_id == ID_MINUTES_ONE || set_id == ID_SECONDS_ONE) begin

                if(incrementBtn) begin
                    if(set_num_r == 9)
                        set_num_r = 0;
                    else
                        set_num_r = set_num_r + 1;
                end
                if(decrementBtn) begin
                    if(set_num_r == 0)
                        set_num_r = 9;
                    else
                        set_num_r = set_num_r - 1;
                end
            end
            else if(set_id == ID_MINUTES_TEN || set_id == ID_SECONDS_TEN) begin
                if(incrementBtn) begin
                    if(set_num_r == 5)
                        set_num_r = 0;
                    else
                        set_num_r = set_num_r + 1;
                end
                if(decrementBtn) begin
                    if(set_num_r == 0)
                        set_num_r = 5;
                    else
                        set_num_r = set_num_r - 1;
                end    
            end
        end
    end

    always @(posedge signal) begin
        if (set) begin
            case (set_id)
            IDLE          : set_id_r = ID_MINUTES_TEN;
            ID_MINUTES_TEN: if(enterBtn)set_id_r = ID_MINUTES_ONE;
            ID_MINUTES_ONE: if(enterBtn)set_id_r = ID_SECONDS_TEN;
            ID_SECONDS_TEN: if(enterBtn)set_id_r = ID_SECONDS_ONE;
            ID_SECONDS_ONE: if(enterBtn)set_id_r = IDLE;
                default: set_id_r = IDLE;
            endcase
        end
    end




    assign  set_id  = set_id_r;
    assign  set_num = set_num_r;


endmodule
