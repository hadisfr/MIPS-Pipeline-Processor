module EXE_stage (
    input clk,    // Clock
    input rst,  // Asynchronous reset active high
    input [31:0] val2, val1,
    input [3:0] EXE_cmd,
    output [31:0] ALU_result
);
    ALU _ALU(val1, val2, EXE_cmd, ALU_result);
endmodule