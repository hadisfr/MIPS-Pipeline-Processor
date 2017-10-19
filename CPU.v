wire Br_taken, flush;
wire [15:0] Br_offset;
wire [31:0] PC0, PC1, PC2, PC3, PC4;
wire [31:0] Instruction0, Instruction1, Instruction2, Instruction3, Instruction4;

IF_stage P0(clk, rst, PC0, Instruction0);
// ID_stage P1(clk, rst, PC1, Instruction0_out, );
// EXE_stage P2(clk, rst, );
// MEM_stage P3(clk, rst, );
// WB_stage P4(clk, rst, );

IF_stage_reg Q0(clk, rst, PC0, PC1);
ID_stage_reg Q1(clk, rst, PC1, PC2);
EXE_stage_reg Q2(clk, rst, PC2, PC3);
MEM_stage_reg Q3(clk, rst, PC3, PC4);
