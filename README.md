# automatic_washing_machine
Automatic Washing Machine Controller (FSM) – Verilog
## Overview

This project implements an Automatic Washing Machine Controller using a Finite State Machine (FSM) in Verilog HDL.

The controller simulates the working process of a real washing machine including water filling, washing, rinsing, draining, and spinning.

The design is intended for VLSI / FPGA learning and can be simulated using Xilinx Vivado or ModelSim.

## Objective

The objective of this project is to design a digital controller for a washing machine using sequential logic and FSM concepts.

This project demonstrates:

FSM based control design

Sequential circuit implementation

Hardware description using Verilog

## Features

FSM based washing machine controller

Automatic washing cycle

Multiple washing stages

Reset functionality

Suitable for FPGA implementation

## Washing Cycle (FSM States)

The washing machine operates through the following states:

IDLE → FILL_WATER → SOAP_WASH → WATER_WASH → DRAIN → SPIN → DONE
State Description
State	Description
IDLE	Waiting for start signal
FILL_WATER	Water fills the drum
SOAP_WASH	Detergent washing begins
WATER_WASH	Rinse cycle
DRAIN	Dirty water is drained
SPIN	Drum spins to remove water
DONE	Washing process completed
## Inputs and Outputs
Inputs:

clk – System clock

reset – Reset signal

start – Start washing process

Outputs:

door_lock – Locks the door during operation

motor_on – Controls drum rotation

fill_valve_on – Water filling control

drain_valve_on – Water drain control

soap_wash – Indicates washing stage

water_wash – Indicates rinse stage

done – Indicates cycle completion

## Tools Used

Verilog HDL

Xilinx Vivado


