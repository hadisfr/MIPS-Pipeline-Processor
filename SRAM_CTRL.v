module SRAM_CTRL(
    input clk,    // Clock
    input rst,  // Asynchronous reset active High
    // with MEM_stage
    input [17:0] addr,
    input [31:0] data_in,
    input MEM_R_en, MEM_W_en,
    output [31:0] data_out,
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
    assign SRAM_UB_N = 0;
    assign SRAM_LB_N = 0;
    assign SRAM_CE_N = 0;
    assign SRAM_OE_N = ~MEM_R_en;
    assign SRAM_ADDR = {8'b0, addr[9:2], 2'b0};
    assign SRAM_WE_N = ~MEM_W_en;
    assign SRAM_DQ = MEM_W_en ? data_in[15:0] : 16'bz;
    assign data_out = MEM_R_en ? {{16{SRAM_DQ[15]}}, SRAM_DQ} : 32'bz;

    wire mem_in_use;
    assign mem_in_use = MEM_R_en | MEM_W_en;
    wire [1:0] cnt_out;
    wire cnt_en, cnt_rst;
    Counter #(2) cnt(clk, rst, mem_in_use, cnt_out);
    assign freeze = mem_in_use && cnt_out != 2'd3;


endmodule