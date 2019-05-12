`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/12 16:29:56
// Design Name: 
// Module Name: clock_generator
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


module clock_generator(
    input clk, 
    input rst_n,
    input fastFwd,
    output reg outsignal_1, 
    output reg outsignal_400
    );
    
    reg [25:0] counter;
    
    always@(posedge clk) begin
        if (!rst_n) begin
           outsignal_1 <= 0;
        end
        counter <= counter + 1;
        if(fastFwd) begin
            if (counter == 1_000_000) begin
                outsignal_1 <= ~outsignal_1;
                counter <= 0;
            end
        end
        else begin
            if (counter == 50_000_000) begin
                outsignal_1 <= ~outsignal_1;
                counter <= 0;
            end
        end
        if (counter % 125_000 == 0)
            outsignal_400 <= ~outsignal_400;
    end
    
endmodule