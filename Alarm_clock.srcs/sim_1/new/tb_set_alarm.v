//~ `New testbench
`timescale  1ns / 1ps

module tb_set_alarm;

// set_alarm Parameters
parameter PERIOD  = 10;


// set_alarm Inputs
reg   signal                               = 0 ;
reg   load                                 = 0 ;
reg   moveRightBtn                         = 0 ;
reg   moveLeftBtn                          = 0 ;
reg   incrementBtn                         = 0 ;
reg   decrementBtn                         = 0 ;

// set_alarm Outputs
wire  [3:0]  load_seconds                  ;
wire  [2:0]  load_minutes                  ;


// initial
// begin
//     forever #(PERIOD/2)  clk=~clk;
// end

initial
begin
    forever #(PERIOD)   signal  =  ~signal;
end


// initial
// begin
//     #(PERIOD*2) rst_n  =  1;
// end

initial
begin

    #(PERIOD*10)   load    =   1;
    #(PERIOD*20)    load    =   0;
end

initial
begin

    #(PERIOD*11)    incrementBtn    =   1;
    #(PERIOD)    incrementBtn    =   0;

    #(PERIOD*3)    incrementBtn    =   1;
    #(PERIOD)    incrementBtn    =   0;

                
end


initial
begin

    #(PERIOD*13)    moveRightBtn    =   1;
    #(PERIOD)    moveRightBtn    =   0;

end




set_alarm  u_set_alarm (
    .signal                  ( signal              ),
    .load                    ( load                ),
    .moveRightBtn            ( moveRightBtn        ),
    .moveLeftBtn             ( moveLeftBtn         ),
    .incrementBtn            ( incrementBtn        ),
    .decrementBtn            ( decrementBtn        ),

    .load_seconds            ( load_seconds  [3:0] ),
    .load_minutes            ( load_minutes  [2:0] )
);

initial
begin

    $finish;
end

endmodule