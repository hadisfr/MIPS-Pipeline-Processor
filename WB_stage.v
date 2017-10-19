module WB_stage (
    input clk,    // Clock
    input rst,  // Asynchronous reset active high
    input [31:0] ALU_result,
    input [31:0] MEM_R_value,
    // input [4:0] Dest_in,
    input MEM_R_en,
    //       WB_en_in,
    // output WB_en,
    output [31:0] MEM_W_value
    // output [4:0] Dest
);
    MUX #(32) MEM_R_value_MUX(MEM_R_en, ALU_result, MEM_R_value, MEM_W_value);
endmodule