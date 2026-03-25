# Binary FSM Pattern Detector (Structural Design)

## Overview

Finite State Machine (FSM) using binary encoding (4-bit state) to process input `w`.
The system detects specific input patterns using a shift-register-based output block.

## Features

* 4-bit binary encoded FSM (9 states)
* Structural design using D flip-flops
* Separate next-state and present-state modules
* Pattern detection for 4 consecutive bits (all 0s or all 1s)
* Synchronous design with reset support

## Structure

* `next_state`: combinational logic for state transitions
* `present_state`: state registers
* `out`: shift register and pattern detection logic
* `d_ff`: basic flip-flop unit

## Notes

* Emphasizes structural/gate-level implementation
* Demonstrates FSM design and sequential data processing
* Verified through simulation
