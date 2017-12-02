module IF_stage (
    input clk,    // Clock
    input rst,  // Asynchronous reset active high
    input en,
    input Br_taken,
    input [15:0] Br_offset,
    output [31:0] PC,
    output [31:0] instruction
);
    wire [31:0] PC_in;
    wire [15:0] PC_offset, Br_offset_final;
    wire [31:0] PC_offset_ext;
    wire PC_cout;
    assign Br_offset_final = Br_offset - 1;
    MUX #(16) PC_MUX(Br_taken, 16'd1, Br_offset_final, PC_offset);
    Sign_extend #(16) PC_sign_extend(PC_offset, PC_offset_ext);
    Adder #(32) PC_Adder(PC, {PC_offset_ext[29:0], 2'b0}, {PC_cout, PC_in});
    Reg #(32) PC_mem(clk, rst, rst | en, PC_in, PC);
    Instaruction_mem #(32) instaruction_mem(clk, rst, PC, instruction);
endmodule