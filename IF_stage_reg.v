module IF_stage_reg (
    input clk,    // Clock
    input rst,  // Asynchronous reset active high
    input flush,
    input [31:0] PC_in,
    input [31:0] instruction_in,
    input hazard_detected,
    output [31:0] PC,
    output [31:0] instruction
);
    Reg #(32) PC_mem(clk, rst || flush, ~hazard_detected, PC_in, PC);
    Reg #(32) instruction_mem(clk, rst || flush, ~hazard_detected, instruction_in, instruction);
endmodule