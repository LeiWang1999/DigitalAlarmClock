`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/13 20:06:24
// Design Name: 
// Module Name: rgb_out
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


module rgb_out(
        input   [9:0]       pixel_x,
        input   [9:0]       pixel_y,
        input               video_on,

        output  reg     [3:0]       vga_r,
        output  reg     [3:0]       vga_g,
        output  reg     [3:0]       vga_b        
    );

    always @(*) begin
        if(!video_on)  begin
            vga_b = 'b000;
            vga_r = 'b000;
            vga_g = 'b000;
        end
        else    begin
            if (pixel_x < 100) begin
                vga_b = 'b001;
            end
            else if (pixel_x < 200) begin
                vga_b = 'b010;
            end
            else if (pixel_x < 300) begin
                vga_b = 'b100;
            end
            else if (pixel_x < 400) begin
                vga_r = 'b101;
            end
            else vga_g = 'b111;
        end
    end


endmodule
