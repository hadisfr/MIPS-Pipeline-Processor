module MEM_stage (
    input clk,    // Clock
    input rst,  // Reset active high
    input [31:0] ALU_result,
    input [31:0] ST_val,
    input MEM_R_en, MEM_W_en,
    output [31:0] MEM_R_value,
    output freeze,
    // with SRAM
    inout   [15:0]  SRAM_DQ,   //  SRAM Data bus 16 Bits
    output  [17:0]  SRAM_ADDR, //  SRAM Address bus 18 Bits
    output          SRAM_UB_N, //  SRAM High-byte Data Mask 
    output          SRAM_LB_N, //  SRAM Low-byte Data Mask 
    output          SRAM_WE_N, //  SRAM Write Enable
    output          SRAM_CE_N, //  SRAM Chip Enable
    output          SRAM_OE_N  //  SRAM Output Enable
);
    Cache_CTRL cache_ctrl (
        clk, rst,
        ALU_result[17:0], ST_val, MEM_R_en, MEM_W_en, MEM_R_value, freeze,
        SRAM_DQ, SRAM_ADDR, SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N
    );

endmodule