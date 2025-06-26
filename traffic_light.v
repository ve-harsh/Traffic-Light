module traffic_light(
    input C,
    input clk,  
    input rst_n, 
    // parameter HGRE_FRED=2'b00;
    // parameter HYEL_FRED = 2'b01;// Highway yellow and farm red
    // parameter HRED_FGRE=2'b10;// Highway red and farm green
    // parameter HRED_FYEL=2'b11;// Highway red and farm yellowt
    output reg [2:0] light_highway,  
    output reg [2:0] light_farm
);
    parameter HGRE_FRED=2'b00;
    parameter HYEL_FRED = 2'b01;// Highway yellow and farm red
    parameter HRED_FGRE=2'b10;// Highway red and farm green
    parameter HRED_FYEL=2'b11;
    
    reg [1:0] state, next_State;
    reg[31:0] counter;
    localparam YEL_HOLD = 4'd3; // Yellow light hold time
    localparam RED_HOLD = 4'd10;// Highway Red light hold time
    
    // State Transition Logic
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            begin
                state<=HGRE_FRED;
                counter<=0;
            end
        else 
            begin
                state<=next_State;
                if(state!=next_State) counter<=0;
                else counter<=counter+1;
            end
    end

    //Next State Logic
    always @(*) begin
        next_State = state;
        case(state)
            HGRE_FRED:
                begin
                    if(C) next_State = HYEL_FRED;
                end
            HYEL_FRED:
                begin
                    if(counter >= YEL_HOLD) next_State=HRED_FGRE;
                end
            HRED_FGRE:
                begin
                    if(counter >= RED_HOLD) next_State = HRED_FYEL;
                end
            HRED_FYEL:
                begin
                    if (C) next_State = HRED_FGRE;
                    else if (counter >= YEL_HOLD)
                        next_State = HGRE_FRED;
                end
        endcase
    end

    // Output Logic
    always @(*) begin
        case(state)
            HGRE_FRED: // green and red
                begin
                    light_highway = 3'b001;
                    light_farm = 3'b100;
                end
            HYEL_FRED: // yellow and red
                begin
                    light_highway = 3'b010;
                    light_farm = 3'b100;
                end
            HRED_FGRE: // red and green
                begin
                    light_highway= 3'b100;
                    light_farm= 3'b001;
                end
            HRED_FYEL: // red and yellow
                begin
                    light_highway=3'b100;
                    light_farm=3'b010;
                end
            default: //green and red
                begin
                    light_highway=3'b001;
                    light_farm = 3'b100;
                end
        endcase
    end


endmodule