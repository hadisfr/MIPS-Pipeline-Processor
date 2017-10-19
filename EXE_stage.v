module EXE_stage (
    input clk,    // Clock
    input rst,  // Asynchronous reset active high
    input [31:0] val1, val2,
    input [3:0] EXE_cmd,
    output [31:0] ALU_result
);
    assign ALU_result = 32'b0;
endmodule