module MEM_stage (
    input clk,    // Clock
    input rst,  // Asynchronous reset active high
    input [31:0] ALU_result,
    input [31:0] ST_val,
    input MEM_R_en, MEM_W_en,
    output [31:0] MEM_R_value
);
    assign MEM_R_value = 32'b0;
endmodule