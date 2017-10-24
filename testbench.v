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

module testbench ();
    reg clk, rst;
    /* verilator lint_off STMTDLY */
    initial begin
        rst <= 1;
        clk <= 1;
        #70 rst <= 0;
    end
    always
        #50 clk <= ~clk;
    initial
        #1000 $finish();
    initial begin
        $dumpvars;
        $monitor("PC(%5t): %h %h %h %h %h", $time, PC0[3:0], PC1[3:0], PC2[3:0], PC3[3:0], PC4[3:0]);
        // $monitor("Isntr(%5t): %h %h %h %h %h", $time, instruction0[3:0], instruction1[3:0], instruction2[3:0], instruction3[3:0], instruction4[3:0]);
    end
    /* verilator lint_on STMTDLY */
    `include "CPU.v"
endmodule
