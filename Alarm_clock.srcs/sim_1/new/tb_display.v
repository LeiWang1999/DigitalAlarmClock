//~ `New testbench
`timescale  1ns / 1ps

module tb_display_clock;

// display_clock Parameters
parameter PERIOD  = 10;


// display_clock Inputs
reg   load                                 = 0 ;
reg   set                                  = 0 ;
reg   [3:0]  set_id                        = 0 ;
reg   [3:0]  set_num                       = 0 ;
reg   [3:0]  seconds_ones                  = 1 ;
reg   [3:0]  minutes_ones                  = 3 ;
reg   [3:0]  load_minutes_ones             = 5 ;
reg   [2:0]  seconds_tens                  = 2 ;
reg   [2:0]  minutes_tens                  = 4 ;
reg   [2:0]  load_minutes_tens             = 6 ;

// display_clock Outputs
wire  [3:0]  out_seconds_ones              ;
wire  [3:0]  out_minutes_ones              ;
wire  [2:0]  out_seconds_tens              ;
wire  [2:0]  out_minutes_tens              ;




initial
begin
    #(PERIOD*10) set  =  1;
    #(PERIOD*5) set =   0;
end

initial begin
    #(PERIOD*11) set_id  =   'b01;
                set_num =   5;
    #(PERIOD)   set_id  =   0;
                set_num =   0;

end

initial begin
    #(PERIOD*20)
                load    =   1;
    #(PERIOD*10) 
                load    =   0;
end




display_clock  u_display_clock (
    .load                    ( load                     ),
    .set                     ( set                      ),
    .set_id                  ( set_id             [3:0] ),
    .set_num                 ( set_num            [3:0] ),
    .seconds_ones            ( seconds_ones       [3:0] ),
    .minutes_ones            ( minutes_ones       [3:0] ),
    .load_minutes_ones       ( load_minutes_ones  [3:0] ),
    .seconds_tens            ( seconds_tens       [2:0] ),
    .minutes_tens            ( minutes_tens       [2:0] ),
    .load_minutes_tens       ( load_minutes_tens  [2:0] ),

    .out_seconds_ones        ( out_seconds_ones   [3:0] ),
    .out_minutes_ones        ( out_minutes_ones   [3:0] ),
    .out_seconds_tens        ( out_seconds_tens   [2:0] ),
    .out_minutes_tens        ( out_minutes_tens   [2:0] )
);

initial
begin

    $finish;
end

endmodule