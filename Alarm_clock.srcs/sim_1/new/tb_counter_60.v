//~ `New testbench
`timescale  1ns / 1ps

module tb_counter_60;

// counter_60 Parameters
parameter PERIOD  = 10;


// counter_60 Inputs
reg   rst_n                                = 0 ;
reg   clk                                  = 0 ;
reg   load                                 = 0 ;
reg   set                                  = 0 ;
reg   [1:0]  set_id                        = 0 ;
reg   [3:0]  set_num                       = 0 ;
reg   signal                               = 0 ;

// counter_60 Outputs
wire  [3:0]  ones                          ;
wire  [2:0]  tens                          ;
wire  loop                                 ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end


initial
begin
    forever #(PERIOD)   signal  =  ~signal;
end


initial
begin
    #(PERIOD*2) rst_n  =  1;
end

initial
begin
    #(PERIOD*10)    set =   1;
    #(PERIOD*10)    set =   0;
end 

initial
begin
    #(PERIOD*11)    set_num =   1;
                    set_id  =   'b10;
    #(PERIOD)       set_num =   2;
                    set_id  =   'b01;
    #(PERIOD)       set_num =   0;
                    set_id  =   0;
end


counter_60  u_counter_60 (
    .rst_n                   ( rst_n          ),
    .clk                     ( clk            ),
    .load                    ( load           ),
    .set                     ( set            ),
    .set_id                  ( set_id   [1:0] ),
    .set_num                 ( set_num  [3:0] ),
    .signal                  ( signal         ),

    .ones                    ( ones     [3:0] ),
    .tens                    ( tens     [2:0] ),
    .loop                    ( loop           )
);

initial
begin

    $finish;
end

endmodule