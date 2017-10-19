module MEM_stage_reg (
    input clk,    // Clock
    input rst,  // Asynchronous reset active high
    input [31:0] PC_in,
    input [31:0] ALU_result_in,
    input [31:0] MEM_R_value_in,
    input [4:0] dest_in,
    input MEM_R_en_in, WB_en_in,
    output [31:0] PC,
    output [31:0] ALU_result,
    output [31:0] MEM_R_value,
    output [4:0] dest,
    output MEM_R_en, WB_en
);
    Reg #(32) PC_mem(clk, rst, 1'b1, PC_in, PC);
    Reg #(32) ALU_result_mem(clk, rst, 1'b1, ALU_result_in, ALU_result);
    Reg #(32) MEM_R_value_mem(clk, rst, 1'b1, MEM_R_value_in, MEM_R_value);
    Reg #(5) dest_mem(clk, rst, 1'b1, dest_in, dest);
    Reg #(1) MEM_R_en_mem(clk, rst, 1'b1, MEM_R_en_in, MEM_R_en);
    Reg #(1) WB_en_mem(clk, rst, 1'b1, WB_en_in, WB_en);
endmodule