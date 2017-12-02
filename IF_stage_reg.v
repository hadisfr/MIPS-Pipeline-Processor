module IF_stage_reg (
    input clk,    // Clock
    input rst,  // Asynchronous reset active high
    input en,
    input [31:0] PC_in,
    input [31:0] instruction_in,
    output [31:0] PC,
    output [31:0] instruction
);
    Reg #(32) PC_mem(clk, rst, rst | en, PC_in, PC);
    Reg #(32) instruction_mem(clk, rst, rst | en, instruction_in, instruction);
endmodule