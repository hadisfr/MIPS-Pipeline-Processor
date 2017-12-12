module EXE_stage_reg (
    input clk,    // Clock
    input rst,  // Reset active high
    input en,
    input [31:0] PC_in,
    input [31:0] ALU_result_in,
    input [31:0] ST_value_in, // previously Reg2
    input [4:0] dest_in,
    input MEM_R_en_in, MEM_W_en_in, WB_en_in,
    output [31:0] PC,
    output [31:0] ALU_result,
    output [31:0] ST_value,
    output [4:0] dest,
    output MEM_R_en, MEM_W_en, WB_en
);
    Reg #(32) PC_mem(clk, rst, rst | en, PC_in, PC);
    Reg #(32) ALU_result_mem(clk, rst, rst | en, ALU_result_in, ALU_result);
    Reg #(32) ST_value_mem(clk, rst, rst | en, ST_value_in, ST_value);
    Reg #(5) dest_mem(clk, rst, rst | en, dest_in, dest);
    Reg #(1) MEM_R_en_mem(clk, rst, rst | en, MEM_R_en_in, MEM_R_en);
    Reg #(1) MEM_W_en_mem(clk, rst, rst | en, MEM_W_en_in, MEM_W_en);
    Reg #(1) WB_en_mem(clk, rst, rst | en, WB_en_in, WB_en);
endmodule