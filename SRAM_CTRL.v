module SRAM_CTRL(
    input clk,    // Clock
    input rst,  // Reset active High
    // with MEM_stage
    input [17:0] addr,
    input [31:0] data_in,
    input MEM_R_en, MEM_W_en,
    output reg [63:0] data_out,
    output freeze,
    output [1:0] cnt_out,
    // with SRAM
    inout  reg [15:0] SRAM_DQ,   //  SRAM Data bus 16 Bits
    output reg [17:0] SRAM_ADDR, //  SRAM Address bus 18 Bits
    output            SRAM_UB_N, //  SRAM High-byte Data Mask 
    output            SRAM_LB_N, //  SRAM Low-byte Data Mask 
    output reg        SRAM_WE_N, //  SRAM Write Enable
    output            SRAM_CE_N, //  SRAM Chip Enable
    output            SRAM_OE_N  //  SRAM Output Enable
);
    reg [32:0] in_mem;
    assign SRAM_UB_N = 0;
    assign SRAM_LB_N = 0;
    assign SRAM_CE_N = 0;
    assign SRAM_OE_N = ~MEM_R_en;
    always @(cnt_out) begin
        case(cnt_out)
            2'd0 : begin
                SRAM_ADDR = {9'b0, addr[9:3], 2'b00};
                data_out[15:0] = MEM_R_en ? SRAM_DQ : 16'bz;
                SRAM_DQ = MEM_W_en ? data_in[15:0] : 16'bz;
                SRAM_WE_N = ~(MEM_W_en & ~addr[2]);
            end
            2'd1 : begin
                SRAM_ADDR = {9'b0, addr[9:3], 2'b01};
                data_out[31:16] = MEM_R_en ? SRAM_DQ : 16'bz;
                SRAM_DQ = MEM_W_en ? data_in[31:16] : 16'bz;
                SRAM_WE_N = ~(MEM_W_en & ~addr[2]);
            end
            2'd2 : begin
                SRAM_ADDR = {9'b0, addr[9:3], 2'b10};
                data_out[47:32] = MEM_R_en ? SRAM_DQ : 16'bz;
                SRAM_DQ = MEM_W_en ? data_in[15:0] : 16'bz;
                SRAM_WE_N = ~(MEM_W_en & addr[2]);
            end
            2'd3 : begin
                SRAM_ADDR = {9'b0, addr[9:3], 2'b11};
                data_out[63:48] = MEM_R_en ? SRAM_DQ : 16'bz;
                SRAM_DQ = MEM_W_en ? data_in[31:16] : 16'bz;
                SRAM_WE_N = ~(MEM_W_en & addr[2]);
            end
        endcase // cnt_out
    end

    wire mem_in_use;
    assign mem_in_use = MEM_R_en | MEM_W_en;
    wire cnt_en, cnt_rst;
    Counter #(2) cnt(clk, rst, mem_in_use, cnt_out);
    assign freeze = mem_in_use && cnt_out != 2'd3;


endmodule