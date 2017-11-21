module Hazard_detection (
    input [4:0] MEM_src1, MEM_src2,
    input [4:0] dest2, dest3,
    input WB_en_2, WB_en_3,
    input is_immediate, ST_or_BNE,
    input has_forwarding,
    output hazard_detected
);
    wire is_MEM_src2_important = !is_immediate || ST_or_BNE;
    assign hazard_detected = 
        (WB_en_2 && (dest2 == MEM_src1 || (dest2 == MEM_src2 && is_MEM_src2_important)))
        || (WB_en_3 && (dest3 == MEM_src1 || (dest3 == MEM_src2 && is_MEM_src2_important)));
endmodule