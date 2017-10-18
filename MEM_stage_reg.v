module MEM_stage_reg (
    input clk,    // Clock
    input rst,  // Asynchronous reset active high
    input [31:0] PC_in,
    // input WB_EN_in, MEM_R_EN_in,
    // input [31:0] ALU_result_in,
    // input [31:0] MEM_read_value_in,
    // input [4:0] Dest_in,
    // output reg WB_EN, MEM_R_EN,
    // output reg [31:0] ALU_result,
    // output reg [31:0] MEM_read_value,
    // output reg [4:0] Dest
    output reg [31:0] PC
);

    always @(posedge clk) begin
        if(rst) begin
            PC <= 0;
            // WB_EN <= 0;
            // MEM_R_EN <= 0;
            // ALU_result <= 0;
            // MEM_read_value <= 0;
            // Dest <= 0;
        end else begin
            PC <= PC_in;
            // WB_EN <= WB_EN_in;
            // MEM_R_EN <= MEM_R_EN_in;
            // ALU_result <= ALU_result_in;
            // MEM_read_value <= MEM_read_value_in;
            // Dest <= Dest_in;
        end
    end

endmodule