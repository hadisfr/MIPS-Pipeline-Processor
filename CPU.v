wire [31:0] PC0, PC1, PC2, PC3, PC4;
wire [31:0] instruction0, instruction1;
wire [3:0] EXE_cmd_1, EXE_cmd_2;
wire flush, SRAM_freeze;
wire Br_taken1, Br_taken2;
wire is_immediate, ST_or_BNE, is_branch_or_jump;
wire hazard_detected;
wire [15:0] Br_offset;
wire [4:0] MEM_src1, MEM_src2,
    MEM_src1_fd1, MEM_src2_fd1,
    MEM_src1_fd2, MEM_src2_fd2;
wire [31:0] MEM_Reg1, MEM_Reg2;
wire [4:0] dest1, dest2, dest3, dest4;
wire [31:0] Reg2_1, Val2_1, Val1_1,
            Reg2_2, Val2_2, Val1_2,
            ST_value2, ST_value3;
wire MEM_R_en_1, MEM_W_en_1, WB_en_1,
     MEM_R_en_2, MEM_W_en_2, WB_en_2,
     MEM_R_en_3, MEM_W_en_3, WB_en_3,
     MEM_R_en_4, WB_en_4;
wire [31:0] MEM_R_value3, MEM_R_value4;
wire [31:0] ALU_result2, ALU_result3, ALU_result4;
wire [31:0] WB_value;
wire [1:0] val1_s, val2_s, ST_value_s;

assign flush = Br_taken1 | Br_taken2;
assign Br_offset = Val2_2[15:0];

Register_file #(32) register_file(
        clk, rst, MEM_src1, MEM_src2, dest4, WB_value, WB_en_4,
        MEM_Reg1, MEM_Reg2
    );

Hazard_detection hazard_detection(
        MEM_src1, MEM_src2, dest2, dest3, MEM_R_en_2, MEM_R_en_3, WB_en_2, WB_en_3,
        is_immediate, ST_or_BNE, is_branch_or_jump, has_forwarding,
        hazard_detected
    );

Forwarding_unit forwarding_unit(
        MEM_src1_fd2, MEM_src2_fd2, dest2, dest3, dest4, MEM_W_en_2, WB_en_3, WB_en_4,
        val1_s, val2_s, ST_value_s
    );

IF_stage P0(
        clk, rst, Br_taken2, Br_offset, hazard_detected,
        PC0, instruction0
    );
ID_stage P1(
        clk, rst, instruction1, MEM_Reg1, MEM_Reg2, hazard_detected,
        MEM_src1, MEM_src2, MEM_src1_fd1, MEM_src2_fd1, dest1, Reg2_1, Val2_1, Val1_1,
        Br_taken1, is_immediate, ST_or_BNE, is_branch_or_jump, EXE_cmd_1, MEM_R_en_1, MEM_W_en_1, WB_en_1
    );
EXE_stage P2(
        clk, rst, Reg2_2, Val2_2, Val1_2, EXE_cmd_2, val1_s, val2_s, ST_value_s, ALU_result3, WB_value,
        ST_value2, ALU_result2
    );
MEM_stage P3(
        clk, rst, ALU_result3, ST_value3, MEM_R_en_3, MEM_W_en_3,
        MEM_R_value3, SRAM_freeze,
        SRAM_DQ, SRAM_ADDR, SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N
    );
WB_stage P4 (
        clk, rst, ALU_result4, MEM_R_value4, MEM_R_en_4,
        WB_value
    );

IF_stage_reg Q0(
        clk, rst, flush, PC0, instruction0, hazard_detected,
        PC1, instruction1
    );
ID_stage_reg Q1(
        clk, rst, PC1, MEM_src1_fd1, MEM_src2_fd1, dest1, Reg2_1, Val2_1, Val1_1, Br_taken1, EXE_cmd_1, MEM_R_en_1, MEM_W_en_1, WB_en_1,
        PC2, MEM_src1_fd2, MEM_src2_fd2, dest2, Reg2_2, Val2_2, Val1_2, Br_taken2, EXE_cmd_2, MEM_R_en_2, MEM_W_en_2, WB_en_2
    );
EXE_stage_reg Q2(
        clk, rst, PC2, ALU_result2, ST_value2, dest2, MEM_R_en_2, MEM_W_en_2, WB_en_2,
        PC3, ALU_result3, ST_value3, dest3, MEM_R_en_3, MEM_W_en_3, WB_en_3
    );
MEM_stage_reg Q3(
        clk, rst, PC3, ALU_result3, MEM_R_value3, dest3, MEM_R_en_3, WB_en_3,
        PC4, ALU_result4, MEM_R_value4, dest4, MEM_R_en_4, WB_en_4
    );
