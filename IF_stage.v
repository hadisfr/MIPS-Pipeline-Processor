module IF_stage (
    input clk,    // Clock
    input rst,  // Asynchronous reset active high
    input Br_taken,
    input [15:0] Br_offset,
    output [31:0] PC,
    output [31:0] instruction
);
    wire [31:0] PC_in;
    wire [15:0] PC_offset;
    wire PC_cout;
    MUX #(16) PC_MUX(Br_taken, 16'd4, Br_offset, PC_offset);
    Adder #(32) PC_Adder(PC, { 16'b0, PC_offset }, {PC_cout, PC_in});
    Reg #(32) PC_mem(clk, rst, 1'b1, PC_in, PC);
    Instaruction_mem #(32) instaruction_mem(clk, rst, PC, instruction);
endmodule