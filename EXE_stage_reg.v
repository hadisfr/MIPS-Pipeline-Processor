module EXE_stage_reg (
    input clk,    // Clock
    input rst,  // Asynchronous reset active high
    // input WB_EN_in,
    // input MEM_R_EN_in, MEM_W_EN_in,
    input [31:0] PC_in,
    // input [31:0] ALU_result_in,
    // input [31:0] ST_val_in,
    // input [31:0] Dest_in,
    // output reg WB_EN,
    // output reg MEM_R_EN, MEM_W_EN,
    output reg [31:0] PC
    // output reg [31:0] ALU_result,
    // output reg [31:0] ST_val,
    // output reg [31:0] Dest
);
    always @(posedge clk) begin
        if(rst) begin
            PC <= 32'b0;
            // ALU_result <= 0;
            // ST_val <= 0;
            // Dest <= 0;
            // WB_EN <= 0;
            // MEM_R_EN <= 0;
            // MEM_W_EN <= 0;
        end else begin
            PC <= PC_in;
            // ALU_result <= ALU_result_in;
            // ST_val <= ST_val_in;
            // Dest <= Dest_in;
            // WB_EN <= WB_EN_in;
            // MEM_R_EN <= MEM_R_EN_in;
            // MEM_W_EN <= MEM_W_EN_in;
        end
    end
endmodule