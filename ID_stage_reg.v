module ID_stage_reg (
    input clk,    // Clock
    input rst,  // Asynchronous reset active high
    // input [4:0] Dest_in,
    // input [31:0] Reg2_in, Val2_in, Val1_in,
    input [31:0] PC_in,
    // input [31:0] Instruction_in,
    // input Br_taken_in,
    // input [3:0] EXE_CMD_in,
    // input MEM_R_EN_in, MEM_W_EN_in, WB_EN_in,
    // output reg [4:0] Dest,
    // output reg [31:0] Reg2, Val2, Val1,
    output reg [31:0] PC
    // output reg [31:0] Instruction
    // output reg Br_taken,
    // output reg [3:0] EXE_CMD,
    // output reg MEM_R_EN, MEM_W_EN, WB_EN
);
    always@(posedge clk)begin
        if(rst)begin
            PC <= 0;
            // Instruction <= 0;
            // Dest <= 5'b0;
            // Reg2 <= 32'b0;
            // Val2 <= 32'b0;
            // Val1 <= 32'b0;
            // Br_taken <= 0;
            // EXE_CMD <= 4'b0;
            // MEM_W_EN <= 0;
            // MEM_R_EN <= 0;
            // WB_EN <= 0;
        end
        else begin
            PC <= PC_in;
            // Instruction <= Instruction_in;
            // Dest <= Dest_in;
            // Reg2 <= Reg2_in;
            // Val2 <= Val2_in;
            // Val1 <= Val1_in;
            // Br_taken <= Br_taken_in;
            // EXE_CMD <= EXE_CMD_in;
            // MEM_W_EN <= MEM_W_EN_in;
            // MEM_R_EN <= MEM_R_EN_in;
            // WB_EN <= WB_EN_in;
        end
    end
endmodule