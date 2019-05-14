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
        input               clk,
        input               rst_n,


        input        [2:0]       minutes_tens,
        input        [3:0]       minutes_ones,
        input        [2:0]       seconds_tens,
        input        [3:0]       seconds_ones,           



        input   [9:0]       pixel_x,
        input   [9:0]       pixel_y,
        input               video_on,
        input               vga_clk,
        output  reg     [3:0]       vga_r,
        output  reg     [3:0]       vga_g,
        output  reg     [3:0]       vga_b        
    );


    	// 显示器可显示区域
	parameter UP_BOUND = 31;
	parameter DOWN_BOUND = 510;
	parameter LEFT_BOUND = 144;
	parameter RIGHT_BOUND = 783;

	// 屏幕中央两个字符的显示区域
	parameter up_pos = 267;
	parameter down_pos = 274;   //  274 - 267 + 1 = 8
	parameter left_pos = 300;   //  34
	parameter right_pos = 334;



    //  定义数字的字模  显示分钟：秒钟 共五个字符 所以 string 为 35-1=34
	wire [7:0] string[34:0];


	RAM_set u_ram_minutes_tens (
		.clk(clk),
		.rst_n(rst_n),
		.data(minutes_tens),
		.col0(string[0]),
		.col1(string[1]),
		.col2(string[2]),
		.col3(string[3]),
		.col4(string[4]),
		.col5(string[5]),
		.col6(string[6])
	);

	RAM_set u_ram_minutes_ones (
		.clk(clk),
		.rst_n(rst_n),
		.data(minutes_ones),
		.col0(string[7]),
		.col1(string[8]),
		.col2(string[9]),
		.col3(string[10]),
		.col4(string[11]),
		.col5(string[12]),
		.col6(string[13])
	);

	RAM_set u_ram_dots (
		.clk(clk),
		.rst_n(rst_n),
		.data(6'b11_1111),
		.col0(string[14]),
		.col1(string[15]),
		.col2(string[16]),
		.col3(string[17]),
		.col4(string[18]),
		.col5(string[19]),
		.col6(string[20])
	);

	RAM_set u_ram_seconds_tens (
		.clk(clk),
		.rst_n(rst_n),
		.data(seconds_tens),
		.col0(string[21]),
		.col1(string[22]),
		.col2(string[23]),
		.col3(string[24]),
		.col4(string[25]),
		.col5(string[26]),
		.col6(string[27])
	);

	RAM_set u_ram_seconds_ones (
		.clk(clk),
		.rst_n(rst_n),
		.data(seconds_ones),
		.col0(string[28]),
		.col1(string[29]),
		.col2(string[30]),
		.col3(string[31]),
		.col4(string[32]),
		.col5(string[33]),
		.col6(string[34])
	);
	




    // 设置显示信号值
	always @ (posedge vga_clk or negedge rst_n)
	begin
		if (!rst_n) begin
			vga_r <= 0;
			vga_g <= 0;
			vga_b <= 0;
		end
		else if (pixel_y>=UP_BOUND && pixel_y<=DOWN_BOUND
				&& pixel_x>=LEFT_BOUND && pixel_x<=RIGHT_BOUND) begin
			if (pixel_y>=up_pos && pixel_y<=down_pos
					&& pixel_x>=left_pos && pixel_x<=right_pos) begin
				if (string[pixel_x-left_pos][pixel_y-up_pos]) begin
					vga_r <= 3'b111;
					vga_g <= 3'b111;
					vga_b <= 3'b111;
				end
				else begin
					vga_r <= 3'b000;
					vga_g <= 3'b000;
					vga_b <= 3'b000;
				end
			end
			else begin
				vga_r <= 3'b000;
				vga_g <= 3'b000;
				vga_b <= 3'b000;
			end
		end
		else begin
			vga_r <= 3'b000;
			vga_g <= 3'b000;
			vga_b <= 3'b000;
		end
	end

endmodule
