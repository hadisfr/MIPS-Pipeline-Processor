wire [31:0] PC0, PC1, PC2, PC3, PC4;
wire [31:0] Instruction0, Instruction1;
wire [3:0] EXE_cmd_1, EXE_cmd_2;
wire flush;
wire Br_taken1, Br_taken2;
wire [15:0] Br_offset;
wire [4:0] Dest1, Dest2, Dest3, Dest4;
wire [31:0] Reg2_1, Val2_1, Val1_1,
            Reg2_2, Val2_2, Val1_2,
            ST_value3; // previously Reg2_3
wire MEM_R_en_1, MEM_W_en_1, WB_en_1,
     MEM_R_en_2, MEM_W_en_2, WB_en_2,
     MEM_R_en_3, MEM_W_en_3, WB_en_3,
     MEM_R_en_4, WB_en_4;
wire [31:0] MEM_R_value3, MEM_R_value4,
            MEM_W_value4;
wire [31:0] ALU_result2, ALU_result3, ALU_result4;

assign flush = Br_taken1 | Br_taken2;

IF_stage P0 (
        clk, rst, Br_taken2, Br_offset,
        PC0, Instruction0
    );
ID_stage P1 (
        clk, rst, Instruction1, Dest4, MEM_W_value4, WB_en_4,
        Dest1, Reg2_1, Val2_1, Val1_1, Br_taken1, EXE_cmd_1, MEM_R_en_1, MEM_W_en_1, WB_en_1
    );
EXE_stage P2 (
        clk, rst, Val2_2, Val1_2, EXE_cmd_2,
        ALU_result2
    );
MEM_stage P3 (
        clk, rst, ALU_result3, ST_value3, MEM_R_en_3, MEM_W_en_3,
        MEM_R_value3
    );
WB_stage P4 (
        clk, rst, ALU_result4, MEM_R_value4, MEM_R_en_4,
        MEM_W_value4
    );

IF_stage_reg Q0 (
        clk, rst, flush, PC0, Instruction0,
        PC1, Instruction1
    );
ID_stage_reg Q1 (
        clk, rst, PC1, Dest1, Reg2_1, Val2_1, Val1_1, Br_taken1, EXE_cmd_1, MEM_R_en_1, MEM_W_en_1, WB_en_1,
        PC2, Dest2, Reg2_2, Val2_2, Val1_2, Br_taken2, EXE_cmd_2, MEM_R_en_2, MEM_W_en_2, WB_en_2
    );
EXE_stage_reg Q2 (
        clk, rst, PC2, ALU_result2, Reg2_2, Dest2, MEM_R_en_2, MEM_W_en_2, WB_en_2,
        PC3, ALU_result3, ST_value3, Dest3, MEM_R_en_3, MEM_W_en_3, WB_en_3
    );
MEM_stage_reg Q3 (
        clk, rst, PC3, ALU_result3, MEM_R_value3, Dest3, MEM_R_en_3, WB_en_3,
        PC4, ALU_result4, MEM_R_value4, Dest4, MEM_R_en_4, WB_en_4
    );
