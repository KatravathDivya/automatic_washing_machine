
`timescale 1ns / 1ps

module automatic_washing_machine(
    input clk,
    input reset,
    input door_close,  
    input start,
    input filled, 
    input detergent_added,
    input cycle_timeout,
    
    input drained,
    input spin_timeout,

    output reg door_lock,
    output reg motor_on,
    output reg fill_valve_on,
    output reg drain_valve_on,
    output reg done,
    output reg soap_wash,
    output reg water_wash
);

// STATE DECLARATION
parameter CHECK_DOOR   = 3'b000;
parameter FILL_WATER   = 3'b001;
parameter ADD_DETERGENT= 3'b010;
parameter CYCLE        = 3'b011;
parameter DRAIN_WATER  = 3'b100;
parameter SPIN         = 3'b101;

reg [2:0] current_state, next_state;

// INTERNAL FLAGS
reg soap_done;
reg rinse_done;



// STATE REGISTER


always @(posedge clk or negedge reset)
begin
    if(!reset)
        current_state <= CHECK_DOOR;
    else
        current_state <= next_state;
end



// NEXT STATE LOGIC


always @(*)
begin
case(current_state)

CHECK_DOOR:
begin
    if(start && door_close)
        next_state = FILL_WATER;
    else
        next_state = CHECK_DOOR;
end


FILL_WATER:
begin
    if(filled)
    begin
        if(!soap_done)
            next_state = ADD_DETERGENT;
        else
            next_state = CYCLE;
    end
    else
        next_state = FILL_WATER;
end


ADD_DETERGENT:
begin
    if(detergent_added)
        next_state = CYCLE;
    else
        next_state = ADD_DETERGENT;
end


CYCLE:
begin
    if(cycle_timeout)
        next_state = DRAIN_WATER;
    else
        next_state = CYCLE;
end


DRAIN_WATER:
begin
    if(drained)
    begin
        if(!rinse_done)
            next_state = FILL_WATER;
        else
            next_state = SPIN;
    end
    else
        next_state = DRAIN_WATER;
end


SPIN:
begin
    if(spin_timeout)
        next_state = CHECK_DOOR;
    else
        next_state = SPIN;
end


default:
next_state = CHECK_DOOR;

endcase
end



// OUTPUT LOGIC


always @(*)
begin

// DEFAULT VALUES
door_lock = 0;
motor_on = 0;
fill_valve_on = 0;
drain_valve_on = 0;
done = 0;
soap_wash = soap_done;
water_wash = rinse_done;

case(current_state)

CHECK_DOOR:
begin
    door_lock = 0;
end


FILL_WATER:
begin
    door_lock = 1;
    fill_valve_on = 1;
end


ADD_DETERGENT:
begin
    door_lock = 1;
end


CYCLE:
begin
    door_lock = 1;
    motor_on = 1;
end


DRAIN_WATER:
begin
    door_lock = 1;
    drain_valve_on = 1;
end


SPIN:
begin
    door_lock = 1;
    motor_on = 1;
end

endcase
end



// SOAP AND RINSE FLAGS

always @(posedge clk or negedge reset)
begin
    if(!reset)
    begin
        soap_done <= 0;
        rinse_done <= 0;
    end
    else
    begin

        // soap wash completed
        if(current_state == ADD_DETERGENT && detergent_added)
            soap_done <= 1;

        // rinse completed
        if(current_state == DRAIN_WATER && drained && soap_done)
            rinse_done <= 1;

        // reset after full cycle
        if(current_state == SPIN && spin_timeout)
        begin
            soap_done <= 0;
            rinse_done <= 0;
        end
    end
end

endmodule
