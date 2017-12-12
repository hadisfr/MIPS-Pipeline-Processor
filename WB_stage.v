module WB_stage (
    input clk,    // Clock
    input rst,  // Reset active high
    input [31:0] ALU_result,
    input [31:0] MEM_R_value,
    input MEM_R_en,
    output [31:0] WB_value
);
    MUX #(32) MEM_R_value_MUX(MEM_R_en, ALU_result, MEM_R_value, WB_value);
endmodule