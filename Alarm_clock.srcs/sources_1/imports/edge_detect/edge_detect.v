`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/01/28 13:56:52
// Design Name: 
// Module Name: edge_detect
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


    edge_detect signal_edge(
        .clk(clk),
        .rst_n(rst_n),
        .signal(signal),
        .pos_tick(pos_tick),
        .neg_tick()
    );
*/

module edge_detect(
    input wire clk,
    input wire rst_n,
    input wire signal,
    output wire pos_tick,
    output wire neg_tick
    );

    reg tick_r;

    always @(posedge clk) begin
      if (!rst_n) begin
        tick_r  <= 1'b0;
      end
      else
      tick_r <= signal;
    end

    assign pos_tick = (~tick_r)&signal;       // 0 -> 1 ↑
    assign neg_tick = (tick_r)&(~signal);     // 1 -> 0 ↓

endmodule
