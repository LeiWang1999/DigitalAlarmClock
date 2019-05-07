`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/01/20 17:26:06
// Design Name: 
// Module Name: debounce
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


module debounce(
    input wire clk,
    input wire rst_n,
    input wire key_in,
    output wire key_out
);
    localparam[2:0]
    zero = 3'b000,
    wait1_1 = 3'b001,
    wait1_2 = 3'b010,
    wait1_3 = 3'b011,
    one = 3'b100,
    wait0_1 = 3'b101,
    wait0_2 = 3'b110,
    wait0_3 = 3'b111;
    
    reg [2:0] current_state;
    reg [2:0] next_state;
    reg key_out_r;

    wire clk_100HZ; // 100MHZ -> 100Hz
    
    counter_mod_m #(.M(1000000), .N(20))counter_mod_100HZ(
        .clk(clk) , .rst_n(rst_n),
        .m_out(clk_100HZ)
    );

    always @(posedge clk, negedge rst_n) begin
      if (!rst_n) begin
        current_state <= zero;
      end
      else begin 
        current_state <= next_state;
      end
    end

    always @(*) begin
        next_state = current_state;
        case (current_state)
          zero: begin
                key_out_r = 0;
                if (key_in) begin
                  next_state = wait1_1;
                end 
                end
          wait1_1:
                begin
                key_out_r = 0;
                if(~key_in) begin
                  next_state = zero;
                end
                else if (clk_100HZ) next_state = wait1_2;
                end
          wait1_2:
                begin
                  key_out_r = 0;
                if (~key_in) begin
                  next_state = zero;
                end
                else if (clk_100HZ) next_state = wait1_3; end
          wait1_3:
                if (~key_in) begin
                  next_state = zero;
                end
                else if (clk_100HZ) next_state = one;
          one:  begin 
                key_out_r = 1'b1;
                if (~key_in) begin
                  next_state = wait0_1;
                end
                end
          wait0_1:
                begin
                key_out_r = 1'b1;
                if (key_in) begin
                  next_state = one;
                end
                else if(clk_100HZ) begin
                  next_state = wait0_2;
                end
                end
          wait0_2:
                begin
                key_out_r = 1'b1;
                if (key_in) begin
                  next_state = one;
                end
                else if (clk_100HZ) begin
                  next_state = wait0_3;
                end
                end
          wait0_3:
                begin
                key_out_r = 1'b1;
                if (key_in) begin
                  next_state = one;
                end
                else if (clk_100HZ) begin
                  next_state = zero;
                end
                end
          default: next_state = zero;
        endcase
    end
    
    assign key_out = key_out_r;

endmodule
