module IF_stage_reg (
    input clk,    // Clock
    input rst,  // Asynchronous reset active high
    input flush,
    input [31:0] PC_in,
    input [31:0] Instruction_in,
    output [31:0] PC,
    output [31:0] Instruction
);
    Reg #(32) PC_mem(clk, rst || flush, 1'b1, PC_in, PC);
    Reg #(32) Instruction_mem(clk, rst || flush, 1'b1, Instruction_in, Instruction);
endmodule