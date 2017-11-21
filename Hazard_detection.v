module Hazard_detection (
    input [4:0] MEM_src1, MEM_src2,
    input [4:0] dest2, dest3,
    input MEM_R_en_2, MEM_R_en_3,
    input WB_en_2, WB_en_3,
    input is_immediate, ST_or_BNE, is_branch_or_jump,
    input has_forwarding,
    output hazard_detected
);
    wire hazard_detected_fd, hazard_detected_not_fd;
    wire is_MEM_src2_important = !is_immediate || ST_or_BNE;

    assign hazard_detected_not_fd = 
        (WB_en_2 && (dest2 != 5'b0) && (dest2 == MEM_src1 || (dest2 == MEM_src2 && is_MEM_src2_important)))
        || (WB_en_3 && (dest3 != 5'b0) && (dest3 == MEM_src1 || (dest3 == MEM_src2 && is_MEM_src2_important)));

    assign hazard_detected_fd =
        (
            (MEM_R_en_2 || (WB_en_2 && is_branch_or_jump))
            && (dest2 != 5'b0) && (dest2 == MEM_src1 || (dest2 == MEM_src2 && is_MEM_src2_important))
        )
        || (
            ((MEM_R_en_3 || WB_en_3) && is_branch_or_jump)
            && (dest3 != 5'b0) && (dest3 == MEM_src1 || (dest3 == MEM_src2 && is_MEM_src2_important))
        );


    MUX hazard_detected_mux(has_forwarding, hazard_detected_not_fd, hazard_detected_fd, hazard_detected);
endmodule