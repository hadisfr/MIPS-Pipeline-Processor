`timescale 1ns/1ns

`include "IF_stage.v"
`include "ID_stage.v"
`include "EXE_stage.v"
`include "MEM_stage.v"
`include "WB_stage.v"
`include "IF_stage_reg.v"
`include "ID_stage_reg.v"
`include "EXE_stage_reg.v"
`include "MEM_stage_reg.v"
`include "Adder.v"
`include "MUX.v"
`include "Reg.v"
`include "Instaruction_mem.v"
`include "Control_unit.v"
`include "Register_file.v"
`include "Sign_extend.v"
`include "Condition_check.v"
`include "ALU.v"
// `include "RAM.v"
`include "Hazard_detection.v"
`include "Forwarding_unit.v"
`include "MUX_3_1.v"
`include "SRAM_CTRL.v"
`include "Counter.v"

module testbench ();
    // reg   [15:0]  SRAM_DQ;   //  SRAM Data bus 16 Bits
    // reg   [17:0]  SRAM_ADDR; //  SRAM Address bus 18 Bits
    // reg          SRAM_UB_N; //  SRAM High-byte Data Mask 
    // reg          SRAM_LB_N; //  SRAM Low-byte Data Mask 
    // reg          SRAM_WE_N; //  SRAM Write Enable
    // reg          SRAM_CE_N; //  SRAM Chip Enable
    // reg          SRAM_OE_N;  //  SRAM Output Enable
    reg clk, rst, has_forwarding;
    /* verilator lint_off STMTDLY */
    initial begin
        rst <= 1;
        clk <= 1;
        has_forwarding <= 1;
        #70 rst <= 0;
    end
    always
        #50 clk <= ~clk;
    initial
        #27000 $finish();
    initial begin
        $dumpvars;
        $monitor("%5t: %5d", $time, PC0);
    end
    /* verilator lint_on STMTDLY */
    `include "CPU.v"
    wire [29:0] PC;
    assign PC = PC0[31:2];
endmodule
