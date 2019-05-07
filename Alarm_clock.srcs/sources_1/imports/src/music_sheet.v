`timescale 1ns / 1ps

module music_sheet( 
    input [9:0] number, 
	output reg [19:0] note, // max 32 different musical notes
	output reg [4:0] duration
	);
	parameter   EIGHTH = 5'b00001;
    parameter   QUARTER = 5'b00010;//2 Hz
    parameter	HALF = 5'b00100;
    parameter	ONE = 2 * HALF;
    parameter	TWO = 2 * ONE;
    parameter	FOUR = 2 * TWO;
    parameter   A3 = 50_000_000 / 440.00,
                Csh4 = 50_000_000 / 554.37, 
                D4 = 50_000_000 / 587.33, 
                E4 = 50_000_000 / 659.25, 
                Fsh4 = 50_000_000 / 739.99, 
                G4 = 50_000_000 / 783.99,
                A4 = 50_000_000 / 880.00,
                B4 = 50_000_000 / 987.84,
                SP = 1;  
     
    always @ (number) begin
        case(number)
            0: 	    begin note = D4;        duration = QUARTER;         end
            1: 	    begin note = A3;        duration = QUARTER; 	    end
            2: 	    begin note = D4;        duration = QUARTER; 	    end
            3: 	    begin note = A4;        duration = HALF;            end
            4: 	    begin note = G4;        duration = HALF; 	        end
            5: 	    begin note = Fsh4;      duration = QUARTER; 	    end
            6:  	begin note = E4;        duration = QUARTER;         end
            7: 	    begin note = Csh4;      duration = HALF;            end
            8: 	    begin note = Csh4;      duration = QUARTER; 	    end
            9: 	    begin note = SP;        duration = ONE; 	        end
            10:     begin note = Csh4;      duration = QUARTER; 	    end
            11: 	begin note = A3;        duration = QUARTER; 	    end
            12: 	begin note = Csh4;      duration = QUARTER; 	    end
            13: 	begin note = Fsh4;      duration = HALF;            end
            14: 	begin note = E4;        duration = HALF; 	        end
            15: 	begin note = Csh4;      duration = QUARTER;         end
            16: 	begin note = D4;        duration = QUARTER;         end
            17: 	begin note = Fsh4;      duration = HALF; 	        end
            18: 	begin note = Fsh4;      duration = QUARTER;         end
            19: 	begin note = SP;        duration = ONE; 	        end
            
            20:     begin note = D4;        duration = QUARTER;         end
            21:     begin note = A3;        duration = QUARTER;         end
            22:     begin note = D4;        duration = QUARTER;         end
            23:     begin note = A4;        duration = HALF;            end
            24:     begin note = G4;        duration = HALF;            end
            25:     begin note = Fsh4;      duration = QUARTER;         end
            26:     begin note = E4;        duration = QUARTER;         end
            27:     begin note = Csh4;      duration = HALF;            end
            28:     begin note = Csh4;      duration = QUARTER;         end
            29:     begin note = SP;        duration = ONE;             end
            30:     begin note = Csh4;      duration = QUARTER;         end
            31:     begin note = A3;        duration = QUARTER;         end
            32:     begin note = Csh4;      duration = QUARTER;         end
            33:     begin note = Fsh4;      duration = HALF;            end
            34:     begin note = E4;        duration = HALF;            end
            35:     begin note = Csh4;      duration = QUARTER;         end
            36:     begin note = D4;        duration = QUARTER;         end
            37:     begin note = Fsh4;      duration = HALF;            end
            38:     begin note = Fsh4;      duration = QUARTER;         end
            39:     begin note = SP;        duration = ONE;             end
            
            40: 	begin note = Fsh4;      duration = ONE;             end
            41:     begin note = A4;        duration = ONE;             end
            42:     begin note = G4;        duration = QUARTER; 	    end
            43:     begin note = A4;        duration = QUARTER; 	    end
            44:     begin note = G4;        duration = QUARTER; 	    end
            45: 	begin note = Fsh4;      duration = QUARTER; 	    end
            46: 	begin note = E4;        duration = ONE; 	        end
            47: 	begin note = Csh4;      duration = ONE; 	        end
            48: 	begin note = E4;        duration = ONE; 	        end
            49: 	begin note = Fsh4;      duration = QUARTER; 	    end
            50: 	begin note = G4;        duration = QUARTER; 	    end
            51: 	begin note = Fsh4;      duration = QUARTER; 	    end
            52: 	begin note = E4;        duration = QUARTER; 	    end
            53: 	begin note = D4;        duration = ONE; 	        end
                        
            54: 	begin note = Fsh4;      duration = ONE;             end
            55:     begin note = A4;        duration = ONE;             end
            56:     begin note = G4;        duration = QUARTER;         end
            57:     begin note = Fsh4;      duration = QUARTER;         end
            58:     begin note = G4;        duration = QUARTER;         end
            59:     begin note = A4;        duration = QUARTER;         end
            60:     begin note = B4;        duration = ONE;             end
            61:     begin note = A4;        duration = HALF;            end
            62:     begin note = G4;        duration = QUARTER;         end
            63:     begin note = Fsh4;      duration = QUARTER;         end
            64:     begin note = G4;        duration = ONE;             end
            65:     begin note = Fsh4;      duration = QUARTER;         end
            66:     begin note = G4;        duration = QUARTER;         end
            67:     begin note = Fsh4;      duration = QUARTER;         end
            68:     begin note = E4;        duration = QUARTER;         end
            69:     begin note = D4;        duration = ONE;             end
            
            default: 	begin note = SP;    duration = ONE; 	        end
        endcase
    end
endmodule
